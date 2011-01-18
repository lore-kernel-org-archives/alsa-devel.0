From: Brian Bloniarz <brian.bloniarz@gmail.com>
Subject: [RFC PATCH] theory about CS8247 failed reads
Date: Mon, 17 Jan 2011 23:20:03 -0800
Message-ID: <4D353F23.4020900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id 1670F24719
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 08:20:10 +0100 (CET)
Received: by pzk34 with SMTP id 34so1125162pzk.38
	for <alsa-devel@alsa-project.org>; Mon, 17 Jan 2011 23:20:09 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On my M-Audio Delta 66 (rev. E), I see this line:
[   23.248721] invalid CS8427 signature 0x0: let me try again...

This is caused by the first request to the CS8427 failing, and
this workaround:

> commit 4eb4550ab37d351ab0973ccec921a5a2d8560ec7,
> Author: Takashi Iwai <tiwai@suse.de>
> Date:   Thu Sep 20 17:34:57 2007 +0200
>
>     [ALSA] Workaround for invalid signature read of CS8427
>     
>     Reading the signature of CS8427 over SPI/I2C fails on some devices
>     by mysterious reason.  In most cases, however, it succeeds at the
>     sequential read.  So, let's give a second chance to check the signature
>     again.
>     
>     Signed-off-by: Takashi Iwai <tiwai@suse.de>
>     Signed-off-by: Jaroslav Kysela <perex@suse.cz>

I have a theory, please read the patch and patch description below.
With the patch applied, the printk goes away.

Does this sound like a reasonable theory? Does anyone recall, did this
failed read occur on any cards besides M-Audio Delta? I'm wondering if
this is the whole explanation, in which case the previous workaround
could be removed.

------------------------

[PATCH] [ALSA] ice1712 delta - initialize SPI clock.

The driver was using an initial value for the clock on the SPI bus
which was read from ICE1712 EEPROM,
ice->eeprom.data[ICE_EEP1_GPIO_STATE] & ICE1712_DELTA_AP_CCLK (0x02)

It appears some cards have it default high, some cards
have it default low. On my Delta 66 rev. E:
$ cat /proc/asound/M66/ice1712 | grep 'GPIO state'
  GPIO state       : 0x70 /* ICE1712_DELTA_AP_CCLK bit is zero */
On my Audiophile 2496:
$ cat /proc/asound/M2496/ice1712 | grep 'GPIO state'
  GPIO state       : 0xfe /* ICE1712_DELTA_AP_CCLK bit is one */

It must be raised before the first SPI write happens, or the write will
fail, leading to:

[   23.248721] invalid CS8427 signature 0x0: let me try again...

I theorize that 4eb4550ab37d351ab0973ccec921a5a2d8560ec7
is no longer needed, it was a different way to workaround
the problem.

Signed-off-by: Brian Bloniarz <brian.bloniarz@gmail.com>
---
 sound/pci/ice1712/delta.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/sound/pci/ice1712/delta.c b/sound/pci/ice1712/delta.c
index 7b62de0..84a6031 100644
--- a/sound/pci/ice1712/delta.c
+++ b/sound/pci/ice1712/delta.c
@@ -622,6 +622,13 @@ static int __devinit snd_ice1712_delta_init(struct snd_ice1712 *ice)
                break;
        }
 
+       /* initialize the SPI clock to high */
+       unsigned char tmp;
+       tmp = snd_ice1712_read(ice, ICE1712_IREG_GPIO_DATA);
+       tmp |= ICE1712_DELTA_AP_CCLK;
+       snd_ice1712_write(ice, ICE1712_IREG_GPIO_DATA, tmp);
+       udelay(5);
+
        /* initialize spdif */
        switch (ice->eeprom.subvendor) {
        case ICE1712_SUBDEVICE_AUDIOPHILE:
-- 
1.7.1
