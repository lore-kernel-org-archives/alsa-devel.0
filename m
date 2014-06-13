From: Timur Tabi <timur@tabi.org>
Subject: [PATCH v2] ASoC: fsl-ssi: fix do_div build warning in
	fsl_ssi_set_bclk()
Date: Fri, 13 Jun 2014 07:42:40 -0500
Message-ID: <1402663360-15377-1-git-send-email-timur@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cdptpa-oedge-vip.email.rr.com
 (cdptpa-outbound-snat.email.rr.com [107.14.166.229])
 by alsa0.perex.cz (Postfix) with ESMTP id 36766264EFA
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 14:42:42 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, nicoleotsuka@gmail.com
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
 sound/soc/fsl/fsl_ssi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 9bfef55..3043d57 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -590,8 +590,8 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 		else
 			clkrate = clk_round_rate(ssi_private->baudclk, tmprate);
 
-		do_div(clkrate, factor);
-		afreq = (u32)clkrate / (i + 1);
+		clkrate /= factor;
+		afreq = clkrate / (i + 1);
 
 		if (freq == afreq)
 			sub = 0;
-- 
1.7.11.7
