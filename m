From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v2] ASoC: pcm3168a: remove unused variable
Date: Fri,  4 Mar 2016 16:27:14 +0530
Message-ID: <1457089034-12951-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
 [209.85.220.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 182FB260673
 for <alsa-devel@alsa-project.org>; Fri,  4 Mar 2016 11:57:25 +0100 (CET)
Received: by mail-pa0-f50.google.com with SMTP id fy10so33177037pac.1
 for <alsa-devel@alsa-project.org>; Fri, 04 Mar 2016 02:57:25 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

While building we were getting build warning about:
sound/soc/codecs/pcm3168a.c:403:21: warning: variable 'channels' set but
not used

The variable channels were being assigned some value but that was never
reused.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---

v2: From: address changed

 sound/soc/codecs/pcm3168a.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index 0c7248a..992a77e 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -400,13 +400,12 @@ static int pcm3168a_hw_params(struct snd_pcm_substream *substream,
 	struct pcm3168a_priv *pcm3168a = snd_soc_codec_get_drvdata(codec);
 	bool tx, master_mode;
 	u32 val, mask, shift, reg;
-	unsigned int rate, channels, fmt, ratio, max_ratio;
+	unsigned int rate, fmt, ratio, max_ratio;
 	int i, min_frame_size;
 	snd_pcm_format_t format;
 
 	rate = params_rate(params);
 	format = params_format(params);
-	channels = params_channels(params);
 
 	ratio = pcm3168a->sysclk / rate;
 
-- 
1.9.1
