Return-Path: <SRS0=XflM=2Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0612FC2D0C2
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 17:59:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 867D7215A4
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 17:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QHNaRrNS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 867D7215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ll.mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8BDA81772;
	Fri,  3 Jan 2020 18:58:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8BDA81772
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578074373;
	bh=P9iOWZcR2nygeSsmsaByeCeHSgk2n9s+1zJdetn7MsI=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QHNaRrNSmrzv0MDFd2+uKbMleh2zoGJ3duwYwFXhB7DfoPU41ZBKevwmGLFObUDp7
	 /Uc2XmXnVnxJDhPyGB5aBQYxHC6Uic3ax6fC+HRHYIt1x0t8Wf+vZ5RwcyQUz3mFgH
	 PPoJoleEe9ZQ7ErHfW1MTr2sovdWSVsKDRqUr3uA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 56882F80279;
	Fri,  3 Jan 2020 18:56:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CF2A1F8013E; Fri,  3 Jan 2020 18:56:21 +0100 (CET)
Received: from llmx3.ll.mit.edu (llmx3.ll.mit.edu [129.55.12.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 66146F8013E
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2020 18:56:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 66146F8013E
Received: from LLE2K16-MBX01.mitll.ad.local (LLE2K16-MBX01.mitll.ad.local) by
 llmx3.ll.mit.edu (unknown) with ESMTPS id 003HuGtZ011841;
 Fri, 3 Jan 2020 12:56:16 -0500
From: David Ward <david.ward@ll.mit.edu>
To: Takashi Iwai <tiwai@suse.de>, <alsa-devel@alsa-project.org>
Date: Fri, 3 Jan 2020 12:55:50 -0500
Message-ID: <1578074158-30328-4-git-send-email-david.ward@ll.mit.edu>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578074158-30328-1-git-send-email-david.ward@ll.mit.edu>
References: <1578074158-30328-1-git-send-email-david.ward@ll.mit.edu>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2020-01-03_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001030164
Cc: David Ward <david.ward@ll.mit.edu>
Subject: [alsa-devel] [PATCH v2 alsa-utils 03/11] alsa-info.sh: Simplify
	iteration over cards when calling amixer
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

Read card names directly from individual procfs files, and pass them
to amixer using the '-c' option.

Signed-off-by: David Ward <david.ward@ll.mit.edu>
---
 alsa-info/alsa-info.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/alsa-info/alsa-info.sh b/alsa-info/alsa-info.sh
index d6d0935..ff3cf95 100755
--- a/alsa-info/alsa-info.sh
+++ b/alsa-info/alsa-info.sh
@@ -144,12 +144,12 @@ withamixer() {
         echo "!!Amixer output" >> $FILE
         echo "!!-------------" >> $FILE
         echo "" >> $FILE
-	for i in $(grep "]: " /proc/asound/cards | awk -F ' ' '{ print $1 }') ; do
-		CARD_NAME=$(grep "^ *$i " $TEMPDIR/alsacards.tmp | awk '{ print $2 }')
-		echo "!!-------Mixer controls for card $i $CARD_NAME]" >> $FILE
+	for f in /proc/asound/card*/id; do
+		[ -f "$f" ] && read -r CARD_NAME < "$f" || continue
+		echo "!!-------Mixer controls for card $CARD_NAME" >> $FILE
 		echo "" >>$FILE
-		amixer -c$i info >> $FILE 2>&1
-		amixer -c$i >> $FILE 2>&1
+		amixer -c "$CARD_NAME" info >> $FILE 2>&1
+		amixer -c "$CARD_NAME" >> $FILE 2>&1
 		echo "" >> $FILE
 	done
 	echo "" >> $FILE
-- 
1.8.3.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
