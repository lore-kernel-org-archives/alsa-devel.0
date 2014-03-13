From: James Miller <jamesstewartmiller@gmail.com>
Subject: zoom r16 quirks
Date: Thu, 13 Mar 2014 14:57:00 +0000
Message-ID: <CAKJvYZFBD19+LN_mYjUv0uQC1CEqZ4FEBEaobk9AM90U1OJ7GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f175.google.com (mail-ob0-f175.google.com
 [209.85.214.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 750C426527F
 for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2014 15:57:01 +0100 (CET)
Received: by mail-ob0-f175.google.com with SMTP id uy5so1137137obc.20
 for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2014 07:57:00 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I am trying to get the zoom R16 working with alsa for full duplex operation.

I have been able to get the 8 channels of capture working after following
jmancine's advice and using the following quirk on ifnum 4:

      {
     .ifnum = 4,
     .type = QUIRK_AUDIO_FIXED_ENDPOINT,
     .data = & (const struct audioformat) {
        .formats = SNDRV_PCM_FMTBIT_S24_LE,
        .channels = 8,
        .iface = 1,
        .altsetting = 1,
        .altset_idx = 1,
        .attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
        .rates = SNDRV_PCM_RATE_44100 |
        SNDRV_PCM_RATE_48000 |
        SNDRV_PCM_RATE_88200 |
        SNDRV_PCM_RATE_96000,
        .rate_min = 44100,
        .rate_max = 96000,
        .nr_rates = 4,
        .rate_table = (unsigned int[]) {
        44100, 48000, 88200, 96000
      }
    }
      },

However, what I discovered was that the ifnum 4 in this case is related to
the udev matching rules for the device number, so when I plugged in the
zoom, it was being assigned to device 4, which was then matched to the
ifnum 4.  If I unplugged and replugged the device, it was then designated
as device 5 in the udev tree, and wasn't working.

I read in quirks-table.h the following:

(To work with
 * hotplugging, bDeviceClass must be set to USB_CLASS_PER_INTERFACE.)

so I changed the matching rule macro to :
USB_DEVICE_INTERFACE_CLASS(0x1686, 0x00dd, USB_CLASS_AUDIO)

to attempt to match the device during udev assignment (in case the device
class wasn't returned from the device properly) and then set
.binterfaceclass = USB_CLASS_PER_INTERFACE below that before the quirk data.

I think that I am heading in the correct direction, although I was
wondering if you could confirm the following:
Am I correct in assuming that the .ifnum in the quirk is related to udev
device matching rules?

When I write zoom-quirks.h  in the way that I am currently (see below), I
get a incorrect maxpacket assignment for interface 3 (midi) and I traced
this to:

            dev_warn(ddev, "config %d interface %d altsetting %d "
                "bulk endpoint 0x%X has invalid maxpacket %d\n",

in config.c line 259.

The above bit of code is selected in conditions where the device is usb
high speed but I have kern.log reporting that the device is class 1.1.  Its
a 24 bit chip, and jmancine reports that the device is being incorrectly
assigned a 32bit le format for playback when it should be 24bit le, so
perhaps this is because of a protocol mismatch?  When I have the device
successfully recognised the next time, I will check in format.c that it is
being assigned the correct bit format, but I am uncertain as to how to
confirm what bprotocol to use.  Any ideas?

Here is the zoom-quirks.h that I am currently using.

{
/* ZOOM R16 in USB 2.0 mode */
USB_DEVICE_INTERFACE_CLASS(0x1686, 0x00dd, USB_CLASS_AUDIO),
.bDeviceClass = USB_CLASS_PER_INTERFACE,
.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
.ifnum = QUIRK_ANY_INTERFACE,
.type = QUIRK_COMPOSITE,
.data = (const struct snd_usb_audio_quirk[]) {
      {
         .ifnum = 1, /*PLAYBACK*/
         .type = QUIRK_AUDIO_FIXED_ENDPOINT,
         .data = & (const struct audioformat) {
            .formats = SNDRV_PCM_FMTBIT_S24_LE,
            .channels = 2,
            .iface = 1,
            .altsetting = 1,
            .altset_idx = 1,
            .attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
            .rates = SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000,
            .endpoint = 0x03,
            .ep_attr = (USB_ENDPOINT_XFER_ISOC &&
USB_ENDPOINT_SYNC_ADAPTIVE && SND_USB_ENDPOINT_TYPE_DATA),
            .rate_min = 44100,
            .rate_max = 96000,
            .nr_rates = 4,
            .rate_table = (unsigned int[]) {
            44100, 48000, 88200, 96000
          }
        }
      },

      {
         .ifnum = 2, /*CAPTURE*/
         .type = QUIRK_AUDIO_FIXED_ENDPOINT,
         .data = & (const struct audioformat) {
            .formats = SNDRV_PCM_FMTBIT_S24_LE,
            .channels = 8,
            .iface = 2,
            .altsetting = 1,
            .altset_idx = 1,
            .attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
            .rates = SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000,
            .endpoint = 0x84,
            .ep_attr = (USB_ENDPOINT_XFER_ISOC && USB_ENDPOINT_SYNC_SYNC &&
USB_ENDPOINT_USAGE_DATA),
            .rate_min = 44100,
            .rate_max = 96000,
            .nr_rates = 4,
            .rate_table = (unsigned int[]) {
            44100, 48000, 88200, 96000
          }
        }
      },

      {
          .ifnum = 3,
          .type = QUIRK_MIDI_FIXED_ENDPOINT,
      },

      {
          .ifnum = -1,
      },

    }

  }

},

Thanks for any help!!

-- 
James Stewart Miller Bsc(hons) Psych.
