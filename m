From: Matthias Koenig <mkoenig@suse.de>
Subject: [PATCH] alsa-driver: portman2x4 code cleanup
Date: Wed, 24 Jan 2007 16:28:09 +0100
Message-ID: <n7xr6tksauu.fsf@sor.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mx1.suse.de (mx1.suse.de [195.135.220.2])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 07E2711B
	for <alsa-devel@alsa-project.org>; Wed, 24 Jan 2007 16:29:19 +0100 (MET)
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id BC265122EC
	for <alsa-devel@alsa-project.org>; Wed, 24 Jan 2007 16:29:18 +0100 (CET)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

--=-=-=

Hi,

here is the long announced cleanup of the portman2x4 driver code,
please review.

Thanks,
Matthias

Signed-off-by: Matthias Koenig <mkoenig@suse.de>
============================================================
Summary: portman2x4 code cleanup

- changed code structure to mirror the one of the mts64.c driver 
  for better maintenance
- added proper handling of platform device
- general cleanup (no CamelCase names)


--=-=-=
Content-Type: text/x-patch; charset=utf-8
Content-Disposition: inline; filename=portman2x4.patch
Content-Transfer-Encoding: quoted-printable

diff -r cd59e9f6118e drivers/portman2x4-kernel.c
--- a/drivers/portman2x4-kernel.c	Thu Jan 18 12:09:34 2007 +0100
+++ b/drivers/portman2x4-kernel.c	Wed Jan 24 15:46:08 2007 +0100
@@ -18,74 +18,108 @@
  *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
  * ChangeLog
- * Feb 20 2004 Tobias Gehrig <tobias@gehrig.tk>
- *      - ported from alsa 0.5 to 1.0
- * Mar 17 2004 Tobias Gehrig <tobias@gehrig.tk>
- *      - added checks for opened input device in interrupt handler
- * Mar 18 2004 Tobias Gehrig <tobias@gehrig.tk>
- *      - added parport_unregister_driver to the startup routine if the dr=
iver fails to detect a portman
- *      - added support for all 4 output ports in portman_putmidi
- * Mar 24 2004 Tobias Gehrig <tobias@gehrig.tk>
- *      - added 2.6 kernel support
+ * Jan 24 2007 Matthias Koenig <mkoenig@suse.de>
+ *      - cleanup and rewrite
+ * Sep 30 2004 Tobias Gehrig <tobias@gehrig.tk>
+ *      - source code cleanup
  * Sep 03 2004 Tobias Gehrig <tobias@gehrig.tk>
  *      - fixed compilation problem with alsa 1.0.6a (removed MODULE_CLASS=
ES,
  *        MODULE_PARM_SYNTAX and changed MODULE_DEVICES to
  *        MODULE_SUPPORTED_DEVICE)
- * Sep 30 2004 Tobias Gehrig <tobias@gehrig.tk>
- *      - source code cleanup
+ * Mar 24 2004 Tobias Gehrig <tobias@gehrig.tk>
+ *      - added 2.6 kernel support
+ * Mar 18 2004 Tobias Gehrig <tobias@gehrig.tk>
+ *      - added parport_unregister_driver to the startup routine if the dr=
iver fails to detect a portman
+ *      - added support for all 4 output ports in portman_putmidi
+ * Mar 17 2004 Tobias Gehrig <tobias@gehrig.tk>
+ *      - added checks for opened input device in interrupt handler
+ * Feb 20 2004 Tobias Gehrig <tobias@gehrig.tk>
+ *      - ported from alsa 0.5 to 1.0
  */
=20
 #include <sound/driver.h>
 #include <linux/init.h>
-#include <linux/moduleparam.h>
+#include <linux/platform_device.h>
+#include <linux/parport.h>
+#include <linux/spinlock.h>
+#include <linux/delay.h>
 #include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/rawmidi.h>
 #include <sound/control.h>
-#include <sound/rawmidi.h>
-#include <sound/initval.h>
-#include <linux/parport.h>
-#include <linux/delay.h>
-#include <sound/memalloc.h>
-
-#define chip_t portman_t
+
+#define CARD_NAME "Portman 2x4"
+#define DRIVER_NAME "portman"
+#define PLATFORM_DRIVER "snd_portman2x4"
+
+static int index[SNDRV_CARDS]  =3D SNDRV_DEFAULT_IDX;
+static char *id[SNDRV_CARDS]   =3D SNDRV_DEFAULT_STR;
+static int enable[SNDRV_CARDS] =3D SNDRV_DEFAULT_ENABLE_PNP;
+
+static struct platform_device *platform_devices[SNDRV_CARDS];=20
+static int device_count;
+
+module_param_array(index, int, NULL, S_IRUGO);
+MODULE_PARM_DESC(index, "Index value for " CARD_NAME " soundcard.");
+module_param_array(id, charp, NULL, S_IRUGO);
+MODULE_PARM_DESC(id, "ID string for " CARD_NAME " soundcard.");
+module_param_array(enable, bool, NULL, S_IRUGO);
+MODULE_PARM_DESC(enable, "Enable " CARD_NAME " soundcard.");
=20
 MODULE_AUTHOR("Levent G=C3=BCndogdu, Tobias Gehrig");
 MODULE_DESCRIPTION("Midiman Portman2x4");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Midiman,Portman2x4}}");
=20
-static int index[SNDRV_CARDS] =3D SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
-static char *id[SNDRV_CARDS] =3D SNDRV_DEFAULT_STR;	/* ID for this card */
-static int enable[SNDRV_CARDS] =3D SNDRV_DEFAULT_ENABLE;	/* Enable switche=
s */
-
-module_param_array(index, int, NULL, 0444);
-MODULE_PARM_DESC(index, "Index value for Portman2x4 midi interface.");
-module_param_array(id, charp, NULL, 0444);
-MODULE_PARM_DESC(id, "ID string for Portman2x4 midi interface.");
-module_param_array(enable, bool, NULL, 0444);
-MODULE_PARM_DESC(enable, "Enable Portman2x4 midi interface.");
-
-typedef struct _snd_portman portman_t;
-
-static portman_t *portman;
-
-struct _snd_portman {
+/*********************************************************************
+ * Chip specific
+ *********************************************************************/
+#define PORTMAN_NUM_INPUT_PORTS 2
+#define PORTMAN_NUM_OUTPUT_PORTS 4
+
+struct portman {
 	spinlock_t reg_lock;
-
 	struct snd_card *card;
-	int irq;
-	unsigned long port;
-
-	unsigned char midi_input_mode[2];
-	unsigned char midi_output_mode[4];
-
 	struct snd_rawmidi *rmidi;
-	struct snd_rawmidi_substream *midi_input[2];
-	struct snd_rawmidi_substream *midi_output[4];
+	struct pardevice *pardev;
+	int pardev_claimed;
+
+	int open_count;
+	int mode[PORTMAN_NUM_INPUT_PORTS];
+	struct snd_rawmidi_substream *midi_input[PORTMAN_NUM_INPUT_PORTS];
 };
=20
-/* Definitions for portman driver */
-#define	BYTE           unsigned char
-#define WORD           unsigned int
+static int portman_free(struct portman *pm)
+{
+	kfree(pm);
+	return 0;
+}
+
+static int __devinit portman_create(struct snd_card *card,=20
+				    struct pardevice *pardev,=20
+				    struct portman **rchip)
+{
+	struct portman *pm;
+
+	*rchip =3D NULL;
+
+	pm =3D kzalloc(sizeof(struct portman), GFP_KERNEL);
+	if (pm =3D=3D NULL)=20
+		return -ENOMEM;
+
+	/* Init chip specific data */
+	spin_lock_init(&pm->reg_lock);
+	pm->card =3D card;
+	pm->pardev =3D pardev;
+
+	*rchip =3D pm;
+
+	return 0;
+}
+
+/*********************************************************************
+ * HW related constants
+ *********************************************************************/
=20
 /* Standard PC parallel port status register equates. */
 #define	PP_STAT_BSY   	0x80	/* Busy status.  Inverted. */
@@ -153,66 +187,40 @@ struct _snd_portman {
 #define	A1_ECHO         PP_STAT_BSY	/* Address 1 Echo.            1 1 0 */
 #define	A2_ECHO         PP_STAT_BSY	/* Address 2 Echo.            1 1 1 */
=20
-#define PORTMAN2X4_MODE_INPUT_OPENED	 0x01
-#define PORTMAN2X4_MODE_OUTPUT_OPENED	 0x02
-#define PORTMAN2X4_MODE_INPUT_TRIGGERED	 0x04
-#define PORTMAN2X4_MODE_OUTPUT_TRIGGERED 0x08
-
-
-/* Pointer to parallel port which we actually use */
-static struct parport *myPort =3D NULL;
-
-/* Pointer to pardevice after registration */
-static struct pardevice *myParDevice =3D NULL;
-
-/* static struct parport_operations *myParPortOps =3D NULL; */
-static int portowned =3D 0;
-static int portman_found =3D 0;
-
-/* Delay settings */
-static int gwAddressDelay =3D 0;
-static int gwDataDelay =3D 0;
-
-/* Useful information */
-static char *sDeviceName =3D "portman2x4";
-static char *sVersion =3D "0.1";
-
-/* State+Cleanup variables */
-static unsigned char SAVE_PORTCOMMAND =3D 0;
-static unsigned char SAVE_PORTDATA =3D 0;
-static unsigned char SAVE_PORTVALID =3D 0;
-
-/* parallel port access mappers */
-
-static inline void portman_writeCommand(unsigned char value)
-{
-	parport_write_control(myPort, value);
-}
-
-static inline unsigned char portman_readCommand(void)
-{
-	return parport_read_control(myPort);
-}
-
-static inline unsigned char portman_readStatus(void)
-{
-	return parport_read_status(myPort);
-}
-
-static inline unsigned char portman_readData(void)
-{
-	return parport_read_data(myPort);
-}
-
-static inline void portman_writeData(unsigned char value)
-{
-	parport_write_data(myPort, value);
-}
-
-static void portman_putmidi(int port, unsigned char mididata)
+#define PORTMAN2X4_MODE_INPUT_TRIGGERED	 0x01
+
+/*********************************************************************
+ * Hardware specific functions
+ *********************************************************************/
+static inline void portman_write_command(struct portman *pm, u8 value)
+{
+	parport_write_control(pm->pardev->port, value);
+}
+
+static inline u8 portman_read_command(struct portman *pm)
+{
+	return parport_read_control(pm->pardev->port);
+}
+
+static inline u8 portman_read_status(struct portman *pm)
+{
+	return parport_read_status(pm->pardev->port);
+}
+
+static inline u8 portman_read_data(struct portman *pm)
+{
+	return parport_read_data(pm->pardev->port);
+}
+
+static inline void portman_write_data(struct portman *pm, u8 value)
+{
+	parport_write_data(pm->pardev->port, value);
+}
+
+static void portman_write_midi(struct portman *pm,=20
+			       int port, u8 mididata)
 {
 	int command =3D ((port + 4) << 1);
-	unsigned long flags;
=20
 	/* Get entering data byte and port number in BL and BH respectively.
 	 * Set up Tx Channel address field for use with PP Cmd Register.
@@ -230,185 +238,148 @@ static void portman_putmidi(int port, un
 	 * PP Command Reg.  Do not set the Strobe signal yet.
 	 */
=20
-      hbpTxWait:
-	local_irq_save(flags);
-	portman_writeCommand(command);
-	udelay(gwAddressDelay);
-
-	/* While the address lines settle, write parallel output data to=20
-	 * PP Data Reg.  This has no effect until Strobe signal is asserted.
-	 */
-
-	portman_writeData(mididata);
-
-	udelay(gwDataDelay);
-
-	/* If PCP channel's TxEmpty is set (TxEmpty is read through the PP
-	 * Status Register), then go write data.  Else go back and wait.
-	 */
-
-	if ((portman_readStatus() & TXEMPTY) =3D=3D TXEMPTY) /* Is channel's TxEm=
pty set? */
-		goto hpbEmpty;	                         /* Y: Go write data then. */
-
-	local_irq_restore(flags);                        /* Allow small window fo=
r ints. */
-	goto hbpTxWait;
+	do {
+		portman_write_command(pm, command);
+
+		/* While the address lines settle, write parallel output data to=20
+		 * PP Data Reg.  This has no effect until Strobe signal is asserted.
+		 */
+
+		portman_write_data(pm, mididata);
+=09=09
+		/* If PCP channel's TxEmpty is set (TxEmpty is read through the PP
+		 * Status Register), then go write data.  Else go back and wait.
+		 */
+	} while ((portman_read_status(pm) & TXEMPTY) !=3D TXEMPTY);
=20
 	/* TxEmpty is set.  Maintain PC/P destination address and assert
 	 * Strobe through the PP Command Reg.  This will Strobe data into
 	 * the PC/P transmitter and set the PC/P BUSY signal.
 	 */
=20
-      hpbEmpty:
-	portman_writeCommand(command | STROBE);
-	udelay(gwAddressDelay);
+	portman_write_command(pm, command | STROBE);
=20
 	/* Wait for strobe line to settle and echo back through hardware.
 	 * Once it has echoed back, assume that the address and data lines
 	 * have settled!
 	 */
=20
-	while ((portman_readStatus() & ESTB) =3D=3D 0);
+	while ((portman_read_status(pm) & ESTB) =3D=3D 0);
=20
 	/* Release strobe and immediately re-allow interrupts. */
-	portman_writeCommand(command);
-	udelay(gwAddressDelay);
-	local_irq_restore(flags);
-
-	while ((portman_readStatus() & ESTB) =3D=3D ESTB);
+	portman_write_command(pm, command);
+
+	while ((portman_read_status(pm) & ESTB) =3D=3D ESTB);
=20
 	/* PC/P BUSY is now set.  We must wait until BUSY resets itself.
 	 * We'll reenable ints while we're waiting.
 	 */
=20
-	while ((portman_readStatus() & BUSY) =3D=3D BUSY);
+	while ((portman_read_status(pm) & BUSY) =3D=3D BUSY);
=20
 	/* Data sent. */
 }
=20
=20
-static unsigned char portman_readmidi(int port)
-{
-  /***********************************************************************=
****
-   * Attempt to read input byte from specified hardware input port (0..).
-   * Return -1 if no data.
-   ***********************************************************************=
****/
-
-	unsigned char midiValue =3D 0;
+/*
+ *  Read MIDI byte from port
+ *  Attempt to read input byte from specified hardware input port (0..).
+ *  Return -1 if no data
+ */
+static int portman_read_midi(struct portman *pm, int port)
+{
+	unsigned char midi_data =3D 0;
 	unsigned char cmdout;	/* Saved address+IE bit. */
=20
 	/* Make sure clocking edge is down before starting... */
-	portman_writeData(0);	/* Make sure edge is down. */
-	udelay(gwDataDelay);	/* Settle clock. */
+	portman_write_data(pm, 0);	/* Make sure edge is down. */
=20
 	/* Set destination address to PCP. */
 	cmdout =3D (port << 1) | INT_EN;	/* Address + IE + No Strobe. */
-	portman_writeCommand(cmdout);
-	udelay(gwAddressDelay);	/* Address settle. */
-
-	while ((portman_readStatus() & ESTB) =3D=3D ESTB);	/* Wait for strobe ech=
o. */
+	portman_write_command(pm, cmdout);
+
+	while ((portman_read_status(pm) & ESTB) =3D=3D ESTB);	/* Wait for strobe =
echo. */
=20
 	/* After the address lines settle, check multiplexed RxAvail signal.
 	 * If data is available, read it.
 	 */
-	if ((portman_readStatus() & RXAVAIL) =3D=3D 0)
+	if ((portman_read_status(pm) & RXAVAIL) =3D=3D 0)
 		return -1;	/* No data. */
=20
 	/* Set the Strobe signal to enable the Rx clocking circuitry. */
-	portman_writeCommand(cmdout | STROBE);	/* Write address+IE+Strobe. */
-	udelay(gwAddressDelay);	/* Strobe settle. */
-
-	while ((portman_readStatus() & ESTB) =3D=3D 0); /* Wait for strobe echo. =
*/
+	portman_write_command(pm, cmdout | STROBE);	/* Write address+IE+Strobe. */
+
+	while ((portman_read_status(pm) & ESTB) =3D=3D 0); /* Wait for strobe ech=
o. */
=20
 	/* The first data bit (msb) is already sitting on the input line. */
-	midiValue =3D (portman_readStatus() & 128);
-	portman_writeData(1);	/* Cause rising edge, which shifts data. */
-	udelay(gwDataDelay);	/* Settle clock. */
-
+	midi_data =3D (portman_read_status(pm) & 128);
+	portman_write_data(pm, 1);	/* Cause rising edge, which shifts data. */
=20
 	/* Data bit 6. */
-	portman_writeData(0);	/* Cause falling edge while data settles. */
-	udelay(gwDataDelay);	/* Settle clock. */
-	midiValue =3D midiValue | ((portman_readStatus() >> 1) & 64);
-	portman_writeData(1);	/* Cause rising edge, which shifts data. */
-	udelay(gwDataDelay);	/* Settle clock. */
+	portman_write_data(pm, 0);	/* Cause falling edge while data settles. */
+	midi_data |=3D (portman_read_status(pm) >> 1) & 64;
+	portman_write_data(pm, 1);	/* Cause rising edge, which shifts data. */
=20
 	/* Data bit 5. */
-	portman_writeData(0);	/* Cause falling edge while data settles. */
-	udelay(gwDataDelay);	/* Settle clock. */
-	midiValue =3D midiValue | ((portman_readStatus() >> 2) & 32);
-	portman_writeData(1);	/* Cause rising edge, which shifts data. */
-	udelay(gwDataDelay);	/* Settle clock. */
+	portman_write_data(pm, 0);	/* Cause falling edge while data settles. */
+	midi_data |=3D (portman_read_status(pm) >> 2) & 32;
+	portman_write_data(pm, 1);	/* Cause rising edge, which shifts data. */
=20
 	/* Data bit 4. */
-	portman_writeData(0);	/* Cause falling edge while data settles. */
-	udelay(gwDataDelay);	/* Settle clock. */
-	midiValue =3D midiValue | ((portman_readStatus() >> 3) & 16);
-	portman_writeData(1);	/* Cause rising edge, which shifts data. */
-	udelay(gwDataDelay);	/* Settle clock. */
+	portman_write_data(pm, 0);	/* Cause falling edge while data settles. */
+	midi_data |=3D (portman_read_status(pm) >> 3) & 16;
+	portman_write_data(pm, 1);	/* Cause rising edge, which shifts data. */
=20
 	/* Data bit 3. */
-	portman_writeData(0);	/* Cause falling edge while data settles. */
-	udelay(gwDataDelay);	/* Settle clock. */
-	midiValue =3D midiValue | ((portman_readStatus() >> 4) & 8);
-	portman_writeData(1);	/* Cause rising edge, which shifts data. */
-	udelay(gwDataDelay);	/* Settle clock. */
+	portman_write_data(pm, 0);	/* Cause falling edge while data settles. */
+	midi_data |=3D (portman_read_status(pm) >> 4) & 8;
+	portman_write_data(pm, 1);	/* Cause rising edge, which shifts data. */
=20
 	/* Data bit 2. */
-	portman_writeData(0);	/* Cause falling edge while data settles. */
-	udelay(gwDataDelay);	/* Settle clock. */
-	midiValue =3D midiValue | ((portman_readStatus() >> 5) & 4);
-	portman_writeData(1);	/* Cause rising edge, which shifts data. */
-	udelay(gwDataDelay);	/* Settle clock. */
+	portman_write_data(pm, 0);	/* Cause falling edge while data settles. */
+	midi_data |=3D (portman_read_status(pm) >> 5) & 4;
+	portman_write_data(pm, 1);	/* Cause rising edge, which shifts data. */
=20
 	/* Data bit 1. */
-	portman_writeData(0);	/* Cause falling edge while data settles. */
-	udelay(gwDataDelay);	/* Settle clock. */
-	midiValue =3D midiValue | ((portman_readStatus() >> 6) & 2);
-	portman_writeData(1);	/* Cause rising edge, which shifts data. */
-	udelay(gwDataDelay);	/* Settle clock. */
+	portman_write_data(pm, 0);	/* Cause falling edge while data settles. */
+	midi_data |=3D (portman_read_status(pm) >> 6) & 2;
+	portman_write_data(pm, 1);	/* Cause rising edge, which shifts data. */
=20
 	/* Data bit 0. */
-	portman_writeData(0);	/* Cause falling edge while data settles. */
-	udelay(gwDataDelay);	/* Settle clock. */
-	midiValue =3D midiValue | ((portman_readStatus() >> 7) & 1);
-	portman_writeData(1);	/* Cause rising edge, which shifts data. */
-	udelay(gwDataDelay);	/* Settle clock. */
-	portman_writeData(0);	/* Return data clock low. */
-	udelay(gwDataDelay);	/* Settle clock. */
+	portman_write_data(pm, 0);	/* Cause falling edge while data settles. */
+	midi_data |=3D (portman_read_status(pm) >> 7) & 1;
+	portman_write_data(pm, 1);	/* Cause rising edge, which shifts data. */
+	portman_write_data(pm, 0);	/* Return data clock low. */
=20
=20
 	/* De-assert Strobe and return data. */
-	portman_writeCommand(cmdout);	/* Output saved address+IE. */
-	udelay(gwAddressDelay);	/* Settle clock. */
+	portman_write_command(pm, cmdout);	/* Output saved address+IE. */
=20
 	/* Wait for strobe echo. */
-	while ((portman_readStatus() & ESTB) =3D=3D ESTB);
-
-	return (midiValue & 255);	/* Shift back and return value. */
+	while ((portman_read_status(pm) & ESTB) =3D=3D ESTB);
+
+	return (midi_data & 255);	/* Shift back and return value. */
 }
=20
 /*
  *  Checks if any input data on the given channel is available
  *  Checks RxAvail=20
  */
-
-static int portman_dataavail(int channel)
+static int portman_data_avail(struct portman *pm, int channel)
 {
 	int command =3D INT_EN;
 	switch (channel) {
 	case 0:
-		command =3D command | RXDATA0;
+		command |=3D RXDATA0;
 		break;
 	case 1:
-		command =3D command | RXDATA1;
+		command |=3D RXDATA1;
 		break;
 	}
 	/* Write hardware (assumme STROBE=3D0) */
-	portman_writeCommand(command);
-	/* Allow settling. */
-	udelay(gwAddressDelay);
+	portman_write_command(pm, command);
 	/* Check multiplexed RxAvail signal */
-	if ((portman_readStatus() & RXAVAIL) =3D=3D RXAVAIL)
+	if ((portman_read_status(pm) & RXAVAIL) =3D=3D RXAVAIL)
 		return 1;	/* Data available */
=20
 	/* No Data available */
@@ -419,11 +390,10 @@ static int portman_dataavail(int channel
 /*
  *  Flushes any input
  */
-
-static void portman_flushInput(unsigned char port)
+static void portman_flush_input(struct portman *pm, unsigned char port)
 {
 	/* Local variable for counting things */
-	unsigned int iCounter =3D 0;
+	unsigned int i =3D 0;
 	unsigned char command =3D 0;
=20
 	switch (port) {
@@ -434,171 +404,45 @@ static void portman_flushInput(unsigned=20
 		command =3D RXDATA1;
 		break;
 	default:
-		snd_printk("portman_flushInput() Won't flush port %i\n",
+		snd_printk("portman_flush_input() Won't flush port %i\n",
 			   port);
 		return;
 	}
=20
 	/* Set address for specified channel in port and allow to settle. */
-	portman_writeCommand(command);
-	udelay(gwAddressDelay);
+	portman_write_command(pm, command);
=20
 	/* Assert the Strobe and wait for echo back. */
-	portman_writeCommand(command | STROBE);
+	portman_write_command(pm, command | STROBE);
=20
 	/* Wait for ESTB */
-	while ((portman_readStatus() & ESTB) =3D=3D 0)
-	  udelay(gwAddressDelay);
-
-
+	while ((portman_read_status(pm) & ESTB) =3D=3D 0)
+		;
=20
 	/* Output clock cycles to the Rx circuitry. */
-	portman_writeData(0);
-	udelay(gwDataDelay);
+	portman_write_data(pm, 0);
=20
 	/* Flush 250 bits... */
-	for (iCounter =3D 0; iCounter < 250; iCounter++) {
-		udelay(gwDataDelay);
-		portman_writeData(1);
-		udelay(gwDataDelay);
-		portman_writeData(0);
+	for (i =3D 0; i < 250; i++) {
+		portman_write_data(pm, 1);
+		portman_write_data(pm, 0);
 	}
=20
 	/* Deassert the Strobe signal of the port and wait for it to settle. */
-	portman_writeCommand(command | INT_EN);
+	portman_write_command(pm, command | INT_EN);
=20
 	/* Wait for settling */
-	while ((portman_readStatus() & ESTB) =3D=3D ESTB)
-	  udelay(gwAddressDelay);
-}
-
-
-/* clean up code */
-
-static void cleanup(void)
-{
-	/* local data */
-	unsigned long flags;
-
-	/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-	 * CLEANUP PARALLELPORT
-	 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-	 */
-
-	/* check if port was owned by this driver */
-	if (portowned =3D=3D 1) {
-		/* restore port state */
-
-		/* Disable interrupt while giving up port */
-		local_irq_save(flags);
-
-		/* Restore parallel port status */
-		if (SAVE_PORTVALID =3D=3D 1) {
-
-			portman_writeCommand(SAVE_PORTCOMMAND);
-			portman_writeData(SAVE_PORTDATA);
-		}
-
-		parport_release(myParDevice);
-		portowned =3D 0;
-
-		/* Reenable interrupts */
-		local_irq_restore(flags);
-	}
-
-	if (myParDevice !=3D NULL) {
-		parport_unregister_device(myParDevice);
-		myParDevice =3D NULL;
-	}
-
-	/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-	 * CLEANUP KERNEL MEMORY & DEVICE REGISTRATION
-	 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-	 */
-
-	kfree(portman);
-	portman =3D NULL;
-}
-
-/* irq handler */
-
-
-/*
- * IRQ-HANDLER
- *
- * @param  int              Number of IRQ
- * @param  void*            User data (struct parport* related to this int=
errupt)
- * @param  struct pt_regs*  Pointer to pt_regs
- */
-
-#if LINUX_VERSION_CODE >=3D KERNEL_VERSION(2, 6, 19)
-static void portman_handler_irq(int irq, void *userdata)
-#else
-static void portman_handler_irq(int irq, void *userdata, struct pt_regs *r=
egs)
-#endif
-{
-	unsigned long flags;
-	/* Test if output gets written if interrupts are disabled! */
-	unsigned char midivalue =3D 0;
-
-	/* Disable interrupts (we must not be disturbed while processing here...)=
 */
-	local_irq_save(flags);
-
-	/* While any input data is waiting */
-	while ((portman_readStatus() & INT_REQ) =3D=3D INT_REQ) {
-		/* If data available on channel 0, read it and stuff it into the queue. =
*/
-		if (portman_dataavail(0)) {
-			/* Read Midi */
-			midivalue =3D portman_readmidi(0);
-			/* put midi into queue... */
-			if (portman->
-			    midi_input_mode[0] &
-			    PORTMAN2X4_MODE_INPUT_TRIGGERED)
-				snd_rawmidi_receive(portman->midi_input[0],
-						    &midivalue, 1);
-
-		}
-		/* If data available on channel 1, read it and stuff it into the queue. =
*/
-		if (portman_dataavail(1)) {
-			/* Read Midi */
-			midivalue =3D portman_readmidi(1);
-			/* put midi into queue... */
-			if (portman->
-			    midi_input_mode[1] &
-			    PORTMAN2X4_MODE_INPUT_TRIGGERED)
-				snd_rawmidi_receive(portman->midi_input[1],
-						    &midivalue, 1);
-		}
-
-	}
-
-	/* Reenable interrupts */
-	local_irq_restore(flags);
-}
-
-/* portman detection function */
-
-/*************************************************************************=
***
- *  Initialize the MIDI driver software and port hardware.
- *
- *  Inputs:     BASE =3D Base I/O address of port.
- *              IRQ  =3D IRQ number.
- *
- *  Returns:    0  if successful.
- *	       1     Strobe echo failure.
- *	       2     Transmitter stuck.
- *************************************************************************=
***/
-
-static int hwOpen(void)
-{
-	int delay =3D gwAddressDelay;
-
+	while ((portman_read_status(pm) & ESTB) =3D=3D ESTB)
+		;
+}
+
+static int portman_probe(struct parport *p)
+{
 	/* Initialize the parallel port data register.  Will set Rx clocks
 	 * low in case we happen to be addressing the Rx ports at this time.
 	 */
 	/* 1 */
-	portman_writeData(0);
-	udelay(delay);
+	parport_write_data(p, 0);
=20
 	/* Initialize the parallel port command register, thus initializing
 	 * hardware handshake lines to midi box:
@@ -607,406 +451,417 @@ static int hwOpen(void)
 	 *                                  Interrupt Enable =3D 0=20=20=20=20=20=
=20=20=20=20=20=20=20
 	 */
 	/* 2 */
-	portman_writeCommand(0);
-	udelay(delay);
+	parport_write_control(p, 0);
=20
 	/* Check if Portman PC/P 2x4 is out there. */
 	/* 3 */
-	portman_writeCommand(RXDATA0);	/* Write Strobe=3D0 to command reg. */
-	udelay(delay);
+	parport_write_control(p, RXDATA0);	/* Write Strobe=3D0 to command reg. */
=20
 	/* Check for ESTB to be clear */
 	/* 4 */
-	if ((portman_readStatus() & ESTB) =3D=3D ESTB)
+	if ((parport_read_status(p) & ESTB) =3D=3D ESTB)
 		return 1;	/* CODE 1 - Strobe Failure. */
=20
 	/* Set for RXDATA0 where no damage will be done. */
 	/* 5 */
-	portman_writeCommand(RXDATA0 + STROBE);	/* Write Strobe=3D1 to command re=
g. */
-	udelay(delay);
+	parport_write_control(p, RXDATA0 + STROBE);	/* Write Strobe=3D1 to comman=
d reg. */
=20
 	/* 6 */
-	if ((portman_readStatus() & ESTB) !=3D ESTB)
+	if ((parport_read_status(p) & ESTB) !=3D ESTB)
 		return 1;	/* CODE 1 - Strobe Failure. */
=20
 	/* 7 */
-	portman_writeCommand(0);	/* Reset Strobe=3D0. */
-	udelay(delay);
-
+	parport_write_control(p, 0);	/* Reset Strobe=3D0. */
=20
 	/* Check if Tx circuitry is functioning properly.  If initialized=20
 	 * unit TxEmpty is false, send out char and see if if goes true.
 	 */
 	/* 8 */
-	portman_writeCommand(TXDATA0);	/* Tx channel 0, strobe off. */
-	udelay(delay);
+	parport_write_control(p, TXDATA0);	/* Tx channel 0, strobe off. */
=20
 	/* If PCP channel's TxEmpty is set (TxEmpty is read through the PP
 	 * Status Register), then go write data.  Else go back and wait.
 	 */
 	/* 9 */
-	if ((portman_readStatus() & TXEMPTY) =3D=3D 0)
+	if ((parport_read_status(p) & TXEMPTY) =3D=3D 0)
 		return 2;
=20
 	/* Return OK status. */
 	return 0;
 }
=20
-/* test */
-static void portman_testInterrupts(void)
-{
-	int i;
-
-	for (i =3D 0; i < 5; i++) {
-		if ((portman_readCommand() & INT_EN) =3D=3D INT_EN) {
-			snd_printk(">>> Interrupts enabled :)\n");
-			return;
-		}
-
-		snd_printk("portman2x4: %i\n", portman_readCommand());
-		snd_printk("portman2x4: %i\n", INT_EN);
-		snd_printk(">>> Interrupts are not enabled!");
-
-		udelay(gwAddressDelay);
-
-		snd_printk(">>> Trying to enable IRQ...\n");
-		myPort->ops->enable_irq(myPort);
-		udelay(gwAddressDelay);
-	}
-}
-
-
-/* parport handler functions */
-
-static void portman_attach(struct parport *port)
-{
+static int portman_device_init(struct portman *pm)
+{
+	portman_flush_input(pm, 0);
+	portman_flush_input(pm, 1);
+
+	return 0;
+}
+
+/*********************************************************************
+ * Rawmidi
+ *********************************************************************/
+
+static void snd_portman_midi_input_trigger(struct snd_rawmidi_substream *s=
ubstream,
+					   int up)
+{
+	struct portman *pm =3D substream->rmidi->private_data;
 	unsigned long flags;
-	/* local data */
-	int result =3D 0;
-
-	/* output information on used port */
-	if (port !=3D NULL)
-		snd_printk("Using port at 0x%lx, IRQ %i.\n", port->base,
-			   port->irq);
-	else {
-		snd_printk("Ooops! port is NULL\n");
-		return;
-	}
-
-	/* Test if device supports irq. Abort initialization of not. */
-	if (port->irq =3D=3D -1) {
-		snd_printk
-		    ("Error. Parallel port does not support IRQ. \n");
-		cleanup();
-		return;
-	}
-
-	/* keep pointer to port */
-	myPort =3D port;
-
-	/* Now register device with IRQ enabled */
-	myParDevice =3D (struct pardevice *) parport_register_device(port,	/* ptr=
 to port to register at */
-								   sDeviceName,	/* ptr to device name */
-								   NULL,	/* ptr to preemption handler */
-								   NULL,	/* ptr to wakeup handler */
-								   portman_handler_irq,	/* ptr to irq handler */
-								   0,	/* no flags */
-								   NULL);	/* no handle */
-	/* Check if device registration was successful */
-	if (myParDevice =3D=3D NULL) {
-		snd_printk("Error. Pardevice could not be registered.\n");
-		cleanup();
-		return;
-	}
-
-	/* Claim parport device */
-
-	/* Disable interrupts (we must not be disturbed while processing here...)=
 */
-	local_irq_save(flags);
-
-	/* Claim the device */
-	if (parport_claim(myParDevice) !=3D 0) {
-		local_irq_restore(flags);
-		snd_printk("Device is busy.\n");
-		cleanup();
-		return;
-	}
-
-	portowned =3D 1;
-
-	/* Save current port status... */
-	SAVE_PORTCOMMAND =3D portman_readCommand();
-	SAVE_PORTDATA =3D portman_readData();
-	SAVE_PORTVALID =3D 1;
-
-	/* check for portman existence */
-	result =3D 0;
-	result =3D hwOpen();
-
-	/* Reenable interrupts */
-	local_irq_restore(flags);
-
-	switch (result) {
-	case 0:
-		snd_printk("Portman found.\n");
-		portman_found =3D 1;
-		break;
-	case 1:
-		snd_printk("Probe error. Portman not found.\n");
-		cleanup();
-		return;
-		break;
-	case 2:
-		snd_printk("TX Error. Hardware test fail.\n");
-		cleanup();
-		return;
-		break;
-	}
-
-	/* Module initialization complete... */
-
-	/* Later: flushAllInputs()  (number of ports variable - possible compatib=
ility with PortMan 4x4 (untested)) */
-	/* save flags, disable interrupts */
-	/* Flush inputs 0 and 1 */
-	portman_flushInput(0);
-	portman_flushInput(1);
-	/* restore flags */
-
-	/* Test if interrupts are enabled. */
-
-	portman_testInterrupts();
-
-	return;
-}
-
-static void portman_detach(struct parport *port)
-{
-}
-
-static struct parport_driver portman_driver =3D {
-	.name =3D "portman2x4",
-	.attach =3D portman_attach,
-	.detach =3D portman_detach,
-};
-
-static int snd_portman_midi_input_open(struct snd_rawmidi_substream *subst=
ream)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&portman->reg_lock, flags);
-	portman->midi_input_mode[substream->number] |=3D
-	    PORTMAN2X4_MODE_INPUT_OPENED;
-	portman->midi_input[substream->number] =3D substream;
-	spin_unlock_irqrestore(&portman->reg_lock, flags);
-	return 0;
-}
-
-static int snd_portman_midi_input_close(struct snd_rawmidi_substream *
-					substream)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&portman->reg_lock, flags);
-	portman->midi_input_mode[substream->number] &=3D
-	    (~PORTMAN2X4_MODE_INPUT_OPENED);
-	portman->midi_input[substream->number] =3D NULL;
-	spin_unlock_irqrestore(&portman->reg_lock, flags);
-	return 0;
-}
-
-static int snd_portman_midi_output_open(struct snd_rawmidi_substream *
-					substream)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&portman->reg_lock, flags);
-	portman->midi_output_mode[substream->number] |=3D
-	    PORTMAN2X4_MODE_OUTPUT_OPENED;
-	portman->midi_output[substream->number] =3D substream;
-	spin_unlock_irqrestore(&portman->reg_lock, flags);
-	return 0;
-}
-
-static int snd_portman_midi_output_close(struct snd_rawmidi_substream *
-					 substream)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&portman->reg_lock, flags);
-	portman->midi_output_mode[substream->number] &=3D
-	    ~PORTMAN2X4_MODE_OUTPUT_OPENED;
-	portman->midi_output[substream->number] =3D NULL;
-	spin_unlock_irqrestore(&portman->reg_lock, flags);
-	return 0;
-}
-
-static void snd_portman_midi_input_trigger(struct snd_rawmidi_substream *
-					   substream, int up)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&portman->reg_lock, flags);
+
+	spin_lock_irqsave(&pm->reg_lock, flags);
 	if (up) {
-		portman->midi_input_mode[substream->number] |=3D
-		    PORTMAN2X4_MODE_INPUT_TRIGGERED;
+		pm->mode[substream->number] |=3D PORTMAN2X4_MODE_INPUT_TRIGGERED;
 	} else {
-		portman->midi_input_mode[substream->number] &=3D
-		    ~PORTMAN2X4_MODE_INPUT_TRIGGERED;
-	}
-	spin_unlock_irqrestore(&portman->reg_lock, flags);
-}
-
-static void snd_portman_midi_output_trigger(struct snd_rawmidi_substream *
-					    substream, int up)
-{
+		pm->mode[substream->number] &=3D ~PORTMAN2X4_MODE_INPUT_TRIGGERED;
+	}
+	spin_unlock_irqrestore(&pm->reg_lock, flags);
+}
+
+static void snd_portman_midi_output_trigger(struct snd_rawmidi_substream *=
substream,
+					    int up)
+{
+	struct portman *pm =3D substream->rmidi->private_data;
 	unsigned long flags;
 	unsigned char byte =3D 0;
=20
-	spin_lock_irqsave(&portman->reg_lock, flags);
+	spin_lock_irqsave(&pm->reg_lock, flags);
 	if (up) {
 		while ((snd_rawmidi_transmit(substream, &byte, 1) =3D=3D 1))
-		  portman_putmidi(substream->number, byte);
-	}
-	spin_unlock_irqrestore(&portman->reg_lock, flags);
+			portman_write_midi(pm, substream->number, byte);
+	}
+	spin_unlock_irqrestore(&pm->reg_lock, flags);
 }
=20
 static struct snd_rawmidi_ops snd_portman_midi_output =3D {
-	.open =3D		snd_portman_midi_output_open,
-	.close =3D	snd_portman_midi_output_close,
+	.open =3D		NULL,
+	.close =3D	NULL,
 	.trigger =3D	snd_portman_midi_output_trigger,
 };
=20
 static struct snd_rawmidi_ops snd_portman_midi_input =3D {
-	.open =3D		snd_portman_midi_input_open,
-	.close =3D	snd_portman_midi_input_close,
+	.open =3D		NULL,
+	.close =3D	NULL,
 	.trigger =3D	snd_portman_midi_input_trigger,
 };
=20
-static int __init snd_portman_midi(portman_t * portman, int device,
-				   struct snd_rawmidi ** rrawmidi)
-{
+/* Create and initialize the rawmidi component */
+static int __devinit snd_portman_rawmidi_create(struct snd_card *card)
+{
+	struct portman *pm =3D card->private_data;
 	struct snd_rawmidi *rmidi;
+	struct snd_rawmidi_substream *substream;
+	struct list_head *list;
 	int err;
-
-	if (rrawmidi)
-		*rrawmidi =3D NULL;
-
-	if ((err =3D
-	     snd_rawmidi_new(portman->card, "Portman2x4", device, 4, 2,
-			     &rmidi)) < 0)
+=09
+	err =3D snd_rawmidi_new(card, CARD_NAME, 0,=20
+			      PORTMAN_NUM_OUTPUT_PORTS,=20
+			      PORTMAN_NUM_INPUT_PORTS,=20
+			      &rmidi);
+	if (err < 0)=20
 		return err;
=20
-	strcpy(rmidi->name, "Portman2x4");
-	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT,
+	rmidi->private_data =3D pm;
+	strcpy(rmidi->name, CARD_NAME);
+	rmidi->info_flags =3D SNDRV_RAWMIDI_INFO_OUTPUT |
+		            SNDRV_RAWMIDI_INFO_INPUT |
+                            SNDRV_RAWMIDI_INFO_DUPLEX;
+
+	pm->rmidi =3D rmidi;
+
+	/* register rawmidi ops */
+	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT,=20
 			    &snd_portman_midi_output);
-	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT,
+	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT,=20
 			    &snd_portman_midi_input);
-	rmidi->info_flags |=3D
-	    SNDRV_RAWMIDI_INFO_OUTPUT | SNDRV_RAWMIDI_INFO_INPUT |
-	    SNDRV_RAWMIDI_INFO_DUPLEX;
-	rmidi->private_data =3D portman;
-	portman->rmidi =3D rmidi;
-	if (rrawmidi)
-		*rrawmidi =3D rmidi;
-	return 0;
-}
-
-
-/* init midiman portman */
-
-static int __init alsa_card_portman2x4_init(void)
-{
-	/* LOCAL VARIABLES */
-	static int dev =3D 0;
-	struct snd_card *card;
+
+	/* name substreams */
+	/* output */
+	list_for_each(list,=20
+		      &rmidi->streams[SNDRV_RAWMIDI_STREAM_OUTPUT].substreams) {
+		substream =3D list_entry(list, struct snd_rawmidi_substream, list);
+		sprintf(substream->name,
+			"Portman2x4 %d", substream->number+1);
+	}
+	/* input */
+	list_for_each(list,=20
+		      &rmidi->streams[SNDRV_RAWMIDI_STREAM_INPUT].substreams) {
+		substream =3D list_entry(list, struct snd_rawmidi_substream, list);
+		pm->midi_input[substream->number] =3D substream;
+		sprintf(substream->name,
+			"Portman2x4 %d", substream->number+1);
+	}
+
+	return err;
+}
+
+/*********************************************************************
+ * parport stuff
+ *********************************************************************/
+#if LINUX_VERSION_CODE >=3D KERNEL_VERSION(2, 6, 19)
+static void snd_portman_interrupt(int irq, void *userdata)
+#else
+static void snd_portman_interrupt(int irq, void *userdata, struct pt_regs =
*regs)
+#endif
+{
+	unsigned long flags;
+	unsigned char midivalue =3D 0;
+	struct portman *pm =3D ((struct snd_card*)userdata)->private_data;
+
+	spin_lock_irqsave(&pm->reg_lock, flags);
+
+	/* While any input data is waiting */
+	while ((portman_read_status(pm) & INT_REQ) =3D=3D INT_REQ) {
+		/* If data available on channel 0,=20
+		   read it and stuff it into the queue. */
+		if (portman_data_avail(pm, 0)) {
+			/* Read Midi */
+			midivalue =3D portman_read_midi(pm, 0);
+			/* put midi into queue... */
+			if (pm->mode[0] & PORTMAN2X4_MODE_INPUT_TRIGGERED)
+				snd_rawmidi_receive(pm->midi_input[0],
+						    &midivalue, 1);
+
+		}
+		/* If data available on channel 1,=20
+		   read it and stuff it into the queue. */
+		if (portman_data_avail(pm, 1)) {
+			/* Read Midi */
+			midivalue =3D portman_read_midi(pm, 1);
+			/* put midi into queue... */
+			if (pm->mode[1] & PORTMAN2X4_MODE_INPUT_TRIGGERED)
+				snd_rawmidi_receive(pm->midi_input[1],
+						    &midivalue, 1);
+		}
+
+	}
+
+	spin_unlock_irqrestore(&pm->reg_lock, flags);
+}
+
+static int __devinit snd_portman_probe_port(struct parport *p)
+{
+	struct pardevice *pardev;
+	int res;
+
+	pardev =3D parport_register_device(p, DRIVER_NAME,
+					 NULL, NULL, NULL,
+					 0, NULL);
+	if (!pardev)
+		return -EIO;
+=09
+	if (parport_claim(pardev)) {
+		parport_unregister_device(pardev);
+		return -EIO;
+	}
+
+	res =3D portman_probe(p);
+
+	parport_release(pardev);
+	parport_unregister_device(pardev);
+
+	return res;
+}
+
+static void __devinit snd_portman_attach(struct parport *p)
+{
+	struct platform_device *device;
+
+	device =3D platform_device_alloc(PLATFORM_DRIVER, device_count);
+	if (!device)=20
+		return;
+
+	/* Temporary assignment to forward the parport */
+	platform_set_drvdata(device, p);
+
+	if (platform_device_register(device) < 0) {
+		platform_device_put(device);
+		return;
+	}
+
+	/* Since we dont get the return value of probe
+	 * We need to check if device probing succeeded or not */
+	if (!platform_get_drvdata(device)) {
+		platform_device_unregister(device);
+		return;
+	}
+
+	/* register device in global table */
+	platform_devices[device_count] =3D device;
+	device_count++;
+}
+
+static void snd_portman_detach(struct parport *p)
+{
+	/* nothing to do here */
+}
+
+static struct parport_driver portman_parport_driver =3D {
+	.name   =3D "portman2x4",
+	.attach =3D snd_portman_attach,
+	.detach =3D snd_portman_detach
+};
+
+/*********************************************************************
+ * platform stuff
+ *********************************************************************/
+static void snd_portman_card_private_free(struct snd_card *card)
+{
+	struct portman *pm =3D card->private_data;
+	struct pardevice *pardev =3D pm->pardev;
+
+	if (pardev) {
+		if (pm->pardev_claimed)
+			parport_release(pardev);
+		parport_unregister_device(pardev);
+	}
+
+	portman_free(pm);
+}
+
+static int __devinit snd_portman_probe(struct platform_device *pdev)
+{
+	struct pardevice *pardev;
+	struct parport *p;
+	int dev =3D pdev->id;
+	struct snd_card *card =3D NULL;
+	struct portman *pm =3D NULL;
 	int err;
-	int result =3D 0;
-
-	/* Display copyright notice and driver version */
-	snd_printk("Driverversion is: %s\n", sVersion);
-
-	portman =3D kzalloc(sizeof(portman_t), GFP_KERNEL);
-	if (portman =3D=3D NULL) {
-		snd_printk
-		    ("Error allocating memory for portman. Exiting.\n");
-		return 1;
-	}
-
-	spin_lock_init(&portman->reg_lock);
-
-	portman->midi_input_mode[0] =3D 0;
-	portman->midi_input_mode[1] =3D 0;
-	portman->midi_output_mode[0] =3D 0;
-	portman->midi_output_mode[1] =3D 0;
-	portman->midi_output_mode[2] =3D 0;
-	portman->midi_output_mode[3] =3D 0;
-
-	/* Initialize parport */
-	/* Register a new high-level driver. */
-	result =3D parport_register_driver(&portman_driver);
-
-	/* Test if there is a portman available. Exit if not. */
-	if (portman_found =3D=3D 0) {
-		snd_printk("Portman not found. Exiting.\n");
-		parport_unregister_driver(&portman_driver);
-		return 1;
-	}
-
-	for (; dev < SNDRV_CARDS; dev++) {
-		if (!enable[dev]) {
-			dev++;
-			snd_printk("Could not enable card. Exiting.\n");
-			cleanup();
-			return -ENOENT;
-		}
-		break;
-	}
-
-	if (dev >=3D SNDRV_CARDS) {
-		snd_printk("Could not enable card. Exiting.\n");
-		cleanup();
+
+	p =3D platform_get_drvdata(pdev);
+	platform_set_drvdata(pdev, NULL);
+
+	if (dev >=3D SNDRV_CARDS)
 		return -ENODEV;
-	}
-
-	/* alsa: create new sound card */
+	if (!enable[dev])=20
+		return -ENOENT;
+
+	if ((err =3D snd_portman_probe_port(p)) < 0)
+		return err;
+
 	card =3D snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
 	if (card =3D=3D NULL) {
-		snd_printk
-		    ("Fatal. Cannot allocate memory for sound card. Exiting.\n");
-		cleanup();
+		snd_printd("Cannot create card\n");
 		return -ENOMEM;
 	}
-
-	portman->card =3D card;
-
-	/* register midi functions */
-	if ((err =3D snd_portman_midi(portman, 0, NULL)) < 0) {
+	strcpy(card->driver, DRIVER_NAME);
+	strcpy(card->shortname, CARD_NAME);
+	sprintf(card->longname,  "%s at 0x%lx, irq %i",=20
+		card->shortname, p->base, p->irq);
+
+	pardev =3D parport_register_device(p,                     /* port */
+					 DRIVER_NAME,           /* name */
+					 NULL,                  /* preempt */
+					 NULL,                  /* wakeup */
+					 snd_portman_interrupt, /* ISR */
+					 PARPORT_DEV_EXCL,      /* flags */
+					 (void *)card);         /* private */
+	if (pardev =3D=3D NULL) {
+		snd_printd("Cannot register pardevice\n");
+		err =3D -EIO;
+		goto __err;
+	}
+
+	if ((err =3D portman_create(card, pardev, &pm)) < 0) {
+		snd_printd("Cannot create main component\n");
+		parport_unregister_device(pardev);
+		goto __err;
+	}
+	card->private_data =3D pm;
+	card->private_free =3D snd_portman_card_private_free;
+=09
+	if ((err =3D snd_portman_rawmidi_create(card)) < 0) {
+		snd_printd("Creating Rawmidi component failed\n");
+		goto __err;
+	}
+
+	/* claim parport */
+	if (parport_claim(pardev)) {
+		snd_printd("Cannot claim parport 0x%lx\n", pardev->port->base);
+		err =3D -EIO;
+		goto __err;
+	}
+	pm->pardev_claimed =3D 1;
+
+	/* init device */
+	if ((err =3D portman_device_init(pm)) < 0)
+		goto __err;
+
+	platform_set_drvdata(pdev, card);
+
+	/* At this point card will be usable */
+	if ((err =3D snd_card_register(card)) < 0) {
+		snd_printd("Cannot register card\n");
+		goto __err;
+	}
+
+	snd_printk("Portman 2x4 on 0x%lx\n", p->base);
+	return 0;
+
+__err:
+	snd_card_free(card);
+	return err;
+}
+
+static int snd_portman_remove(struct platform_device *pdev)
+{
+	struct snd_card *card =3D platform_get_drvdata(pdev);
+
+	if (card)
 		snd_card_free(card);
+
+	return 0;
+}
+
+
+static struct platform_driver snd_portman_driver =3D {
+	.probe  =3D snd_portman_probe,
+	.remove =3D snd_portman_remove,
+	.driver =3D {
+		.name =3D PLATFORM_DRIVER
+	}
+};
+
+/*********************************************************************
+ * module init stuff
+ *********************************************************************/
+static void snd_portman_unregister_all(void)
+{
+	int i;
+
+	for (i =3D 0; i < SNDRV_CARDS; ++i) {
+		if (platform_devices[i]) {
+			platform_device_unregister(platform_devices[i]);
+			platform_devices[i] =3D NULL;
+		}
+	}=09=09
+	platform_driver_unregister(&snd_portman_driver);
+	parport_unregister_driver(&portman_parport_driver);
+}
+
+static int __init snd_portman_module_init(void)
+{
+	int err;
+
+	if ((err =3D platform_driver_register(&snd_portman_driver)) < 0)
 		return err;
-	}
-	strcpy(card->driver, "Portman");
-	strcpy(card->shortname, "Portman2x4");
-	sprintf(card->longname, "%s %s at 0x%lx, irq %i",
-		card->shortname, "2x4", portman->port, portman->irq);
-
-	if ((err =3D snd_card_register(card)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
-
-	dev++;
+
+	if (parport_register_driver(&portman_parport_driver) !=3D 0) {
+		platform_driver_unregister(&snd_portman_driver);
+		return -EIO;
+	}
+
+	if (device_count =3D=3D 0) {
+		snd_portman_unregister_all();
+		return -ENODEV;
+	}
+
 	return 0;
 }
=20
-static void __exit alsa_card_portman2x4_exit(void)
-{
-	if (portman =3D=3D NULL)
-		return;
-	if (portman->card)
-		snd_card_free(portman->card);
-	cleanup();
-	parport_unregister_driver(&portman_driver);
-}
-
-module_init(alsa_card_portman2x4_init)
-module_exit(alsa_card_portman2x4_exit)
+static void __exit snd_portman_module_exit(void)
+{
+	snd_portman_unregister_all();
+}
+
+module_init(snd_portman_module_init);
+module_exit(snd_portman_module_exit);

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-=-=--
