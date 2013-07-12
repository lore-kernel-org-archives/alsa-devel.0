From: Bo Shen <voice.shen@atmel.com>
Subject: Question about WM8904 regcache
Date: Fri, 12 Jul 2013 15:00:26 +0800
Message-ID: <51DFA98A.50900@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eusmtp01.atmel.com (eusmtp01.atmel.com [212.144.249.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 60645265119
 for <alsa-devel@alsa-project.org>; Fri, 12 Jul 2013 09:05:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,
   I am sorry to disturb you. On our EK board, it use wm8904 codec. When 
I enable the audio, and use alsa utils aplay to test, I meet the 
following issue.
   The audio can not playback, it show the following error.
---8>---
#aplay 44.1k_16bit_stereo.wav
Playing WAVE '44.1k_16bit_stereo.wav' : Signed 16 bit Little Endian, 
Rate 44100 Hz, Stereo
aplay: pcm_write:1737: write error: Input/output error
---<8---

   After check the register, they are not be configured correctly. When 
read from debug file system, found the cache_dirty always Y before 
playback and also failed playback.
   I try to add the following two line in wm8904_set_bias_level into 
"case SND_SOC_BIAS_ON", it doesn't work.
---8>---
@@ -1832,9 +1834,12 @@ static int wm8904_set_bias_level(struct 
snd_soc_codec *codec,

         switch (level) {
         case SND_SOC_BIAS_ON:
+               regcache_cache_only(wm8904->regmap, false);
+               regcache_sync(wm8904->regmap);
                 break;
---<8---

   However, If I comment the regcache_cache_only(wm8904->regmap, true) 
as following, then it play OK.
---8>---
@@ -2232,7 +2239,7 @@ static int wm8904_i2c_probe(struct i2c_client *i2c,
                             WM8904_POBCTRL, 0);

         /* Can leave the device powered off until we need it */
-       regcache_cache_only(wm8904->regmap, true);
+       // regcache_cache_only(wm8904->regmap, true);
---<8---

   So, any clue for this issue?

   Thanks.

Best Regards,
Bo Shen
