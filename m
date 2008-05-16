From: Stas Sergeev <stsp@aknet.ru>
Subject: [patch] snd-pcsp: depend on CONFIG_EXPERIMENTAL
Date: Sat, 17 May 2008 02:14:12 +0400
Message-ID: <482E0734.7080003@aknet.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010609000006040908080401"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.aknet.ru [78.158.192.26])
	by alsa0.perex.cz (Postfix) with ESMTP id F33EC2478D
	for <alsa-devel@alsa-project.org>;
	Sat, 17 May 2008 00:14:15 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010609000006040908080401
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello.

Considering all the feedbacks I got,
depending snd-pcsp on CONFIG_EXPERIMENTAL
looks like the only safe way to get out
of all the troubles at one go. :)

Can the attached patch be applied?

Btw, it seems to me that the alsa-kernel
hg tree somehow lacks a few snd-pcsp patches
that the alsa git tree has... how have that
happened and how can be fixed?

--------------010609000006040908080401
Content-Type: text/x-patch;
 name="pcsp_exp.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcsp_exp.diff"

# HG changeset patch
# User Stas Sergeev <stsp@users.sourceforge.net>
# Date 1210975452 -14400
# Node ID 49d310de8ac42e5c495cf39440f4fde307b39c75
# Parent  3887126bbd9ca422208e651d46f9f5385d409efe
snd-pcsp: depend on CONFIG_EXPERIMENTAL

Signed-off-by: Stas Sergeev <stsp@aknet.ru>

diff -r 3887126bbd9c -r 49d310de8ac4 drivers/Kconfig
--- a/drivers/Kconfig	Fri May 16 22:01:53 2008 +0400
+++ b/drivers/Kconfig	Sat May 17 02:04:12 2008 +0400
@@ -6,6 +6,7 @@ menu "Generic devices"
 
 config SND_PCSP
 	tristate "Internal PC speaker support"
+	depends on EXPERIMENTAL
 	depends on X86_PC && HIGH_RES_TIMERS
 	depends on INPUT
 	depends on SND

--------------010609000006040908080401
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------010609000006040908080401--
