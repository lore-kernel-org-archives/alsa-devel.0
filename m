Return-Path: <SRS0=ZLIO=2L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BDCC43603
	for <alsa-devel@archiver.kernel.org>; Sat, 21 Dec 2019 05:37:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1490A21775
	for <alsa-devel@archiver.kernel.org>; Sat, 21 Dec 2019 05:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tQmB9VFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1490A21775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ll.mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 20AE21677;
	Sat, 21 Dec 2019 06:36:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 20AE21677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576906654;
	bh=eRuAIU2GQGX7/23LG+RVDt3BDufUqh3o9zSgs/nlRlM=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tQmB9VFwr+PkmviQFEMaE++0p0/9t9GWOLKDUXeBBq8MCThWHaI9VxTX7a97ZIem7
	 60R4nQM8lVSfVKknqt+pTfaLfzMG6MgYUs8n/PiH1SRZMkKI929qRTvpbpVZfnB/4y
	 VGwMxAWqa/ZQBOSE+/vHQ88hKTottDY9PGaZDNXo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B1C4BF80290;
	Sat, 21 Dec 2019 06:32:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ED2BBF80271; Sat, 21 Dec 2019 06:32:31 +0100 (CET)
Received: from llmx2.ll.mit.edu (llmx2.ll.mit.edu [129.55.12.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 97F6CF8023F
 for <alsa-devel@alsa-project.org>; Sat, 21 Dec 2019 06:32:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 97F6CF8023F
Received: from LLE2K16-MBX03.mitll.ad.local (LLE2K16-MBX03.mitll.ad.local) by
 llmx2.ll.mit.edu (unknown) with ESMTPS id xBL5WOis023816 for
 <alsa-devel@alsa-project.org>; Sat, 21 Dec 2019 00:32:24 -0500
From: David Ward <david.ward@ll.mit.edu>
To: <alsa-devel@alsa-project.org>
Date: Sat, 21 Dec 2019 00:32:06 -0500
Message-ID: <1576906331-5212-7-git-send-email-david.ward@ll.mit.edu>
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
Subject: [alsa-devel] [PATCH alsa-utils 06/11] alsa-info.sh: Replace gauge
	with infobox for upload dialog
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

The gauge did not actually show the upload progress; in fact, the
dialog did not even appear until after the upload was completed.

Use an infobox instead, which will be displayed while wget runs.

Signed-off-by: David Ward <david.ward@ll.mit.edu>
---
 alsa-info/alsa-info.sh | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/alsa-info/alsa-info.sh b/alsa-info/alsa-info.sh
index 372d7ae..a02864d 100755
--- a/alsa-info/alsa-info.sh
+++ b/alsa-info/alsa-info.sh
@@ -830,19 +830,11 @@ if [[ -n $DIALOG ]]
 then
 
 if [[ -z $PASTEBIN ]]; then
+	dialog --backtitle "$BGTITLE" --infobox "Uploading information to www.alsa-project.org ..." 6 70
 	wget -O - --tries=5 --timeout=60 --post-file=$FILE "http://www.alsa-project.org/cardinfo-db/" &>$TEMPDIR/wget.tmp || echo "Upload failed; exit"
-	{ for i in 10 20 30 40 50 60 70 80 90; do
-		echo $i
-		sleep 0.2
-	done
-	echo; } |dialog --backtitle "$BGTITLE" --guage "Uploading information to www.alsa-project.org ..." 6 70 0
 else
+	dialog --backtitle "$BGTITLE" --infobox "Uploading information to www.pastebin.ca ..." 6 70
 	wget -O - --tries=5 --timeout=60 --post-file=$FILE "http://pastebin.ca/quiet-paste.php?api=$PASTEBINKEY&encrypt=t&encryptpw=blahblah" &>$TEMPDIR/wget.tmp || echo "Upload failed; exit"
-	{ for i in 10 20 30 40 50 60 70 80 90; do
-		echo $i
-		sleep 0.2
-	done
-	echo; } |dialog --backtitle "$BGTITLE" --guage "Uploading information to www.pastebin.ca ..." 6 70 0
 fi
 
 dialog --backtitle "$BGTITLE" --title "Information uploaded" --yesno "Would you like to see the uploaded information?" 5 100 
-- 
1.8.3.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
