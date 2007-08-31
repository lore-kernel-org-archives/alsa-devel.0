From: Eliot Blennerhassett <linux@audioscience.com>
Subject: [PATCH mod-deps.c] Remove libs from toplevel driver
	list
Date: Fri, 31 Aug 2007 20:10:23 +1200
Message-ID: <200708312010.23579.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 5CCC5103806
	for <alsa-devel@alsa-project.org>;
	Fri, 31 Aug 2007 10:07:36 +0200 (CEST)
Received: from zaphod (121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JNM00M9ZP8KAI40@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Fri, 31 Aug 2007 20:07:32 +1200 (NZST)
Content-disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add 2 more libraries to list that gets filtered out when building the list of cards for configure.
(?Can't this be done automatically somehow?)

diff -r 49001ef1e617 utils/mod-deps.c
--- a/utils/mod-deps.c	Thu Aug 30 10:22:35 2007 +0200
+++ b/utils/mod-deps.c	Fri Aug 31 20:02:20 2007 +1200
@@ -169,6 +169,8 @@ static char *no_cards[] = {
 	"SND_VERBOSE_PROCFS",
 	"SND_VERBOSE_PRINTK",
 	"SND_BIT32_EMUL",
+	"#SND_AD1848_LIB",
+	"#SND_CS4231_LIB",
 	"#SND_SB_COMMON",
 	"#SND_SB8_DSP",
 	"#SND_SB16_DSP",
