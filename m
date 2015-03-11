From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 11/15] ASoC: ab8500-codec: don't export static
	symbol
Date: Wed, 11 Mar 2015 17:56:33 +0100
Message-ID: <1426092997-30605-12-git-send-email-Julia.Lawall@lip6.fr>
References: <1426092997-30605-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by alsa0.perex.cz (Postfix) with ESMTP id CA0A8265325
 for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2015 18:04:12 +0100 (CET)
In-Reply-To: <1426092997-30605-1-git-send-email-Julia.Lawall@lip6.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, daniel@iogearbox.net, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

The semantic patch that fixes this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r@
type T;
identifier f;
@@

static T f (...) { ... }

@@
identifier r.f;
declarer name EXPORT_SYMBOL_GPL;
@@

-EXPORT_SYMBOL_GPL(f);
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 sound/soc/codecs/ab8500-codec.c |    2 --
 1 file changed, 2 deletions(-)

diff -u -p a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -2003,7 +2003,6 @@ static int ab8500_audio_setup_mics(struc
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(ab8500_audio_setup_mics);
 
 static int ab8500_audio_set_ear_cmv(struct snd_soc_codec *codec,
 				enum ear_cm_voltage ear_cmv)
@@ -2036,7 +2035,6 @@ static int ab8500_audio_set_ear_cmv(stru
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(ab8500_audio_set_ear_cmv);
 
 static int ab8500_audio_set_bit_delay(struct snd_soc_dai *dai,
 				unsigned int delay)
