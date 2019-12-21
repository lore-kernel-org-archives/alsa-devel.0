Return-Path: <SRS0=ZLIO=2L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81234C43603
	for <alsa-devel@archiver.kernel.org>; Sat, 21 Dec 2019 05:36:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0077421775
	for <alsa-devel@archiver.kernel.org>; Sat, 21 Dec 2019 05:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QFLF0kfM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0077421775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ll.mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 33C4B166F;
	Sat, 21 Dec 2019 06:35:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 33C4B166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576906572;
	bh=D2/tZoidpaAfhORH4ChxqVhz4/Ew2CrSi/bzwKHDV3Y=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QFLF0kfM1RBrk1Snu22BF6HyAexknKUvDgAXN+Nqi59nZqabiNT4qOwhXqn1tPF53
	 sLHnBGNNda3RZxu6qhPsgdWRai0x0DD4rHPe228qJxPy+fLgJS+bhu7AAHNs+XwJp2
	 FesKdoZE29W2pw7jyqes/zq3LWgV9M1pLISjvt2I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E2F92F8026A;
	Sat, 21 Dec 2019 06:32:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C4A32F80256; Sat, 21 Dec 2019 06:32:28 +0100 (CET)
Received: from llmx3.ll.mit.edu (llmx3.ll.mit.edu [129.55.12.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C2706F800BC
 for <alsa-devel@alsa-project.org>; Sat, 21 Dec 2019 06:32:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C2706F800BC
Received: from LLE2K16-MBX03.mitll.ad.local (LLE2K16-MBX03.mitll.ad.local) by
 llmx3.ll.mit.edu (unknown) with ESMTPS id xBL5WKme023210 for
 <alsa-devel@alsa-project.org>; Sat, 21 Dec 2019 00:32:20 -0500
From: David Ward <david.ward@ll.mit.edu>
To: <alsa-devel@alsa-project.org>
Date: Sat, 21 Dec 2019 00:32:03 -0500
Message-ID: <1576906331-5212-4-git-send-email-david.ward@ll.mit.edu>
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
Subject: [alsa-devel] [PATCH alsa-utils 03/11] alsa-info.sh: Simplify
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
index ed1d9e2..e1067d4 100755
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
