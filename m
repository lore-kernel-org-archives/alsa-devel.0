From: Rolland Dudemaine <rolland@ghs.com>
Subject: pcm_empty.c in doxygen
Date: Fri, 10 Aug 2007 13:15:23 +0200
Message-ID: <46BC48CB.4070200@ghs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp21.orange.fr (smtp21.orange.fr [80.12.242.46])
	by alsa0.perex.cz (Postfix) with ESMTP id 8502A103811
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Aug 2007 13:15:29 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2106.orange.fr (SMTP Server) with ESMTP id AC5FD1C00095
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Aug 2007 13:15:28 +0200 (CEST)
Received: from [127.0.0.1] (ASt-Lambert-152-1-70-77.w86-217.abo.wanadoo.fr
	[86.217.64.77])
	by mwinf2106.orange.fr (SMTP Server) with ESMTP id 7AEA51C00093
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Aug 2007 13:15:28 +0200 (CEST)
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

Hi,

It looks like the doxygen-generated documentation lacks the pcm/pcm_empty.c bit.
Since the default plugin uses empty as plugin, it's useful to have docs for it.

Here is a diff to apply to solve this.
--- doc/doxygen.cfg.old 2007-08-10 13:14:00.000000000 +0200
+++ doc/doxygen.cfg     2007-08-10 13:14:38.000000000 +0200
@@ -72,6 +72,7 @@
                    ../src/pcm/pcm_ioplug.c \
                    ../src/pcm/pcm_misc.c \
                    ../src/pcm/pcm_simple.c \
+                  ../src/pcm/pcm_empty.c \
                    ../src/rawmidi \
                    ../src/timer \
                    ../src/hwdep \

Best Regards,
--Rolland Dudemaine
