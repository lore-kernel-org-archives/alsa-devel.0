From: Timur Tabi <timur@tabi.org>
Subject: [PATCH] ASoC: fsl-ssi: fix do_div build warning in
	fsl_ssi_set_bclk()
Date: Thu, 12 Jun 2014 22:43:41 -0500
Message-ID: <1402631021-10426-1-git-send-email-timur@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cdptpa-oedge-vip.email.rr.com
 (cdptpa-outbound-snat.email.rr.com [107.14.166.228])
 by alsa0.perex.cz (Postfix) with ESMTP id 70D812610A7
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 05:43:42 +0200 (CEST)
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

do_div() requires that the first parameter is a 64-bit integer,
which but clkrate was defined as an unsigned long.  This caused
the following warnings:

 CC      sound/soc/fsl/fsl_ssi.o
sound/soc/fsl/fsl_ssi.c: In function 'fsl_ssi_set_bclk':
sound/soc/fsl/fsl_ssi.c:593:3: warning: comparison of distinct pointer types lacks a cast
sound/soc/fsl/fsl_ssi.c:593:3: warning: right shift count >= width of type
sound/soc/fsl/fsl_ssi.c:593:3: warning: passing argument 1 of '__div64_32' from incompatible pointer type
include/asm-generic/div64.h:35:17: note: expected 'uint64_t *' but argument is of type 'long unsigned int *'

Signed-off-by: Timur Tabi <timur@tabi.org>
---

Note: I cannot test this code because I do not have a platform
that runs the SSI in master mode.

 sound/soc/fsl/fsl_ssi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 9bfef55..9d98340 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -555,8 +555,8 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 	struct regmap *regs = ssi_private->regs;
 	int synchronous = ssi_private->cpu_dai_drv.symmetric_rates, ret;
 	u32 pm = 999, div2, psr, stccr, mask, afreq, factor, i;
-	unsigned long clkrate, baudrate, tmprate;
-	u64 sub, savesub = 100000;
+	unsigned long baudrate, tmprate;
+	u64 clkrate, sub, savesub = 100000;
 	unsigned int freq;
 	bool baudclk_is_used;
 
-- 
1.7.11.7
