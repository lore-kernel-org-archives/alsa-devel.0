From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 2/7] ASoC: ab8500: Inform SoC Core that we have
	our own I/O arrangements
Date: Fri, 27 Jul 2012 13:38:49 +0100
Message-ID: <1343392734-11805-3-git-send-email-lee.jones@linaro.org>
References: <1343392734-11805-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 6415D264F04
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2012 14:39:02 +0200 (CEST)
Received: by mail-we0-f179.google.com with SMTP id x10so1836409wey.38
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2012 05:39:04 -0700 (PDT)
In-Reply-To: <1343392734-11805-1-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, sameo@linux.intel.com, arnd@arndb.de, broonie@opensource.wolfsonmicro.com, olalilja@yahoo.se, STEricsson_nomadik_linux@list.st.com, Lee Jones <lee.jones@linaro.org>, lrg@ti.com, linus.walleij@stericsson.com
List-Id: alsa-devel@alsa-project.org

If codec->control_data is not populated SoC Core assumes we want to
use regmap, which fails catastrophically, as we don't have one:

Unable to handle kernel NULL pointer dereference at virtual address 00000080
pgd = c0004000
[00000080] *pgd=00000000
Internal error: Oops: 17 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 1    Not tainted  (3.5.0-rc6-00884-g0b2419e-dirty #130)
PC is at regmap_read+0x10/0x5c
LR is at hw_read+0x80/0x90
pc : [<c01a91b8>]    lr : [<c0216804>]    psr: 60000013

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/codecs/ab8500-codec.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index 3c79592..23b4018 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -2406,6 +2406,10 @@ static int ab8500_codec_probe(struct snd_soc_codec *codec)
 
 	/* Setup AB8500 according to board-settings */
 	pdata = (struct ab8500_platform_data *)dev_get_platdata(dev->parent);
+
+	/* Inform SoC Core that we have our own I/O arrangements. */
+	codec->control_data = (void *)true;
+
 	status = ab8500_audio_setup_mics(codec, &pdata->codec->amics);
 	if (status < 0) {
 		pr_err("%s: Failed to setup mics (%d)!\n", __func__, status);
-- 
1.7.9.5
