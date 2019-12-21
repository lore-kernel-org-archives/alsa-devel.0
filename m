Return-Path: <SRS0=ZLIO=2L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E31C43603
	for <alsa-devel@archiver.kernel.org>; Sat, 21 Dec 2019 05:40:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EB392070B
	for <alsa-devel@archiver.kernel.org>; Sat, 21 Dec 2019 05:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HTUgw0fP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB392070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ll.mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D852C1677;
	Sat, 21 Dec 2019 06:39:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D852C1677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576906812;
	bh=E9Kb2B3PoFbFuuZ1/+rt47r0XCd+xkX/ABKSPmrLzYQ=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HTUgw0fPM8Fyl4sxEYEOhDX8a9CP/bQUKFPJoLxfOn+IRbGFMh587BJwl6v8rM+4k
	 mDGMtde3/CT0ECyRcLbdNj/k+14Mq1sFPL57EAm2LkyZZwCmMmArp3Bq40IrdCdy4P
	 aWON3VRfOepeb9uknUxaT9GUF2gI/9A/aQ7skPwU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7CC0EF802E7;
	Sat, 21 Dec 2019 06:32:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C8B8BF80277; Sat, 21 Dec 2019 06:32:36 +0100 (CET)
Received: from llmx2.ll.mit.edu (llmx2.ll.mit.edu [129.55.12.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A31CDF8023F
 for <alsa-devel@alsa-project.org>; Sat, 21 Dec 2019 06:32:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A31CDF8023F
Received: from LLE2K16-MBX03.mitll.ad.local (LLE2K16-MBX03.mitll.ad.local) by
 llmx2.ll.mit.edu (unknown) with ESMTPS id xBL5WVJu023823 for
 <alsa-devel@alsa-project.org>; Sat, 21 Dec 2019 00:32:31 -0500
From: David Ward <david.ward@ll.mit.edu>
To: <alsa-devel@alsa-project.org>
Date: Sat, 21 Dec 2019 00:32:10 -0500
Message-ID: <1576906331-5212-11-git-send-email-david.ward@ll.mit.edu>
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
Subject: [alsa-devel] [PATCH alsa-utils 10/11] alsa-info.sh: Perform test
	for wget earlier
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

If wget is not present, do not ask about uploading the information.

Signed-off-by: David Ward <david.ward@ll.mit.edu>
---
 alsa-info/alsa-info.sh | 73 ++++++++++++++++++++++++--------------------------
 1 file changed, 35 insertions(+), 38 deletions(-)

diff --git a/alsa-info/alsa-info.sh b/alsa-info/alsa-info.sh
index 8b4745b..399d662 100755
--- a/alsa-info/alsa-info.sh
+++ b/alsa-info/alsa-info.sh
@@ -769,6 +769,41 @@ if [ -z "$WITHALL" ]; then
 	withall
 fi
 
+# Check if wget is installed, and supports --post-file.
+if ! wget --help 2>/dev/null | grep -q post-file; then
+	# We couldn't find a suitable wget. If --upload was passed, tell the user to upload manually.
+	if [ "$UPLOAD" != "yes" ]; then
+		:
+	elif [ -n "$DIALOG" ]; then
+		if [ -z "$PASTEBIN" ]; then
+			dialog --backtitle "$BGTITLE" --msgbox "Could not automatically upload output to http://www.alsa-project.org.\nPossible reasons are:\n\n    1. Couldn't find 'wget' in your PATH\n    2. Your version of wget is less than 1.8.2\n\nPlease manually upload $NFILE to http://www.alsa-project.org/cardinfo-db/ and submit your post." 25 100
+		else
+			dialog --backtitle "$BGTITLE" --msgbox "Could not automatically upload output to http://www.pastebin.ca.\nPossible reasons are:\n\n    1. Couldn't find 'wget' in your PATH\n    2. Your version of wget is less than 1.8.2\n\nPlease manually upload $NFILE to http://www.pastebin.ca/upload.php and submit your post." 25 100
+		fi
+	else
+		if [ -z "$PASTEBIN" ]; then
+			echo ""
+			echo "Could not automatically upload output to http://www.alsa-project.org"
+			echo "Possible reasons are:"
+			echo "    1. Couldn't find 'wget' in your PATH"
+			echo "    2. Your version of wget is less than 1.8.2"
+			echo ""
+			echo "Please manually upload $NFILE to http://www.alsa-project.org/cardinfo-db/ and submit your post."
+			echo ""
+		else
+			echo ""
+			echo "Could not automatically upload output to http://www.pastebin.ca"
+			echo "Possible reasons are:"
+			echo "    1. Couldn't find 'wget' in your PATH"
+			echo "    2. Your version of wget is less than 1.8.2"
+			echo ""
+			echo "Please manually upload $NFILE to http://www.pastebin.ca/upload.php and submit your post."
+			echo ""
+		fi
+	fi
+	UPLOAD="no"
+fi
+
 if [ "$UPLOAD" = "ask" ]; then
 	if [ -n "$DIALOG" ]; then
 		dialog --backtitle "$BGTITLE" --title "Information collected" --yes-label " UPLOAD / SHARE " --no-label " SAVE LOCALLY " --defaultno --yesno "\n\nAutomatically upload ALSA information to $WWWSERVICE?" 10 80
@@ -822,10 +857,6 @@ if [ "$UPLOAD" = "no" ]; then
 
 fi # UPLOAD
 
-# Test that wget is installed, and supports --post-file. Upload $FILE if it does, and prompt user to upload file if it does not.
-if [[ -n "${WGET}" ]] && [[ -x "${WGET}" ]] && [[ $(wget --help | grep post-file) ]]
-then
-
 if [[ -n $DIALOG ]]
 then
 	dialog --backtitle "$BGTITLE" --infobox "Uploading information to $WWWSERVICE ..." 6 70
@@ -873,37 +904,3 @@ fi
 echo "Your ALSA information is located at $FINAL_URL"
 echo "Please inform the person helping you."
 echo ""
-
-# We couldnt find a suitable wget, so tell the user to upload manually.
-else
-	mv -f $FILE $NFILE || exit 1
-	KEEP_OUTPUT="yes"
-	if [[ -z $DIALOG ]]
-	then
-		if [[ -z $PASTEBIN ]]; then
-		echo ""
-		echo "Could not automatically upload output to http://www.alsa-project.org"
-		echo "Possible reasons are:"
-		echo "    1. Couldnt find 'wget' in your PATH"
-		echo "    2. Your version of wget is less than 1.8.2"
-		echo ""
-		echo "Please manually upload $NFILE to http://www.alsa-project.org/cardinfo-db/ and submit your post."
-		echo ""
-		else
-		echo ""
-		echo "Could not automatically upload output to http://www.pastebin.ca"
-		echo "Possible reasons are:"
-		echo "    1. Couldnt find 'wget' in your PATH"
-		echo "    2. Your version of wget is less than 1.8.2"
-		echo ""
-		echo "Please manually upload $NFILE to http://www.pastebin.ca/upload.php and submit your post."
-		echo ""
-		fi
-	else
-		if [[ -z $PASTEBIN ]]; then
-			dialog --backtitle "$BGTITLE" --msgbox "Could not automatically upload output to http://www.alsa-project.org.\nPossible reasons are:\n\n    1. Couldn't find 'wget' in your PATH\n    2. Your version of wget is less than 1.8.2\n\nPlease manually upload $NFILE to http://www.alsa-project,org/cardinfo-db/ and submit your post." 25 100
-		else
-			dialog --backtitle "$BGTITLE" --msgbox "Could not automatically upload output to http://www.pastebin.ca.\nPossible reasons are:\n\n    1. Couldn't find 'wget' in your PATH\n    2. Your version of wget is less than 1.8.2\n\nPlease manually upload $NFILE to http://www.pastebin.ca/upload.php and submit your post." 25 100
-		fi
-	fi
-fi
-- 
1.8.3.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
