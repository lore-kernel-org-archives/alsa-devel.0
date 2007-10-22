From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH] WM9712 SoC driver fixes (was WM9712 monoout)
Date: Mon, 22 Oct 2007 17:16:08 +0200
Message-ID: <471CBEB8.7010904@compulab.co.il>
References: <471B012E.6050802@compulab.co.il>	<1193050024.7052.132.camel@localhost.localdomain>	<471CAFBE.9060509@compulab.co.il>
	<s5hprz7thjx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sa15.bezeqint.net (sa15.bezeqint.net [192.115.104.30])
	by alsa0.perex.cz (Postfix) with ESMTP id AA94424916
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Oct 2007 17:25:13 +0200 (CEST)
In-Reply-To: <s5hprz7thjx.wl%tiwai@suse.de>
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
Cc: Liam Girdwood <liam.girdwood@wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



Takashi Iwai wrote:
> At Mon, 22 Oct 2007 16:12:14 +0200,
> Mike Rapoport wrote:
>>>
>> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> 
> A short description of your patch would be appreciated so that I can
> commit it to the upstream tree.

Sorry, missed that...

The following patch adds "Mono Playback Switch" control to WM9712 codec SoC driver.
Also, it fixes Treble, Bass and Mono playback volume inversion bits.

Signed-off-by: Mike Rapoport <mike@compulab.co.il>

 sound/soc/codecs/wm9712.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 986b5d5..427cb61 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -102,7 +102,8 @@ SOC_SINGLE("Speaker Playback ZC Switch", AC97_MASTER, 7, 1, 0),
 SOC_SINGLE("Speaker Playback Invert Switch", AC97_MASTER, 6, 1, 0),
 SOC_SINGLE("Headphone Playback ZC Switch", AC97_HEADPHONE, 7, 1, 0),
 SOC_SINGLE("Mono Playback ZC Switch", AC97_MASTER_MONO, 7, 1, 0),
-SOC_SINGLE("Mono Playback Volume", AC97_MASTER_MONO, 0, 31, 0),
+SOC_SINGLE("Mono Playback Volume", AC97_MASTER_MONO, 0, 31, 1),
+SOC_SINGLE("Mono Playback Switch", AC97_MASTER_MONO, 15, 1, 1),

 SOC_SINGLE("ALC Target Volume", AC97_CODEC_CLASS_REV, 12, 15, 0),
 SOC_SINGLE("ALC Hold Time", AC97_CODEC_CLASS_REV, 8, 15, 0),
@@ -145,8 +146,8 @@ SOC_ENUM("Bass Control", wm9712_enum[5]),
 SOC_SINGLE("Bass Cut-off Switch", AC97_MASTER_TONE, 12, 1, 1),
 SOC_SINGLE("Tone Cut-off Switch", AC97_MASTER_TONE, 4, 1, 1),
 SOC_SINGLE("Playback Attenuate (-6dB) Switch", AC97_MASTER_TONE, 6, 1, 0),
-SOC_SINGLE("Bass Volume", AC97_MASTER_TONE, 8, 15, 0),
-SOC_SINGLE("Treble Volume", AC97_MASTER_TONE, 0, 15, 0),
+SOC_SINGLE("Bass Volume", AC97_MASTER_TONE, 8, 15, 1),
+SOC_SINGLE("Treble Volume", AC97_MASTER_TONE, 0, 15, 1),

 SOC_SINGLE("Capture ADC Switch", AC97_REC_GAIN, 15, 1, 1),
 SOC_ENUM("Capture Volume Steps", wm9712_enum[6]),
