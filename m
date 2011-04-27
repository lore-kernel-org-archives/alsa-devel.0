From: Barry Song <bs14@csr.com>
Subject: [PATCH] ASoC: prevent compilers from optimising pll
	calculation into __aeabi__uldivmod
Date: Wed, 27 Apr 2011 00:27:32 -0700
Message-ID: <1303889252-6722-1-git-send-email-bs14@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cluster-g.mailcontrol.com (cluster-g.mailcontrol.com
	[208.87.233.190])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C7C81038BA
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Apr 2011 09:28:09 +0200 (CEST)
Received: from rly24g.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly24g.srv.mailcontrol.com (MailControl) with ESMTP id
	p3R7S4xW019936
	for <alsa-devel@alsa-project.org>; Wed, 27 Apr 2011 08:28:05 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly24g.srv.mailcontrol.com (MailControl) id p3R7S4EQ019874
	for <alsa-devel@alsa-project.org>; Wed, 27 Apr 2011 08:28:04 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: alsa-devel@alsa-project.org, Binghua Duan <binghua.duan@csr.com>, Barry Song <21cnbao@gmail.com>, Zhiwu Song <zhiwu.song@csr.com>
List-Id: alsa-devel@alsa-project.org

From: Barry Song <21cnbao@gmail.com>

The newest compiliers can optimize pll calculation in several codecs into __aeabi__uldivmod which doesn't exist in kernel.
Then the link will fail:
ERROR: "__aeabi_uldivmod" [sound/soc/codecs/snd-soc-wm8974.ko] undefined!
ERROR: "__aeabi_uldivmod" [sound/soc/codecs/snd-soc-wm8940.ko] undefined!
ERROR: "__aeabi_uldivmod" [sound/soc/codecs/snd-soc-wm8510.ko] undefined!
This patch prevent the optimizaton by insert ASM.

Signed-off-by: Barry Song <21cnbao@gmail.com>
Cc: Zhiwu Song <zhiwu.song@csr.com>
Cc: Binghua Duan <binghua.duan@csr.com>
---
 sound/soc/codecs/wm8510.c |    6 ++++++
 sound/soc/codecs/wm8940.c |    6 ++++++
 sound/soc/codecs/wm8974.c |    6 ++++++
 3 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index db0dced..a636b15 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -258,6 +258,12 @@ static void pll_factors(unsigned int target, unsigned int source)
 	Nmod = target % source;
 	Kpart = FIXED_PLL_SIZE * (long long)Nmod;
 
+	/*
+	 * The following asm() prevents the compiler from optimising
+	 * into a standard EABI function __aeabi__uldivmod()
+	 */
+	asm("" : "+r"(source));
+
 	do_div(Kpart, source);
 
 	K = Kpart & 0xFFFFFFFF;
diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index 25580e3..f6148af 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -520,6 +520,12 @@ static void pll_factors(unsigned int target, unsigned int source)
 	Nmod = target % source;
 	Kpart = FIXED_PLL_SIZE * (long long)Nmod;
 
+	/*
+	 * The following asm() prevents the compiler from optimising
+	 * into a standard EABI function __aeabi__uldivmod()
+	 */
+	asm("" : "+r"(source));
+
 	do_div(Kpart, source);
 
 	K = Kpart & 0xFFFFFFFF;
diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index ca646a8..c9036d9 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -317,6 +317,12 @@ static void pll_factors(struct pll_ *pll_div,
 	Nmod = target % source;
 	Kpart = FIXED_PLL_SIZE * (long long)Nmod;
 
+	/*
+	 * The following asm() prevents the compiler from optimising
+	 * into a standard EABI function __aeabi__uldivmod()
+	 */
+	asm("" : "+r"(source));
+
 	do_div(Kpart, source);
 
 	K = Kpart & 0xFFFFFFFF;
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
