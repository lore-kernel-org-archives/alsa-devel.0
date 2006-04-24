From: Matthias Koenig <list@phasorlab.de>
Subject: [PATCH] Support for ESI Miditerminal 4140
Date: Mon, 24 Apr 2006 19:23:22 +0200
Message-ID: <87wtdeevlh.fsf@zebra.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--=-=-=

Hello,

Here is the patch to add support for the ESI Miditerminal 4140.
Patch is against latest alsa-driver hg.

Signed-off-by: Matthias Koenig <mk@phasorlab.de>


--=-=-=
Content-Type: text/x-patch; charset=utf-8
Content-Disposition: inline; filename=mts64.patch
Content-Transfer-Encoding: quoted-printable
Content-Description: mts64 driver

diff -r 4e7af6120ca7 drivers/Kconfig
--- a/drivers/Kconfig	Fri Apr 21 12:40:49 2006 +0200
+++ b/drivers/Kconfig	Mon Apr 24 19:17:13 2006 +0200
@@ -43,3 +43,10 @@ config SND_PCSP
 	  You can compile this as a module, which will be called snd-pcsp.
=20
 	  You don't need this driver if you only want your computer to beep.
+
+config SND_MTS64
+	tristate "ESI Miditerminal 4140 driver"
+	depends on SND && PARPORT
+	select SND_RAWMIDI
+	help
+	  Say 'Y' or 'M' to include support for Miditerminal 4140.
diff -r 4e7af6120ca7 drivers/Makefile
--- a/drivers/Makefile	Fri Apr 21 12:40:49 2006 +0200
+++ b/drivers/Makefile	Mon Apr 24 19:17:13 2006 +0200
@@ -10,12 +10,13 @@ snd-serialmidi-objs :=3D serialmidi.o
 snd-serialmidi-objs :=3D serialmidi.o
 snd-aloop-objs :=3D aloop.o
 snd-portman2x4-objs :=3D portman2x4.o
+snd-mts64-objs :=3D mts64.o
=20
 obj-$(CONFIG_SND) +=3D pcsp/
=20
 obj-$(CONFIG_SND_SERIALMIDI) +=3D snd-serialmidi.o
 obj-$(CONFIG_SND_LOOPBACK) +=3D snd-aloop.o
-obj-$(CONFIG_SND_PORTMAN2X4) +=3D snd-portman2x4.o
+obj-$(CONFIG_SND_MTS64) +=3D snd-mts64.o
=20
 include $(SND_TOPDIR)/alsa-kernel/drivers/Makefile
=20
diff -r 4e7af6120ca7 drivers/mts64.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/drivers/mts64.c	Mon Apr 24 19:17:13 2006 +0200
@@ -0,0 +1,1157 @@
+/*=20=20=20=20=20
+ *   ALSA Driver for Ego Systems Inc. (ESI) Miditerminal 4140
+ *   Copyright (c) 2006 by Matthias K=C3=B6nig <mk@phasorlab.de>
+ *
+ *   This program is free software; you can redistribute it and/or modify=
=20
+ *   it under the terms of the GNU General Public License as published by=
=20
+ *   the Free Software Foundation; either version 2 of the License, or=20
+ *   (at your option) any later version.=20
+ *
+ *   This program is distributed in the hope that it will be useful,=20
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of=20
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301=
  USA
+ *
+ */
+
+#include <sound/driver.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/parport.h>
+#include <linux/spinlock.h>
+#include <linux/delay.h>
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/rawmidi.h>
+#include <sound/control.h>
+
+#define CARD_NAME "Miditerminal 4140"
+#define DRIVER_NAME "MTS64"
+#define PLATFORM_DRIVER "snd_mts64"
+
+static int index[SNDRV_CARDS]  =3D SNDRV_DEFAULT_IDX;
+static char* id[SNDRV_CARDS]   =3D SNDRV_DEFAULT_STR;
+static int enable[SNDRV_CARDS] =3D SNDRV_DEFAULT_ENABLE_PNP;
+
+static struct platform_device* platform_devices[SNDRV_CARDS];=20
+static int device_count;
+
+module_param_array(index, int, NULL, S_IRUGO);
+MODULE_PARM_DESC(index, "Index value for " CARD_NAME " soundcard.");
+module_param_array(id, charp, NULL, S_IRUGO);
+MODULE_PARM_DESC(id, "ID string for " CARD_NAME " soundcard.");
+module_param_array(enable, bool, NULL, S_IRUGO);
+MODULE_PARM_DESC(enable, "Enable " CARD_NAME " soundcard.");
+
+MODULE_AUTHOR("Matthias Koenig <mk@phasorlab.de>");
+MODULE_DESCRIPTION("ESI Miditerminal 4140");
+MODULE_LICENSE("GPL");
+MODULE_SUPPORTED_DEVICE("{{ESI,Miditerminal 4140}}");
+
+/*********************************************************************
+ * Chip specific
+ *********************************************************************/
+#define MTS64_NUM_INPUT_PORTS 5
+#define MTS64_NUM_OUTPUT_PORTS 4
+#define MTS64_SMPTE_SUBSTREAM 4
+
+struct mts64 {
+	spinlock_t lock;
+	struct snd_card* card;
+	snd_rawmidi_t* rmidi;
+	struct pardevice* pardev;
+	int pardev_claimed;
+
+	int open_count;
+	int current_midi_output_port;
+	int current_midi_input_port;
+	unsigned char mode[MTS64_NUM_INPUT_PORTS];
+	snd_rawmidi_substream_t* midi_input_substream[MTS64_NUM_INPUT_PORTS];
+	int smpte_switch;
+	unsigned char time[4]; /* [0]=3Dhh, [1]=3Dmm, [2]=3Dss, [3]=3Dff */
+	unsigned char fps;
+};
+
+static int snd_mts64_free(struct mts64* mts)
+{
+	kfree(mts);
+	return 0;
+}
+
+static int __devinit snd_mts64_create(struct snd_card* card,=20
+				      struct pardevice* pardev,=20
+				      struct mts64** rchip)
+{
+	struct mts64* mts;
+	int i;
+
+	*rchip =3D NULL;
+
+	mts =3D kzalloc(sizeof(struct mts64), GFP_KERNEL);
+	if(mts =3D=3D NULL)=20
+		return -ENOMEM;
+
+	/* Init chip specific data */
+	spin_lock_init(&mts->lock);
+	mts->card =3D card;
+	mts->rmidi =3D NULL;      /* initialized later in mts64_attach */
+	mts->pardev =3D pardev;
+	mts->pardev_claimed =3D 0;
+	mts->open_count =3D 0;
+	mts->current_midi_output_port =3D -1;
+	mts->current_midi_input_port =3D -1;
+	for(i=3D0; i<MTS64_NUM_INPUT_PORTS; ++i)
+		mts->mode[i] =3D 0;
+	/* SMPTE */
+	mts->smpte_switch =3D 0;
+	mts->time[0] =3D 0;
+	mts->time[1] =3D 0;
+	mts->time[2] =3D 0;
+	mts->time[3] =3D 0;
+	mts->fps =3D 0;
+
+	*rchip =3D mts;
+
+	return 0;
+}
+
+/*********************************************************************
+ * HW register related constants
+ *********************************************************************/
+
+/* Status Bits */
+#define MTS64_STAT_BSY             0x80
+#define MTS64_STAT_BIT_SET         0x20  /* readout process, bit is set */
+#define MTS64_STAT_PORT            0x10  /* read byte is a port number */
+
+/* Control Bits */
+#define MTS64_CTL_READOUT          0x08  /* enable readout */
+#define MTS64_CTL_WRITE_CMD        0x06=20=20
+#define MTS64_CTL_WRITE_DATA       0x02=20=20
+#define MTS64_CTL_STROBE           0x01=20=20
+
+/* Command */
+#define MTS64_CMD_RESET            0xfe
+#define MTS64_CMD_PROBE            0x8f  /* Used in probing procedure */
+#define MTS64_CMD_SMPTE_SET_TIME   0xe8
+#define MTS64_CMD_SMPTE_SET_FPS    0xee
+#define MTS64_CMD_SMPTE_STOP       0xef
+#define MTS64_CMD_SMPTE_FPS_24     0xe3
+#define MTS64_CMD_SMPTE_FPS_25     0xe2
+#define MTS64_CMD_SMPTE_FPS_2997   0xe4=20
+#define MTS64_CMD_SMPTE_FPS_30D    0xe1
+#define MTS64_CMD_SMPTE_FPS_30     0xe0
+#define MTS64_CMD_COM_OPEN         0xf8  /* setting the communication mode=
 */
+#define MTS64_CMD_COM_CLOSE1       0xff  /* clearing communication mode */
+#define MTS64_CMD_COM_CLOSE2       0xf5
+
+/*********************************************************************
+ * Hardware specific functions
+ *********************************************************************/
+static void mts64_enable_readout(struct parport* p);
+static void mts64_disable_readout(struct parport* p);
+static int mts64_device_ready(struct parport* p);
+static int mts64_device_init(struct parport* p);
+static int mts64_device_open(struct mts64* mts);
+static int mts64_device_close(struct mts64* mts);
+static unsigned char mts64_map_midi_input(unsigned char c);
+static int mts64_probe(struct parport* p);
+static unsigned short mts64_read(struct parport* p);
+static unsigned char mts64_read_char(struct parport* p);
+static void mts64_smpte_start(struct parport* p,
+			      unsigned char hours, unsigned char minutes,
+			      unsigned char seconds, unsigned char frames,
+			      unsigned char idx);
+static void mts64_smpte_stop(struct parport* p);
+static void mts64_write_command(struct parport* p, unsigned char c);
+static void mts64_write_data(struct parport* p, unsigned char c);
+static void mts64_write_midi(struct mts64* mts, unsigned char c, int midip=
ort);
+
+
+/*  Enables the readout procedure
+ *
+ *  Before we can read a midi byte from the device, we have to set
+ *  bit 3 of control port.
+ */
+static void mts64_enable_readout(struct parport* p)
+{
+	unsigned char c;
+
+	c =3D parport_read_control(p);
+	c |=3D MTS64_CTL_READOUT;
+	parport_write_control(p, c);=20
+}
+
+/*  Disables readout=20
+ *
+ *  Readout is disabled by clearing bit 3 of control
+ */
+static void mts64_disable_readout(struct parport* p)
+{
+	unsigned char c;
+
+	c =3D parport_read_control(p);
+	c &=3D ~MTS64_CTL_READOUT;
+	parport_write_control(p, c);
+}
+
+/*  waits for device ready
+ *
+ *  Checks if BUSY (Bit 7 of status) is clear
+ *  1 device ready
+ *  0 failure
+ */
+static int mts64_device_ready(struct parport* p)
+{
+	int i;
+	unsigned char c;
+
+	for(i=3D0; i < 0xffff; ++i) {
+		c =3D parport_read_status(p);
+		c &=3D MTS64_STAT_BSY;
+		if(c !=3D 0) return 1;
+	}=20
+
+	return 0;
+}
+
+/*  Init device (LED blinking startup magic)
+ *
+ *  Returns:
+ *  1 init ok
+ *  0 failure
+ */
+static int mts64_device_init(struct parport* p)
+{
+	int i;
+
+	mts64_write_command(p, MTS64_CMD_RESET);
+
+	for(i=3D0; i < 64; ++i) {
+		mdelay(100);
+
+		if(mts64_probe(p)) {
+			/* success */
+			mts64_disable_readout(p);
+			return 1;
+		}
+	}
+
+	mts64_disable_readout(p);
+	return 0;
+}
+
+/*=20
+ *  Opens the device (set communication mode) and increases the=20
+ *  reference count.
+ */
+static int mts64_device_open(struct mts64* mts)
+{
+	int i;
+	struct parport* p =3D mts->pardev->port;
+
+	if(mts->open_count =3D=3D 0) {
+		for(i=3D0; i<5; ++i)
+			mts64_write_command(p, MTS64_CMD_COM_OPEN);
+	}
+
+	++(mts->open_count);
+=09
+	/* FIXME: Busy wait really necessary? */
+	mdelay(50);
+
+	return 0;
+}
+
+/*=20=20
+ *  Close device and decrement reference count.
+ */
+static int mts64_device_close(struct mts64* mts)
+{
+	int i;
+	struct parport* p =3D mts->pardev->port;
+
+	--(mts->open_count);
+	if(mts->open_count =3D=3D 0) {
+		for(i=3D0; i<5; ++i) {
+			mts64_write_command(p, MTS64_CMD_COM_CLOSE1);
+			mts64_write_command(p, MTS64_CMD_COM_CLOSE2);
+		}
+	} else if(mts->open_count < 0) {
+		mts->open_count =3D 0;
+	}
+
+	/* FIXME: Busy wait really necessary? */
+	mdelay(500);
+
+	return 0;
+}
+
+/*  map hardware port to substream number
+ *=20
+ *  When reading a byte from the device, the device tells us
+ *  on what port the byte is. This HW port has to be mapped to
+ *  the midiport (substream number).
+ *  substream 0-3 are Midiports 1-4
+ *  substream 4 is SMPTE Timecode
+ *  The mapping is done by the table:
+ *  HW | 0 | 1 | 2 | 3 | 4=20
+ *  SW | 0 | 1 | 4 | 2 | 3
+ */
+static unsigned char mts64_map_midi_input(unsigned char c)
+{
+	unsigned char map[] =3D { 0, 1, 4, 2, 3 };
+
+	return map[c];
+}
+
+
+/*  Probe parport for device
+ *
+ *  Do we have a Miditerminal 4140 on parport?=20
+ *  Returns:
+ *  1 device found
+ *  0 no device
+ */
+static int mts64_probe(struct parport* p)
+{
+	unsigned char c;
+
+	mts64_smpte_stop(p);
+
+	mts64_write_command(p, MTS64_CMD_PROBE);
+
+	/* FIXME */
+	mdelay(50);
+=09
+	c =3D mts64_read(p);
+
+	c &=3D 0x00ff;
+	if(c !=3D MTS64_CMD_PROBE) return 0;
+	else return 1;
+
+}
+
+/*  Read a byte from device
+ *
+ *  Read byte incl. status from device
+ *
+ *  Returns:
+ *  data in lower 8 bits and status in upper 8 bits
+ */
+static unsigned short mts64_read(struct parport* p)
+{
+	unsigned char data, status;
+
+	mts64_device_ready(p);
+	mts64_enable_readout(p);
+	status =3D parport_read_status(p);
+	data =3D mts64_read_char(p);
+	mts64_disable_readout(p);
+
+	return (status << 8) | data;
+}
+
+/*  Read a byte from device
+ *
+ *  Note, that readout mode has to be enabled.
+ *  readout procedure is as follows:=20
+ *  - Write number of the Bit to read to DATA
+ *  - Read STATUS
+ *  - Bit 5 of STATUS indicates if Bit is set
+ *
+ *  Returns:
+ *  Byte read from device
+ */
+static unsigned char mts64_read_char(struct parport* p)
+{
+	unsigned char c =3D 0;
+	unsigned char st;
+	unsigned char i;
+
+	for(i=3D0; i<8; ++i) {
+		parport_write_data(p, i);
+		c >>=3D 1;
+		st =3D parport_read_status(p);
+		if(st & MTS64_STAT_BIT_SET)=20
+			c |=3D 0x80;
+	}
+=09
+	return c;
+}
+
+/*  Starts SMPTE Timecode generation
+ *
+ *  The device creates SMPTE Timecode by hardware.
+ *  0 24 fps
+ *  1 25 fps
+ *  2 29.97 fps
+ *  3 30 fps (Drop-frame)
+ *  4 30 fps
+ */
+static void mts64_smpte_start(struct parport* p,
+			      unsigned char hours, unsigned char minutes,
+			      unsigned char seconds, unsigned char frames,
+			      unsigned char idx)
+{
+	unsigned char fps[5] =3D { MTS64_CMD_SMPTE_FPS_24,=20
+				 MTS64_CMD_SMPTE_FPS_25,
+				 MTS64_CMD_SMPTE_FPS_2997,=20
+				 MTS64_CMD_SMPTE_FPS_30D,
+				 MTS64_CMD_SMPTE_FPS_30    };
+
+	mts64_write_command(p, MTS64_CMD_SMPTE_SET_TIME);
+	mts64_write_command(p, frames);
+	mts64_write_command(p, seconds);
+	mts64_write_command(p, minutes);
+	mts64_write_command(p, hours);
+
+	mts64_write_command(p, MTS64_CMD_SMPTE_SET_FPS);
+	mts64_write_command(p, fps[idx]);
+}
+
+/*  Stops SMPTE Timecode generation
+ */
+static void mts64_smpte_stop(struct parport* p)
+{
+	mts64_write_command(p, MTS64_CMD_SMPTE_STOP);
+}
+
+/*  Write a command byte to device
+ */
+static void mts64_write_command(struct parport* p, unsigned char c)
+{
+	mts64_device_ready(p);
+
+	parport_write_data(p, c);
+
+	parport_write_control(p, MTS64_CTL_WRITE_CMD);
+	parport_write_control(p, MTS64_CTL_WRITE_CMD | MTS64_CTL_STROBE);
+	parport_write_control(p, MTS64_CTL_WRITE_CMD);
+}
+
+/*  Write a data byte to device=20
+ */
+static void mts64_write_data(struct parport* p, unsigned char c)
+{
+	mts64_device_ready(p);
+
+	parport_write_data(p, c);
+
+	parport_write_control(p, MTS64_CTL_WRITE_DATA);
+	parport_write_control(p, MTS64_CTL_WRITE_DATA | MTS64_CTL_STROBE);
+	parport_write_control(p, MTS64_CTL_WRITE_DATA);
+}
+
+/*  Write a MIDI byte to midiport
+ *
+ *  midiport ranges from 0-3 and maps to Ports 1-4
+ *  assumptions: communication mode is on
+ *=20=20
+ */
+static void mts64_write_midi(struct mts64* mts, unsigned char c,
+			     int midiport)
+{
+	struct parport* p =3D mts->pardev->port;
+
+	/* check current midiport */
+	if(mts->current_midi_output_port !=3D midiport) {
+		mts64_write_command(p, midiport);
+	}
+
+	/* write midi byte */
+	mts64_write_data(p, c);
+}
+
+/*********************************************************************
+ * Control elements
+ *********************************************************************/
+
+/* SMPTE Switch */
+static int snd_mts64_ctl_smpte_switch_info(snd_kcontrol_t *kctl,
+					   snd_ctl_elem_info_t* uinfo)
+{
+	uinfo->type =3D SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count =3D 1;
+	uinfo->value.integer.min =3D 0;
+	uinfo->value.integer.max =3D 1;
+	return 0;
+}
+
+static int snd_mts64_ctl_smpte_switch_get(snd_kcontrol_t* kctl,
+					  snd_ctl_elem_value_t* uctl)
+{
+	struct mts64* mts =3D snd_kcontrol_chip(kctl);
+=09
+	uctl->value.integer.value[0] =3D mts->smpte_switch;
+	return 0;
+}
+
+static int snd_mts64_ctl_smpte_switch_put(snd_kcontrol_t* kctl,
+					  snd_ctl_elem_value_t* uctl)
+{
+	struct mts64* mts =3D snd_kcontrol_chip(kctl);
+	int changed =3D 0;
+	unsigned long flags;
+
+	if(mts->smpte_switch =3D=3D uctl->value.integer.value[0])
+		return changed;
+
+	changed =3D 1;
+	mts->smpte_switch =3D uctl->value.integer.value[0];
+	if(mts->smpte_switch) {
+		spin_lock_irqsave(mts->lock, flags);
+		mts64_smpte_start(mts->pardev->port,
+				  mts->time[0], mts->time[1],
+				  mts->time[2], mts->time[3],
+				  mts->fps);
+		spin_unlock_irqrestore(mts->lock, flags);
+	} else {
+		spin_lock_irqsave(mts->lock, flags);
+		mts64_smpte_stop(mts->pardev->port);
+		spin_unlock_irqrestore(mts->lock, flags);
+	}
+
+	return changed;
+}
+
+static snd_kcontrol_new_t mts64_ctl_smpte_switch __devinitdata =3D {
+	.iface =3D SNDRV_CTL_ELEM_IFACE_RAWMIDI,
+	.name  =3D "SMPTE Playback Switch",
+	.index =3D 0,
+	.access =3D SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.private_value =3D 0,
+	.info =3D snd_mts64_ctl_smpte_switch_info,
+	.get  =3D snd_mts64_ctl_smpte_switch_get,
+	.put  =3D snd_mts64_ctl_smpte_switch_put
+};
+
+/* Time */
+static int snd_mts64_ctl_smpte_time_h_info(snd_kcontrol_t* kctl,
+					   snd_ctl_elem_info_t* uinfo)
+{
+	uinfo->type =3D SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count =3D 1;
+	uinfo->value.integer.min =3D 0;
+	uinfo->value.integer.max =3D 23;
+	return 0;
+}
+
+static int snd_mts64_ctl_smpte_time_f_info(snd_kcontrol_t* kctl,
+					   snd_ctl_elem_info_t* uinfo)
+{
+	uinfo->type =3D SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count =3D 1;
+	uinfo->value.integer.min =3D 0;
+	uinfo->value.integer.max =3D 99;
+	return 0;
+}
+
+static int snd_mts64_ctl_smpte_time_info(snd_kcontrol_t* kctl,
+					 snd_ctl_elem_info_t* uinfo)
+{
+	uinfo->type =3D SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count =3D 1;
+	uinfo->value.integer.min =3D 0;
+	uinfo->value.integer.max =3D 59;
+	return 0;
+}
+
+static int snd_mts64_ctl_smpte_time_get(snd_kcontrol_t* kctl,
+					snd_ctl_elem_value_t* uctl)
+{
+	struct mts64* mts =3D snd_kcontrol_chip(kctl);
+	int idx =3D kctl->private_value;
+
+	uctl->value.integer.value[0] =3D mts->time[idx];
+	return 0;
+}
+
+static int snd_mts64_ctl_smpte_time_put(snd_kcontrol_t* kctl,
+					snd_ctl_elem_value_t* uctl)
+{
+	struct mts64* mts =3D snd_kcontrol_chip(kctl);
+	int idx =3D kctl->private_value;
+	int changed =3D 0;
+
+	if(mts->time[idx] !=3D uctl->value.integer.value[0]) {
+		changed =3D 1;
+		mts->time[idx] =3D uctl->value.integer.value[0];
+	}
+
+	return changed;
+}
+
+static snd_kcontrol_new_t mts64_ctl_smpte_time_hours __devinitdata =3D {
+	.iface =3D SNDRV_CTL_ELEM_IFACE_RAWMIDI,
+	.name  =3D "SMPTE Time Hours",
+	.index =3D 0,
+	.access =3D SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.private_value =3D 0,
+	.info =3D snd_mts64_ctl_smpte_time_h_info,
+	.get  =3D snd_mts64_ctl_smpte_time_get,
+	.put  =3D snd_mts64_ctl_smpte_time_put
+};
+
+static snd_kcontrol_new_t mts64_ctl_smpte_time_minutes __devinitdata =3D {
+	.iface =3D SNDRV_CTL_ELEM_IFACE_RAWMIDI,
+	.name  =3D "SMPTE Time Minutes",
+	.index =3D 0,
+	.access =3D SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.private_value =3D 1,
+	.info =3D snd_mts64_ctl_smpte_time_info,
+	.get  =3D snd_mts64_ctl_smpte_time_get,
+	.put  =3D snd_mts64_ctl_smpte_time_put
+};
+
+static snd_kcontrol_new_t mts64_ctl_smpte_time_seconds __devinitdata =3D {
+	.iface =3D SNDRV_CTL_ELEM_IFACE_RAWMIDI,
+	.name  =3D "SMPTE Time Seconds",
+	.index =3D 0,
+	.access =3D SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.private_value =3D 2,
+	.info =3D snd_mts64_ctl_smpte_time_info,
+	.get  =3D snd_mts64_ctl_smpte_time_get,
+	.put  =3D snd_mts64_ctl_smpte_time_put
+};
+
+static snd_kcontrol_new_t mts64_ctl_smpte_time_frames __devinitdata =3D {
+	.iface =3D SNDRV_CTL_ELEM_IFACE_RAWMIDI,
+	.name  =3D "SMPTE Time Frames",
+	.index =3D 0,
+	.access =3D SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.private_value =3D 3,
+	.info =3D snd_mts64_ctl_smpte_time_f_info,
+	.get  =3D snd_mts64_ctl_smpte_time_get,
+	.put  =3D snd_mts64_ctl_smpte_time_put
+};
+
+/* FPS */
+static int snd_mts64_ctl_smpte_fps_info(snd_kcontrol_t* kctl,
+					snd_ctl_elem_info_t* uinfo)
+{
+	char* texts[5] =3D { "24",
+			   "25",
+			   "29.97",
+			   "30D",
+			   "30"    };
+
+	uinfo->type =3D SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count =3D 1;
+	uinfo->value.enumerated.items =3D 5;
+	if(uinfo->value.enumerated.item > 4)
+		uinfo->value.enumerated.item =3D 4;
+	strcpy(uinfo->value.enumerated.name,
+	       texts[uinfo->value.enumerated.item]);
+=09
+	return 0;
+}
+
+static int snd_mts64_ctl_smpte_fps_get(snd_kcontrol_t* kctl,
+				       snd_ctl_elem_value_t* uctl)
+{
+	struct mts64* mts =3D snd_kcontrol_chip(kctl);
+
+	uctl->value.enumerated.item[0] =3D mts->fps;
+	return 0;
+}
+
+static int snd_mts64_ctl_smpte_fps_put(snd_kcontrol_t* kctl,
+					snd_ctl_elem_value_t* uctl)
+{
+	struct mts64* mts =3D snd_kcontrol_chip(kctl);
+	int changed =3D 0;
+
+	if(mts->fps !=3D uctl->value.enumerated.item[0]) {
+		changed =3D 1;
+		mts->fps =3D uctl->value.enumerated.item[0];
+	}
+	return changed;
+}
+
+static snd_kcontrol_new_t mts64_ctl_smpte_fps __devinitdata =3D {
+	.iface =3D SNDRV_CTL_ELEM_IFACE_RAWMIDI,
+	.name  =3D "SMPTE Fps",
+	.index =3D 0,
+	.access =3D SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.private_value =3D 0,
+	.info  =3D snd_mts64_ctl_smpte_fps_info,
+	.get   =3D snd_mts64_ctl_smpte_fps_get,
+	.put   =3D snd_mts64_ctl_smpte_fps_put
+};
+
+
+static int __devinit snd_mts64_ctl_create(struct snd_card* card,=20
+					  struct mts64* mts)=20
+{
+	int err;
+
+	err =3D snd_ctl_add(card,=20
+			  snd_ctl_new1(&mts64_ctl_smpte_switch, mts));
+	if(err < 0) {
+		snd_printk("Cannot create control: smpte_switch\n");
+		return err;
+	}
+
+	err =3D snd_ctl_add(card,=20
+			  snd_ctl_new1(&mts64_ctl_smpte_time_hours, mts));
+	if(err < 0) {
+		snd_printk("Cannot create control: smpte_time_hours\n");
+		return err;
+	}
+	err =3D snd_ctl_add(card,=20
+			  snd_ctl_new1(&mts64_ctl_smpte_time_minutes, mts));
+	if(err < 0) {
+		snd_printk("Cannot create control: smpte_time_minutes\n");
+		return err;
+	}
+	err =3D snd_ctl_add(card,=20
+			  snd_ctl_new1(&mts64_ctl_smpte_time_seconds, mts));
+	if(err < 0) {
+		snd_printk("Cannot create control: smpte_time_seconds\n");
+		return err;
+	}
+	err =3D snd_ctl_add(card,=20
+			  snd_ctl_new1(&mts64_ctl_smpte_time_frames, mts));
+	if(err < 0) {
+		snd_printk("Cannot create control: smpte_time_frames\n");
+		return err;
+	}
+
+	err =3D snd_ctl_add(card,=20
+			  snd_ctl_new1(&mts64_ctl_smpte_fps, mts));
+	if(err < 0) {
+		snd_printk("Cannot create control: smpte_fps\n");
+		return err;
+	}
+
+	return 0;
+}
+
+/*********************************************************************
+ * Rawmidi
+ *********************************************************************/
+#define MTS64_MODE_INPUT_TRIGGERED 0x01
+
+static int snd_mts64_rawmidi_output_open(snd_rawmidi_substream_t* substrea=
m)
+{
+	struct mts64* mts =3D substream->rmidi->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(mts->lock, flags);
+	mts64_device_open(mts);
+	spin_unlock_irqrestore(mts->lock, flags);
+
+	return 0;
+}
+
+static int snd_mts64_rawmidi_output_close(snd_rawmidi_substream_t* substre=
am)
+{
+	struct mts64* mts =3D substream->rmidi->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(mts->lock, flags);
+	mts64_device_close(mts);
+	spin_unlock_irqrestore(mts->lock, flags);
+
+	return 0;
+}
+
+static void snd_mts64_rawmidi_output_trigger(snd_rawmidi_substream_t* subs=
tream,
+					     int up)
+{
+	struct mts64* mts =3D substream->rmidi->private_data;
+	unsigned char data;
+	unsigned long flags;
+
+	spin_lock_irqsave(mts->lock, flags);
+	while(snd_rawmidi_transmit_peek(substream, &data, 1) =3D=3D 1) {
+		mts64_write_midi(mts, data, substream->number+1);
+		snd_rawmidi_transmit_ack(substream, 1);
+	}
+	spin_unlock_irqrestore(mts->lock, flags);
+}
+
+static int snd_mts64_rawmidi_input_open(snd_rawmidi_substream_t* substream)
+{
+	struct mts64* mts =3D substream->rmidi->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(mts->lock, flags);
+	mts64_device_open(mts);
+	spin_unlock_irqrestore(mts->lock, flags);
+
+	return 0;
+}
+
+static int snd_mts64_rawmidi_input_close(snd_rawmidi_substream_t* substrea=
m)
+{
+	struct mts64* mts =3D substream->rmidi->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(mts->lock, flags);
+	mts64_device_close(mts);
+	spin_unlock_irqrestore(mts->lock, flags);
+
+	return 0;
+}
+
+static void snd_mts64_rawmidi_input_trigger(snd_rawmidi_substream_t* subst=
ream,
+					    int up)
+{
+	struct mts64* mts =3D substream->rmidi->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(mts->lock, flags);=09
+	if(up) {
+		mts->mode[substream->number] |=3D MTS64_MODE_INPUT_TRIGGERED;
+	} else {
+		mts->mode[substream->number] &=3D ~MTS64_MODE_INPUT_TRIGGERED;
+	}
+	spin_unlock_irqrestore(mts->lock, flags);
+}
+
+static snd_rawmidi_ops_t snd_mts64_rawmidi_output_ops =3D {
+	.open    =3D snd_mts64_rawmidi_output_open,
+	.close   =3D snd_mts64_rawmidi_output_close,
+	.trigger =3D snd_mts64_rawmidi_output_trigger
+};
+
+static snd_rawmidi_ops_t snd_mts64_rawmidi_input_ops =3D {
+	.open    =3D snd_mts64_rawmidi_input_open,
+	.close   =3D snd_mts64_rawmidi_input_close,
+	.trigger =3D snd_mts64_rawmidi_input_trigger
+};
+
+/* Create and initialize the rawmidi component */
+static int __devinit snd_mts64_rawmidi_create(struct snd_card* card,=20
+					      struct mts64* chip,=20
+					      snd_rawmidi_t** rrmidi)
+{
+	snd_rawmidi_t* rmidi;
+	snd_rawmidi_substream_t* substream;
+	struct list_head* list;
+	int err;
+=09
+	*rrmidi =3D NULL;
+
+	err =3D snd_rawmidi_new(card, CARD_NAME, 0,=20
+			      MTS64_NUM_OUTPUT_PORTS,=20
+			      MTS64_NUM_INPUT_PORTS,=20
+			      &rmidi);
+	if(err < 0) return err;
+
+	rmidi->private_data =3D chip;
+	strcpy(rmidi->name, CARD_NAME);
+	rmidi->info_flags =3D SNDRV_RAWMIDI_INFO_OUTPUT |
+		            SNDRV_RAWMIDI_INFO_INPUT |
+                            SNDRV_RAWMIDI_INFO_DUPLEX;
+
+	/* register rawmidi ops */
+	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT,=20
+			    &snd_mts64_rawmidi_output_ops);
+	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT,=20
+			    &snd_mts64_rawmidi_input_ops);
+
+	/* name substreams */
+	/* output */
+	list_for_each(list,=20
+		      &rmidi->streams[SNDRV_RAWMIDI_STREAM_OUTPUT].substreams) {
+		substream =3D list_entry(list, snd_rawmidi_substream_t, list);
+		sprintf(substream->name,
+			"Miditerminal %d", substream->number+1);
+	}
+	/* input */
+	list_for_each(list,=20
+		      &rmidi->streams[SNDRV_RAWMIDI_STREAM_INPUT].substreams) {
+		substream =3D list_entry(list, snd_rawmidi_substream_t, list);
+		chip->midi_input_substream[substream->number] =3D substream;
+		switch(substream->number) {
+		case MTS64_SMPTE_SUBSTREAM:
+			strcpy(substream->name, "Miditerminal SMPTE");
+			break;
+		default:
+			sprintf(substream->name,
+				"Miditerminal %d", substream->number+1);
+		}
+	}
+
+	/* controls */
+	snd_mts64_ctl_create(card, chip);
+
+	*rrmidi =3D rmidi;
+	return 0;
+}
+
+/*********************************************************************
+ * parport stuff
+ *********************************************************************/
+static void mts64_interrupt(int irq, void* private, struct pt_regs* r)
+{
+	struct mts64* mts =3D ((struct snd_card*)private)->private_data;
+	unsigned long flags;
+	unsigned short ret;
+	unsigned char status, data;
+	snd_rawmidi_substream_t* substream;
+
+	spin_lock_irqsave(mts->lock, flags);
+	ret =3D mts64_read(mts->pardev->port);
+	data =3D ret & 0x00ff;
+	status =3D ret >> 8;
+
+	if(status & MTS64_STAT_PORT) {
+		mts->current_midi_input_port =3D mts64_map_midi_input(data);
+	} else {
+		substream =3D mts->midi_input_substream[mts->current_midi_input_port];
+		if(mts->mode[substream->number] & MTS64_MODE_INPUT_TRIGGERED)
+			snd_rawmidi_receive(substream, &data, 1);
+	}
+	spin_unlock_irqrestore(mts->lock, flags);
+}
+
+static int __devinit mts64_probe_port(struct parport* p)
+{
+	struct pardevice* pardev;
+	int res;
+	unsigned long flags;
+
+	pardev =3D parport_register_device(p, DRIVER_NAME,
+					 NULL, NULL, NULL,
+					 0, NULL);
+	if(!pardev)
+		goto __err;
+=09
+	if(parport_claim(pardev))
+		goto __err1;
+
+	local_irq_save(flags);
+	res =3D mts64_probe(p);
+	local_irq_restore(flags);
+
+	parport_release(pardev);
+	parport_unregister_device(pardev);
+
+	return res;
+=09
+__err1:
+	parport_unregister_device(pardev);
+__err:
+	return 0;
+}
+
+static void __devinit mts64_attach(struct parport* p)
+{
+	struct platform_device* device;
+
+	device =3D platform_device_alloc(PLATFORM_DRIVER, device_count);
+	if(!device)=20
+		return;
+
+	/* Temporary assignment to forward the parport */
+	platform_set_drvdata(device, p);
+
+	if(platform_device_register(device) < 0) {
+		platform_device_put(device);
+		return;
+	}
+
+	/* Since we dont get the return value of probe
+	 * We need to check if device probing succeeded or not */
+	if(!platform_get_drvdata(device)) {
+		platform_device_unregister(device);
+		return;
+	}
+
+	/* register device in global table */
+	platform_devices[device_count] =3D device;
+	device_count++;
+}
+
+static void mts64_detach(struct parport* p)
+{
+	/* nothing to do here */
+}
+
+static struct parport_driver mts64_parport_driver =3D {
+	.name   =3D "mts64",
+	.attach =3D mts64_attach,
+	.detach =3D mts64_detach
+};
+
+/*********************************************************************
+ * platform stuff
+ *********************************************************************/
+static int __devinit snd_mts64_probe(struct platform_device* pdev)
+{
+	struct pardevice* pardev;
+	struct parport* p;
+	int dev =3D pdev->id;
+	struct snd_card* card =3D NULL;
+	struct mts64* mts =3D NULL;
+	snd_rawmidi_t* rmidi =3D NULL;
+	int err;
+	unsigned long flags;
+
+	p =3D platform_get_drvdata(pdev);
+	platform_set_drvdata(pdev, NULL);
+
+	if(dev >=3D SNDRV_CARDS) {
+		return -ENODEV;
+	}
+	if(!enable[dev]) {
+		return -ENOENT;
+	}
+
+	if(!mts64_probe_port(p)) {
+		return -ENODEV;
+	}
+
+	card =3D snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
+	if(card =3D=3D NULL) {
+		snd_printd("Cannot create card\n");
+		err =3D -ENOMEM;
+		goto __err;
+	}
+	strcpy(card->driver, DRIVER_NAME);
+	strcpy(card->shortname, "ESI " CARD_NAME);
+	sprintf(card->longname,  "%s at 0x%lx, irq %i",=20
+		card->shortname, p->base, p->irq);
+=09
+	pardev =3D parport_register_device(p,                 /* port */
+					 DRIVER_NAME,       /* name */
+					 NULL,              /* preempt */
+					 NULL,              /* wakeup */
+					 mts64_interrupt,   /* ISR */
+					 PARPORT_DEV_EXCL,  /* flags */
+					 (void*)card);      /* private */
+	if(pardev =3D=3D NULL) {
+		snd_printd("Cannot register pardevice\n");
+		err =3D -EIO;
+		goto __err_free_card;
+	}
+
+	if((err =3D snd_mts64_create(card, pardev, &mts)) < 0) {
+		snd_printd("Cannot create main component\n");
+		goto __err_free_device;
+	}
+	card->private_data =3D mts;
+=09
+	if((err =3D snd_mts64_rawmidi_create(card, mts, &rmidi)) < 0) {
+		snd_printd("Creating Rawmidi component failed\n");
+		goto __err_free_device;
+	}
+
+	mts->rmidi =3D rmidi;
+
+	/* claim parport */
+	if(parport_claim(pardev)) {
+		snd_printk("Cannot claim parport 0x%lx\n", pardev->port->base);
+		err =3D -EIO;
+		goto __err_free_device;
+	}
+	mts->pardev_claimed =3D 1;
+
+	/* init device */
+	local_irq_save(flags);
+	mts64_device_init(p);
+	local_irq_restore(flags);
+
+	platform_set_drvdata(pdev, card);
+
+	/* At this point card will be usable */
+	if((err =3D snd_card_register(card)) < 0) {
+		snd_printk("Cannot register card\n");
+		goto __err_release;
+	}
+
+	snd_printk("ESI Miditerminal 4140 on 0x%lx\n", p->base);
+	return 0;
+
+__err_release:
+	parport_release(pardev);
+	mts->pardev_claimed =3D 0;
+__err_free_device:
+	parport_unregister_device(pardev);
+__err_free_card:
+	snd_card_free(card);
+__err:
+	return err;
+
+}
+
+static int snd_mts64_remove(struct platform_device* pdev)
+{
+	struct snd_card* card =3D platform_get_drvdata(pdev);
+	struct mts64* mts =3D card->private_data;
+	struct pardevice* pardev =3D mts->pardev;
+
+	if(card) {
+		snd_card_free(card);
+		snd_mts64_free(mts);
+	}
+	if(pardev) {
+		if(mts->pardev_claimed)
+			parport_release(pardev);
+		parport_unregister_device(pardev);
+	}
+
+	return 0;
+}
+
+
+static struct platform_driver snd_mts64_driver =3D {
+	.probe  =3D snd_mts64_probe,
+	.remove =3D snd_mts64_remove,
+	.driver =3D {
+		.name =3D PLATFORM_DRIVER
+	}
+};
+
+/*********************************************************************
+ * module init stuff
+ *********************************************************************/
+static void mts64_unregister_all(void)
+{
+	int i;
+
+	for(i=3D0; i<SNDRV_CARDS; ++i) {
+		if(platform_devices[i]) {
+			platform_device_unregister(platform_devices[i]);
+			platform_devices[i] =3D NULL;
+		}
+	}=09=09
+	platform_driver_unregister(&snd_mts64_driver);
+	parport_unregister_driver(&mts64_parport_driver);
+}
+
+static int __init mts64_module_init(void)
+{
+	int err;
+
+	if((err =3D platform_driver_register(&snd_mts64_driver)) < 0)
+		return err;
+
+	if(parport_register_driver(&mts64_parport_driver) !=3D 0) {
+		platform_driver_unregister(&snd_mts64_driver);
+		return -EIO;
+	}
+
+	if(device_count =3D=3D 0) {
+		mts64_unregister_all();
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void __exit mts64_module_exit(void)
+{
+	mts64_unregister_all();
+}
+
+module_init(mts64_module_init);
+module_exit(mts64_module_exit);

--=-=-=--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
