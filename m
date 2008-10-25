From: Luis Yanes <melus0@teleline.es>
Subject: patch for alsa-info.sh to quote [ -d $SYSFS ]
Date: Sat, 25 Oct 2008 14:38:03 +0200
Message-ID: <4903132B.29CA@teleline.es>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------718F3CB716E4"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirius.eb7gwl.ampr.org (33.Red-80-59-149.staticIP.rima-tde.net
	[80.59.149.33]) by alsa0.perex.cz (Postfix) with ESMTP id 7A69D2432C
	for <alsa-devel@alsa-project.org>;
	Sat, 25 Oct 2008 14:40:17 +0200 (CEST)
Received: from luis (polar.eb7gwl.ampr.org [192.168.1.250])
	by sirius.eb7gwl.ampr.org (8.12.8/8.12.8) with SMTP id m9PCe0Ep011600
	for <alsa-devel@alsa-project.org>; Sat, 25 Oct 2008 14:40:00 +0200
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

This is a multi-part message in MIME format.

--------------718F3CB716E4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Found a couple of bugs in http://www.alsa-project.org/alsa-info.sh
while running it in my system.

* old uname <= 2.0.11 doesn't accept -o argument
* $SYSFS is not quoted while checking if directory exist and fails if
empty

Attached is a small patch for the first of them, but think that all
variables also should be quoted to avoid future problems.

Regards.

--------------718F3CB716E4
Content-Type: text/plain; charset=us-ascii; name="alsa-info.sh.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="alsa-info.sh.diff"

--- alsa-info.sh.orig	Sat Oct 25 14:16:43 2008
+++ alsa-info.sh	Sat Oct 25 14:18:44 2008
@@ -373,7 +373,7 @@
 echo "" >> $FILE
 fi
 
-if [ -d $SYSFS ]
+if [ -d "$SYSFS" ]
 then
 echo "!!Loaded sound module options" >> $FILE
 echo "!!--------------------------" >> $FILE

--------------718F3CB716E4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------718F3CB716E4--
