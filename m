From: Shawn Guo <shawn.guo@linaro.org>
Subject: ASoC: wm8962: NULL pdata pointer
Date: Thu, 4 Jul 2013 14:29:14 +0800
Message-ID: <20130704062913.GC14617@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B05E261B09
 for <alsa-devel@alsa-project.org>; Thu,  4 Jul 2013 08:28:46 +0200 (CEST)
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
To: Mark Brown <broonie@linaro.org>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Mark,

I'm running next-20130703 and seeing the following NULL pointer bug.

Unable to handle kernel NULL pointer dereference at virtual address 00000004
pgd = 80004000
[00000004] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.10.0-next-20130703 #6
task: bf870000 ti: bf874000 task.ti: bf874000
PC is at wm8962_probe+0x140/0x6b4
...

It seems to me that it's caused by a merge error in 384b834.  And the
change below can remove the problem.

Shawn

---8<----

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index b1dc7d4..e2de9ec 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3377,7 +3377,7 @@ static int wm8962_probe(struct snd_soc_codec *codec)
 {
        int ret;
        struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
-       struct wm8962_pdata *pdata = dev_get_platdata(codec->dev);
+       struct wm8962_pdata *pdata = &wm8962->pdata;
        int i, trigger, irq_pol;
        bool dmicclk, dmicdat;
