From: Travis Place <wishie@wishie.net>
Subject: [PATCH] alsa-info.sh - Add checks for device
	permissions
Date: Sat, 23 Aug 2008 02:34:59 +1000
Message-ID: <200808230234.59730.wishie@wishie.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_zqurIeRQ8GPI0Of"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.wishie.net (202-137-100-224.dial.usertools.net
	[202.137.100.224])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D44E103880
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Aug 2008 18:35:04 +0200 (CEST)
Received: from laptop.local (unknown [192.168.0.200])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.wishie.net (Postfix) with ESMTP id 252D65B70C
	for <alsa-devel@alsa-project.org>; Fri, 22 Aug 2008 16:59:23 +1000 (EST)
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

--Boundary-00=_zqurIeRQ8GPI0Of
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Changelog: 

1) Show if the script was run as root, or as a user.

2) Check the group permissions of the ALSA device nodes, and check to see if 
the user is in that group, and display a warning if they are not.

3) Bumped version to 0.4.52

Signed-off-by: Travis Place <wishie@wishie.net>

Notes: Im sure this code is far from perfect, and welcome any changes to it.

--Boundary-00=_zqurIeRQ8GPI0Of
Content-Type: text/x-diff;
  charset="us-ascii";
  name="alsa-info.sh_0.4.52.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="alsa-info.sh_0.4.52.patch"

--- alsa-info.sh	2008-08-23 02:30:27.000000000 +1000
+++ alsa-info.sh.latest	2008-08-23 02:30:38.000000000 +1000
@@ -1,6 +1,6 @@
 #!/bin/bash
 
-SCRIPT_VERSION=0.4.51
+SCRIPT_VERSION=0.4.52
 CHANGELOG="http://www.alsa-project.org/alsa-info.sh.changelog"
 
 #################################################################################
@@ -138,6 +138,12 @@
         echo "!!-----------------" >> $FILE
         echo "" >> $FILE
         ls -la /dev/snd/* >> $FILE
+	if [[ $USER != "root" ]];then
+	echo "" >> $FILE
+	for groups in `ls -la /dev/snd/*|awk {'print $4'}`; do
+	groups $USER|grep $groups >/dev/null || echo "User not in group $groups!" >> $FILE;
+	done
+	fi
         echo "" >> $FILE
         echo "" >> $FILE
 }
@@ -312,6 +318,7 @@
 echo "!!################################" >> $FILE
 echo "" >> $FILE
 echo "!!Script ran on: `LANG=C date`" >> $FILE
+echo "!!Script ran as: `if [ $USER == "root" ];then echo 'Root'; else echo 'A User';fi`" >> $FILE
 echo "" >> $FILE
 echo "" >> $FILE
 echo "!!Linux Distribution" >> $FILE

--Boundary-00=_zqurIeRQ8GPI0Of
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_zqurIeRQ8GPI0Of--
