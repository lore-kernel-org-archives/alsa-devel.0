From: Andy Owen <andy-alsa@ultra-premium.com>
Subject: Re: [PATCH 2/2] ALSA: ca0106: Fix mixer and dac
 channel	assignments.
Date: Thu, 23 Sep 2010 00:12:33 +1000
Message-ID: <1285164753.1797.55.camel@marvin>
References: <1285077079-5519-1-git-send-email-andy-alsa@ultra-premium.com>
	<1285077079-5519-2-git-send-email-andy-alsa@ultra-premium.com>
	<s5hhbhjdwn9.wl%tiwai@suse.de> <1285079096.5919.0.camel@marvin>
	<s5haanbdslf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-g8ouaCT8rh3B1kCcOO9M"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from starfish.geekisp.com (mail.geekisp.com [216.168.135.169])
	by alsa0.perex.cz (Postfix) with ESMTP id 794B8103807
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Sep 2010 16:12:43 +0200 (CEST)
In-Reply-To: <s5haanbdslf.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--=-g8ouaCT8rh3B1kCcOO9M
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

> Hrm, but you changed the DAC number of the front channel.  Doesn't
change
> the front channel behavior...?

The behaviour I get is as follows:

0) Without either of my patches:
 * Distorted output, however once the soundcard has been initialised by
a working driver, this can only be reproduced by turning off the
computer (I think - I can test this later if it is useful, I'm basing it
off reports on forums about the card working for people after they
booted into windows and then restarted).
 * Capture fails (more on this later)

1) With the first patch (adding card info to the table):
 * "speaker-test -Dsurround51 -c6": silence for rear channels, others ok
 * "speaker-test -Drear -c2"      : silence
 * "speaker-test -Dfront -c2"     : silence
 * "speaker-test -Dcenter_lfe -c2": ok (sound+mute+volume)
 * "speaker-test -Dsurround51 -c6": mute for rear controls front
                                  : volume for front is correct
                                  : volume/mute for C/LFE is correct
 * Capture fails (more on this later again)

To me, this suggested that something was flipped with the front and
rear, hence I ended up changing some registers. The case halfway between
(1) and (2) would be before I modified the 'if' statement below so the
front channel isn't a special case.  The results are identical to (2),
except the front channel is always silent.

2) With the second patch:
* "speaker-test -Dsurround51 -c6": ok (sound+mute+volume)
* "speaker-test -Drear -c2"      : ok (sound+mute+volume)
* "speaker-test -Dfront -c2"     : ok (sound+mute+volume)
* "speaker-test -Dcenter_lfe -c2": ok (sound+mute+volume)
* Capture still broken

I'm using arecord to test capture, and I'm not sure if I'm driving it
wrong, as I can't get it to work for either of my cards (the other card
works slightly better, but I always get silence). The failure I'm
describing here is what I get for every version described above (the
only editing I've done here is remove mentions of the other sound
cards):

~% arecord -l
**** List of CAPTURE Hardware Devices ****
card 0: CA0106 [CA0106], device 0: ca0106 [CA0106]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: CA0106 [CA0106], device 1: ca0106 [CA0106]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: CA0106 [CA0106], device 2: ca0106 [CA0106]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: CA0106 [CA0106], device 3: ca0106 [CA0106]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
~% arecord -D hw:0,0 -f dat out.wav
Recording WAVE 'out.wav' : Signed 16 bit Little Endian, Rate 48000 Hz,
Stereo
arecord: pcm_read:1629: read error: Input/output error
(1)~% arecord -D hw:0,1 -f dat out.wav
Recording WAVE 'out.wav' : Signed 16 bit Little Endian, Rate 48000 Hz,
Stereo
arecord: pcm_read:1629: read error: Input/output error
(1)~% arecord -D hw:0,2 -f dat out.wav
Recording WAVE 'out.wav' : Signed 16 bit Little Endian, Rate 48000 Hz,
Stereo
arecord: pcm_read:1629: read error: Input/output error

Note that it fails after 10 seconds of me running arecord, suggesting
some sort of timeout somewhere. If I try to record at 44.1kHz, I get a
warning:

Warning: rate is not accurate (requested = 44100Hz, got = 48000Hz)
         please, try the plug plugin

followed by the same error.


> No, take a look at git commit
485100706b4b397f8072c756839878f634e21f85:
> 
>    [ALSA] ca0106: power down SPI DAC channels when not in use
>     
>     For cards with an SPI DAC (SB Live 24-bit / Audigy SE), power down
channels
>     0-2 when not in use.  They are powered up on PCM open and down
again on PCM
>     close.  Channel 4 (== Front) is not powered down, as it is used
for capture
>     feedback.  Powering it down would effectively kill line in
pass-through.
>     
> So, it's the designed behavior.

Judging by that commit, Trent actually had a datasheet to work with, so
I'm inclined to trust it more. However, I just wonder if the other cards
have had full testing of all their outputs - only the "X-Fi Extreme
Audio" claims to have had all 6 channels tested.


> Judging from the fact that this mapping hasn't been changed since that
> time, I feel that it's not safe to change the mapping unconditionally
> for your device.  That's why I suggest for some new flag.

So if it is a new flag. I'd be tempted to instead include the mappings
in the chip_details struct, rather than a single purpose flag for one
device (which will surely be difficult to name well). The other change
I'd be tempted to make would be to avoid exposing channels that don't
exist (like the side channels, or spdif for this device). Is that a
sensible step? Do any other drivers have to solve a similar problem?

I've attached the first patch with the sign-off line if you want to put
it in now. Otherwise, I'm happy to wait until everything is sorted out,
and put it all in together.

Andy
> 
> 
> Takashi

--=-g8ouaCT8rh3B1kCcOO9M
Content-Disposition: attachment; filename="0001-ALSA-ca0106-add-Sound-Blaster-5.1vx-info.patch"
Content-Type: text/x-patch; name="0001-ALSA-ca0106-add-Sound-Blaster-5.1vx-info.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 7ebb81b4cc7268acbd0b6074667ad66ccf3d1a96 Mon Sep 17 00:00:00 2001
From: Andy Owen <andy-alsa@ultra-premium.com>
Date: Tue, 21 Sep 2010 23:21:02 +1000
Subject: [PATCH] ALSA: ca0106 - add Sound Blaster 5.1vx info.

Signed-off-by: Andy Owen <andy-alsa@ultra-premium.com>
---
 sound/pci/ca0106/ca0106_main.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/sound/pci/ca0106/ca0106_main.c b/sound/pci/ca0106/ca0106_main.c
index 8e69620..6dc9a5d 100644
--- a/sound/pci/ca0106/ca0106_main.c
+++ b/sound/pci/ca0106/ca0106_main.c
@@ -239,6 +239,16 @@ static struct snd_ca0106_details ca0106_chip_details[] = {
 	   .gpio_type = 1,
 	   .i2c_adc = 1,
 	   .spi_dac = 1 } ,
+	/* Sound Blaster 5.1vx
+	 * Tested: Playback on front, rear, center/lfe speakers
+	 * Not-Tested: Capture
+	 */
+	{ .serial = 0x10041102,
+	  .name   = "Sound Blaster 5.1vx [SB1070]",
+	  .gpio_type = 1,
+	  .i2c_adc = 0,
+	  .spi_dac = 1
+	 } ,
 	 /* MSI K8N Diamond Motherboard with onboard SB Live 24bit without AC97 */
 	 /* SB0438
 	  * CTRL:CA0106-DAT
-- 
1.7.0.4


--=-g8ouaCT8rh3B1kCcOO9M
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-g8ouaCT8rh3B1kCcOO9M--
