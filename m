From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] Alsa-info: Fix typo
Date: Wed, 05 Jan 2011 11:27:56 +0100
Message-ID: <4D2447AC.30303@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040708040905060207070505"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 06288103914
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2011 11:27:58 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040708040905060207070505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This simple typo has annoyed me for a while. Please fix it, so
I can focus on more important issues :-)

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------040708040905060207070505
Content-Type: text/x-patch;
 name="0001-Alsa-info-Fix-typo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Alsa-info-Fix-typo.patch"

>From 417f87254109927514c5191e45dfc6fd282ba3e9 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Wed, 5 Jan 2011 11:18:40 +0100
Subject: [PATCH] Alsa-info: Fix typo

This simple typo has annoyed me for a while. Please fix it, so
I can focus on more important issues :-)

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 utils/alsa-info.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/utils/alsa-info.sh b/utils/alsa-info.sh
index c9d2a4e..1de7507 100755
--- a/utils/alsa-info.sh
+++ b/utils/alsa-info.sh
@@ -540,7 +540,7 @@ echo "" >> $FILE
 cat $TEMPDIR/lspci.tmp >> $FILE
 echo "" >> $FILE
 echo "" >> $FILE
-echo "!!Advanced information - PCI Vendor/Device/Susbsystem ID's" >> $FILE
+echo "!!Advanced information - PCI Vendor/Device/Subsystem ID's" >> $FILE
 echo "!!--------------------------------------------------------" >> $FILE
 echo "" >> $FILE
 lspci -vvn |grep -A1 040[1-3] >> $FILE
-- 
1.7.1


--------------040708040905060207070505
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------040708040905060207070505--
