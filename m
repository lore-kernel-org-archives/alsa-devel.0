Return-Path: <SRS0=ZLIO=2L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62268C43603
	for <alsa-devel@archiver.kernel.org>; Sat, 21 Dec 2019 05:41:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E157C2070B
	for <alsa-devel@archiver.kernel.org>; Sat, 21 Dec 2019 05:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JpMHePdf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E157C2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ll.mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4904615E5;
	Sat, 21 Dec 2019 06:40:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4904615E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576906861;
	bh=5Ebp4ldTfGOQP64kkh32zaiK32+CNGoOtxBC8mzmf7E=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JpMHePdfWK+pZ+kMnm81L0YoWAL52aaKK8bl7Hvv+Edoo6iwe+W21+OoeB4ZoEgWm
	 65YZh4IdLyEMO2ZON/0MzyMDhehsAUja+sAxKORXXt4bwAfjQeWArV+rZBYIOc5Kwi
	 rgrdxFrlMEodsbYi6HP1anAaoq+rSdqLkEXEN7Nw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D5A1DF802EC;
	Sat, 21 Dec 2019 06:32:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 885C6F8027B; Sat, 21 Dec 2019 06:32:38 +0100 (CET)
Received: from llmx3.ll.mit.edu (llmx3.ll.mit.edu [129.55.12.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 022BAF8026A
 for <alsa-devel@alsa-project.org>; Sat, 21 Dec 2019 06:32:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 022BAF8026A
Received: from LLE2K16-MBX03.mitll.ad.local (LLE2K16-MBX03.mitll.ad.local) by
 llmx3.ll.mit.edu (unknown) with ESMTPS id xBL5WWOn023246 for
 <alsa-devel@alsa-project.org>; Sat, 21 Dec 2019 00:32:32 -0500
From: David Ward <david.ward@ll.mit.edu>
To: <alsa-devel@alsa-project.org>
Date: Sat, 21 Dec 2019 00:32:11 -0500
Message-ID: <1576906331-5212-12-git-send-email-david.ward@ll.mit.edu>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576906331-5212-1-git-send-email-david.ward@ll.mit.edu>
References: <1576906331-5212-1-git-send-email-david.ward@ll.mit.edu>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-12-20_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912210045
Cc: David Ward <david.ward@ll.mit.edu>
Subject: [alsa-devel] [PATCH alsa-utils 11/11] alsa-info.sh: Warn after
	actual upload failure; do not ping server
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Check the return value of wget to determine if the upload actually
failed. If so, display the message about upload failure, then exit.

Do not ping the web server; the result does not indicate whether a
file upload will succeed or not.

Signed-off-by: David Ward <david.ward@ll.mit.edu>
---
 alsa-info/alsa-info.sh | 58 ++++++++++++++++++++++----------------------------
 1 file changed, 25 insertions(+), 33 deletions(-)

diff --git a/alsa-info/alsa-info.sh b/alsa-info/alsa-info.sh
index 399d662..7bae30a 100755
--- a/alsa-info/alsa-info.sh
+++ b/alsa-info/alsa-info.sh
@@ -35,22 +35,12 @@ BGTITLE="ALSA-Info v $SCRIPT_VERSION"
 PASTEBINKEY="C9cRIO8m/9y8Cs0nVs0FraRx7U0pHsuc"
 
 WGET=$(which wget 2>/dev/null | sed 's|^[^/]*||' 2>/dev/null)
-REQUIRES="mktemp grep pgrep whereis ping awk date uname cat sort dmesg amixer alsactl"
+REQUIRES="mktemp grep pgrep whereis awk date uname cat sort dmesg amixer alsactl"
 
 #
 # Define some simple functions
 #
 
-pbcheck() {
-	[[ $UPLOAD = "no" ]] && return
-
-	if [[ -z $PASTEBIN ]]; then
-		[[ $(ping -c1 www.alsa-project.org) ]] || KEEP_FILES="yes" UPLOAD="no" PBERROR="yes"
-	else
-		[[ $(ping -c1 www.pastebin.ca) ]] || KEEP_FILES="yes" UPLOAD="no" PBERROR="yes"
-	fi
-}
-
 update() {
 	test -z "$WGET" -o ! -x "$WGET" && return
 
@@ -650,7 +640,6 @@ fi
 #If no command line options are specified, then run as though --with-all was specified
 if [ -z "$1" ]; then
 	update
-	pbcheck	
 fi
 
 fi # proceed
@@ -662,7 +651,6 @@ if [ -n "$1" ]; then
 	case "$1" in
 		--pastebin)
 		        update
-        		pbcheck
 			;;
 		--update)
 			update
@@ -832,25 +820,11 @@ if [ "$UPLOAD" = "no" ]; then
 
 	if [[ -n $DIALOG ]]
 	then
-		if [[ -n $PBERROR ]]; then
-			dialog --backtitle "$BGTITLE" --title "Information collected" --msgbox "An error occurred while contacting the $WWWSERVICE.\n Your information was NOT automatically uploaded.\n\nYour ALSA information is in $NFILE" 10 100
-		else
-			dialog --backtitle "$BGTITLE" --title "Information collected" --msgbox "\n\nYour ALSA information is in $NFILE" 10 60
-		fi
+		dialog --backtitle "$BGTITLE" --title "Information collected" --msgbox "\n\nYour ALSA information is in $NFILE" 10 60
 	else
-		echo
-
-		if [[ -n $PBERROR ]]; then
-			echo "An error occurred while contacting the $WWWSERVICE."
-			echo "Your information was NOT automatically uploaded."
-			echo ""
-			echo "Your ALSA information is in $NFILE"
-			echo ""
-		else
-			echo ""
-			echo "Your ALSA information is in $NFILE"
-			echo ""
-		fi
+		echo ""
+		echo "Your ALSA information is in $NFILE"
+		echo ""
 	fi
 
 	exit
@@ -865,9 +839,27 @@ else
 fi
 
 if [[ -z $PASTEBIN ]]; then
-	wget -O - --tries=5 --timeout=60 --post-file=$FILE "http://www.alsa-project.org/cardinfo-db/" &>$TEMPDIR/wget.tmp || echo "Upload failed; exit"
+	wget -O - --tries=5 --timeout=60 --post-file=$FILE "http://www.alsa-project.org/cardinfo-db/" &>$TEMPDIR/wget.tmp
 else
-	wget -O - --tries=5 --timeout=60 --post-file=$FILE "http://pastebin.ca/quiet-paste.php?api=$PASTEBINKEY&encrypt=t&encryptpw=blahblah" &>$TEMPDIR/wget.tmp || echo "Upload failed; exit"
+	wget -O - --tries=5 --timeout=60 --post-file=$FILE "http://pastebin.ca/quiet-paste.php?api=$PASTEBINKEY&encrypt=t&encryptpw=blahblah" &>$TEMPDIR/wget.tmp
+fi
+
+if [ $? -ne 0 ]; then
+	mv -f $FILE $NFILE || exit 1
+	KEEP_OUTPUT="yes"
+
+	if [ -n "$DIALOG" ]; then
+		dialog --backtitle "$BGTITLE" --title "Information not uploaded" --msgbox "An error occurred while contacting $WWWSERVICE.\n Your information was NOT automatically uploaded.\n\nYour ALSA information is in $NFILE" 10 100
+	else
+		echo ""
+		echo "An error occurred while contacting $WWWSERVICE."
+		echo "Your information was NOT automatically uploaded."
+		echo ""
+		echo "Your ALSA information is in $NFILE"
+		echo ""
+	fi
+
+	exit
 fi
 
 if [ -n "$DIALOG" ]; then
-- 
1.8.3.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
