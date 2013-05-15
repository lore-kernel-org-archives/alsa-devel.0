From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: wm8994: missing break in
	wm8994_get_fll_config()
Date: Wed, 15 May 2013 10:09:43 +0300
Message-ID: <20130515070943.GB20381@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id D74402610C4
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 09:09:56 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, patches@opensource.wolfsonmicro.com, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Smatch complains that:

	sound/soc/codecs/wm8994.c:2087 wm8994_get_fll_config()
		warn: missing break? reassigning 'fll->k'

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 9f32dd8..303d755 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2080,6 +2080,7 @@ static int wm8994_get_fll_config(struct wm8994 *control, struct fll_div *fll,
 		fll->k = K / 10;
 
 		pr_debug("N=%x K=%x\n", fll->n, fll->k);
+		break;
 
 	default:
 		gcd_fll = gcd(freq_out, freq_in);
