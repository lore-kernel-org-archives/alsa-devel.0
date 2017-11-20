From: Tanu Kaskinen <tanuk@iki.fi>
Subject: [PATCH alsa-tools] hdajacksensetest: add gitcompile to
	EXTRA_DIST
Date: Mon, 20 Nov 2017 19:05:28 +0200
Message-ID: <20171120170528.11998-1-tanuk@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 1994E266F52
 for <alsa-devel@alsa-project.org>; Mon, 20 Nov 2017 18:06:06 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The gitcompile script is used from the top-level Makefile, so it needs
to be included in the tarball.

Signed-off-by: Tanu Kaskinen <tanuk@iki.fi>
---
 hdajacksensetest/Makefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hdajacksensetest/Makefile.am b/hdajacksensetest/Makefile.am
index 795373c..893b4e1 100644
--- a/hdajacksensetest/Makefile.am
+++ b/hdajacksensetest/Makefile.am
@@ -1,3 +1,4 @@
+EXTRA_DIST = gitcompile
 MYNAME = hdajacksensetest
 AUTOMAKE_OPTIONS = foreign
 bin_PROGRAMS = hdajacksensetest
-- 
2.14.2
