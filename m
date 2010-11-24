From: Damien Zammit <damien.zammit@gmail.com>
Subject: sound: usb-audio: full capture/playback/spdif support
 for Digidesign Mbox 2
Date: Wed, 24 Nov 2010 23:59:38 +1100
Message-ID: <AANLkTi=cSDq5SEh321Zy2n2RMHWFnW2-hd-=k9mz+eEz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 72EBA103950
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2010 13:59:41 +0100 (CET)
Received: by qyk11 with SMTP id 11so2669652qyk.17
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2010 04:59:40 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi folks,

I have put together full support for Digidesign Mbox 2, but it needs
someone to help me merge it into alsa.=A0 I haven't seen the latest
snd-usb-audio code since last year, it seems to have branched into
multiple files.

I have worked out how the Digidesign Mbox 2 needs to be configured, it
supports SPDIF i/o simultaneously with analogue but can be toggled on
and off by using different altsettings.
Also the sample clock rate must be configured via a special method.

Therefore I have provided for this in a device_setup parameter with 4 setti=
ngs:
48Khz Spdif+analog =3D 0
44.1Khz Spdif+analog =3D 1
48Khz Analog only =3D 2
44.1Khz Analog only =3D 3

###### audio

=A0=A0=A0=A0=A0=A0=A0 /* Digidesign Mbox 2 workaround:
=A0=A0=A0=A0=A0=A0=A0=A0 * supports S24_3BE BIG ENDIAN in an unusual way */
=A0=A0=A0=A0=A0=A0=A0 if (chip->usb_id =3D=3D USB_ID(0x0dba, 0x3000))
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0 pcm_format =3D SNDRV_PCM_FORMAT_S24_3BE;

static int mbox2_skip_setting_quirk(struct snd_usb_audio *chip,
                                        int iface, int altno);
static int parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
{
 .....
.....
            /* Digidesign Mbox 2: skip altsets incompatible with device_set=
up
                 */
                if (chip->usb_id =3D=3D USB_ID(0x0dba, 0x3000) &&
                    mbox2_skip_setting_quirk(chip, iface_no, altno))
                        continue;
.....
}


#define MBOX2_SET_48K_SPDIF=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0
#define MBOX2_SET_44K_SPDIF=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1
#define MBOX2_SET_48K_ANALOG=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2
#define MBOX2_SET_44K_ANALOG=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 3

static int mbox2_skip_setting_quirk(struct snd_usb_audio *chip,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int iface, int altno)
{
=A0=A0=A0=A0=A0=A0=A0 u8 srate[3];
=A0=A0=A0=A0=A0=A0=A0 /* Reset ifaces 2-5 to 0 altsetting. */
=A0=A0=A0=A0=A0=A0=A0 usb_set_interface(chip->dev, iface, 0);

=A0=A0=A0 if (device_setup[chip->index] =3D=3D MBOX2_SET_48K_SPDIF ||
=A0=A0=A0 =A0=A0=A0 device_setup[chip->index] =3D=3D MBOX2_SET_48K_ANALOG) {
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 //setup 48k
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 srate=
[0]=3D0x80;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 srate=
[1]=3D0xbb;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 srate=
[2]=3D0x00;

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Se=
nd the magic! */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 snd_u=
sb_ctl_msg(chip->dev,
usb_sndctrlpipe(chip->dev, 0),
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0x01, 0x22, 0x0100, 0x0085, &srate,
0x0003, 1000);

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 snd_u=
sb_ctl_msg(chip->dev,
usb_sndctrlpipe(chip->dev, 0),
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0x81, 0xa2, 0x0100, 0x0085, &srate,
0x0003, 1000);

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 snd_u=
sb_ctl_msg(chip->dev,
usb_sndctrlpipe(chip->dev, 0),
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0x81, 0xa2, 0x0100, 0x0086, &srate,
0x0003, 1000);

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 snd_u=
sb_ctl_msg(chip->dev,
usb_sndctrlpipe(chip->dev, 0),
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0x81, 0xa2, 0x0100, 0x0003, &srate,
0x0003, 1000);
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 snd_printk(KERN_INFO "Digidesign Mbox 2: 24 B=
it 48000Hz");
=A0=A0=A0 =A0=A0=A0 if (device_setup[chip->index] =3D=3D MBOX2_SET_48K_SPDI=
F) {
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 //setup spdif
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 snd_printk(KERN_INFO ", SPDIF\n");
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 if (altno !=3D 2) return 1;
=A0=A0=A0 =A0=A0=A0 } else {
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 //setup analog
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 snd_printk(KERN_INFO ", ANALOGUE\n");
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 if (altno !=3D 3) return 1;
=A0=A0=A0 =A0=A0=A0 }
=A0=A0=A0 } else {
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 //setup 44k
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 srate=
[0]=3D0x44;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 srate=
[1]=3D0xac;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 srate=
[2]=3D0x00;

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Se=
nd the magic! */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 snd_u=
sb_ctl_msg(chip->dev,
usb_sndctrlpipe(chip->dev, 0),
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0x01, 0x22, 0x0100, 0x0085, &srate,
0x0003, 1000);

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 snd_u=
sb_ctl_msg(chip->dev,
usb_sndctrlpipe(chip->dev, 0),
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0x81, 0xa2, 0x0100, 0x0085, &srate,
0x0003, 1000);

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 snd_u=
sb_ctl_msg(chip->dev,
usb_sndctrlpipe(chip->dev, 0),
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0x81, 0xa2, 0x0100, 0x0086, &srate,
0x0003, 1000);

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 snd_u=
sb_ctl_msg(chip->dev,
usb_sndctrlpipe(chip->dev, 0),
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0x81, 0xa2, 0x0100, 0x0003, &srate,
0x0003, 1000);

=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 snd_printk(KERN_INFO "Digidesign Mbox 2: 24 B=
it 44100Hz");
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (d=
evice_setup[chip->index] =3D=3D MBOX2_SET_44K_SPDIF ||
=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 device_=
setup[chip->index] =3D=3D MBOX2_SET_44K_ANALOG) {

=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 //setup spdif
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 snd_printk(KERN_INFO ", SPDIF\n");
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 if (altno !=3D 2) return 1;
=A0=A0=A0 =A0=A0=A0 } else {
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 //setup analog
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 snd_printk(KERN_INFO ", ANALOGUE\n");
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 if (altno !=3D 3) return 1;
=A0=A0=A0 =A0=A0=A0 }
=A0=A0=A0 }

=A0=A0=A0 return 0;
}


#define MBOX2_FIRMWARE_SIZE=A0=A0=A0 646
#define MBOX2_BOOT_LOADING=A0=A0=A0=A0 0x01 /* Hard coded into the device */
#define MBOX2_BOOT_READY=A0=A0=A0=A0=A0=A0 0x02 /* Hard coded into the devi=
ce */

static int snd_usb_mbox2_boot_quirk(struct usb_device *dev)
{
=A0=A0=A0=A0=A0=A0=A0 struct usb_host_config *config =3D dev->actconfig;
=A0=A0=A0=A0=A0=A0=A0 int err;
=A0=A0=A0=A0=A0=A0=A0 u8 enablemagic[3];
=A0=A0=A0=A0=A0=A0=A0 u8 bootresponse;
=A0=A0=A0=A0=A0=A0=A0 int fwsize;

=A0=A0=A0=A0=A0=A0=A0 if ((fwsize =3D le16_to_cpu(get_cfg_desc(config)->wTo=
talLength))
=3D=3D MBOX2_FIRMWARE_SIZE) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 snd_printdd("Sending Digidesi=
gn Mbox 2 boot sequence...\n");

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Fr=
om USB Snoop,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * =
SetupPacket =3D RT RQ VHVL INDX SIZE
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * =
RT =3D 0xRT Request Type
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * =
RQ =3D 0xRQ Request
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * =
VHVL =3D 0xVLVH Value in reverse byte order
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * =
INDX =3D 0xDXIN Index in reverse byte order
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * =
SIZE =3D 0xZESI Size in reverse byte order
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * =
Magic boot code setup packet: c0 85 01 00 00 00 12 00
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 RQ=A0=A0=A0 RT=A0=A0=A0 VLVH=A0=A0=A0 DXIN
=A0=A0=A0=A0=A0=A0 ZESI
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * =
becomes 0x85, 0xc0, 0x0001, 0x0000,
&RETURNDATA, 0x0012, TIMEOUT
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * =
for snd_usb_ctl_msg()
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */

mbox2_reboot:
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 snd_usb_ctl_msg(dev, usb_rcvc=
trlpipe(dev, 0),
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x85,=
 0xc0, 0x0001, 0x0000, &bootresponse,
0x0012, 1000);

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (bootresponse =3D=3D MBOX2=
_BOOT_LOADING) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 snd_p=
rintdd("device not ready, resending boot
sequence...\n");
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto =
mbox2_reboot;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (bootresponse =3D=3D MBOX2=
_BOOT_READY) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 snd_p=
rintdd("device initialised!\n");

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 err =
=3D usb_get_descriptor(dev, USB_DT_DEVICE, 0,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 &dev->descriptor, sizeof(dev->descriptor));
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 confi=
g =3D dev->actconfig;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (e=
rr < 0) snd_printdd("error
usb_get_descriptor: %d\n", err);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 err =
=3D usb_reset_configuration(dev);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (e=
rr < 0) snd_printdd("error
usb_reset_configuration: %d\n", err);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 snd_p=
rintdd("mbox2_boot: new boot length =3D %d\n",
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 le16_to_cpu(get_cfg_desc(config)->wTotalLength));

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Su=
ccessful boot, (should reset all
altsettings to 0 like windows does, but works without it)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * =
but now we will try sending
capture/playback enable magic
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * =
80 bb 00 =3D 24bit mode - S24_3BE
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * =
44 ac 00 =3D 16bit mode?
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* We=
 want 48khz mode for now */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enabl=
emagic[0]=3D0x80;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enabl=
emagic[1]=3D0xbb;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enabl=
emagic[2]=3D0x00;

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Se=
nd the magic! */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 snd_u=
sb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0x01, 0x22, 0x0100, 0x0085,
&enablemagic, 0x0003, 1000);

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 snd_u=
sb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0x81, 0xa2, 0x0100, 0x0085,
&enablemagic, 0x0003, 1000);

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 snd_u=
sb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0x81, 0xa2, 0x0100, 0x0086,
&enablemagic, 0x0003, 1000);

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 snd_u=
sb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0x81, 0xa2, 0x0100, 0x0003,
&enablemagic, 0x0003, 1000);

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 retur=
n 0; /* Succesful boot */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 snd_printdd("unknown bootresp=
onse, ignoring device:
%d\n",bootresponse);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENODEV;
=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0 snd_printk("Invalid firmware size: %d\n",fwsize);
=A0=A0=A0=A0=A0=A0=A0 return -ENODEV;
}


#######=A0=A0 quirk:
{

=A0=A0=A0=A0=A0=A0 USB_DEVICE(0x0dba, 0x3000),
=A0=A0=A0=A0=A0=A0 .driver_info =3D (unsigned long) & (const struct snd_usb=
_audio_quirk) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .vendor_name =3D "Digidesign",
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .product_name =3D "Mbox 2",
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .ifnum =3D QUIRK_ANY_INTERFACE,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .type =3D QUIRK_COMPOSITE,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .data =3D (const struct snd_usb_=
audio_quirk[]) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 .ifnum =3D 0,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 .type =3D QUIRK_IGNORE_INTERFACE
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 },
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 .ifnum =3D 1,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 .type =3D QUIRK_AUDIO_STANDARD_INTERFACE
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 },
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 .ifnum =3D 2,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 .type =3D QUIRK_AUDIO_STANDARD_INTERFACE
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 },
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 .ifnum =3D 3,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 .type =3D QUIRK_AUDIO_STANDARD_INTERFACE
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 },
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 .ifnum =3D 4,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 .type =3D QUIRK_AUDIO_STANDARD_INTERFACE
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 },
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 .ifnum =3D 5,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 .type =3D QUIRK_AUDIO_STANDARD_INTERFACE
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 },
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 .ifnum =3D 6,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 .type =3D QUIRK_MIDI_MBOX2,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 .data =3D & (const struct
snd_usb_midi_endpoint_info) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .out_ep =3D=A0 0x02,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .out_cables =3D 0x0001,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .in_ep =3D 0x81,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .in_interval =3D 0x01,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .in_cables =3D 0x0001
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 }

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 },
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 .ifnum =3D -1
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0 }
},

##### midi

=A0=A0=A0=A0=A0=A0=A0 case QUIRK_MIDI_MBOX2:
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Digidesign Mbox 2 uses MID=
IMAN MIDI protocol */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 umidi->usb_protocol_ops =3D &=
snd_usbmidi_midiman_ops;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * We have to make sure tha=
t the USB core looks
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * again at interface 6 by =
calling usb_set_interface() on it.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usb_set_interface(umidi->chip=
->dev, 6, 0);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memcpy(&endpoints[0], quirk->=
data,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sizeof(s=
truct snd_usb_midi_endpoint_info));
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 err =3D 0;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;


Damien
