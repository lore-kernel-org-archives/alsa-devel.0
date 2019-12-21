Return-Path: <SRS0=ZLIO=2L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AEAC43603
	for <alsa-devel@archiver.kernel.org>; Sat, 21 Dec 2019 05:34:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5887A21655
	for <alsa-devel@archiver.kernel.org>; Sat, 21 Dec 2019 05:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mTjeDl/Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5887A21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ll.mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A263D165D;
	Sat, 21 Dec 2019 06:33:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A263D165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576906451;
	bh=Lpj/nXacpETPceDEKD3TzEbrdQvNoPF6UBviLhdsjrA=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mTjeDl/Y/Vd6otlqZ3InTDpJXlbnMh80176CqvAIs+rQuQwRaxAi1tsMqY11XD82M
	 2b/27D4T9V55rfxVFPdQ4QR6grVClrP09MBCSsPV2OWBwXzGjj4xyo0E6jAURzwCCA
	 8GjH9zaQx0BVHYYQe4DZkkqPz543yDd70mNEGDOo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 56306F800E0;
	Sat, 21 Dec 2019 06:32:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B32CCF8023F; Sat, 21 Dec 2019 06:32:23 +0100 (CET)
Received: from llmx3.ll.mit.edu (llmx3.ll.mit.edu [129.55.12.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 23E94F800BC
 for <alsa-devel@alsa-project.org>; Sat, 21 Dec 2019 06:32:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 23E94F800BC
Received: from LLE2K16-MBX03.mitll.ad.local (LLE2K16-MBX03.mitll.ad.local) by
 llmx3.ll.mit.edu (unknown) with ESMTPS id xBL5WIK4022886 for
 <alsa-devel@alsa-project.org>; Sat, 21 Dec 2019 00:32:18 -0500
From: David Ward <david.ward@ll.mit.edu>
To: <alsa-devel@alsa-project.org>
Date: Sat, 21 Dec 2019 00:32:01 -0500
Message-ID: <1576906331-5212-2-git-send-email-david.ward@ll.mit.edu>
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
Subject: [alsa-devel] [PATCH alsa-utils 01/11] alsa-info.sh: Consolidate PCI
	device output
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

Include numeric IDs and subsystem info in the PCI device output,
without placing them in a separate section.

Signed-off-by: David Ward <david.ward@ll.mit.edu>
---
 alsa-info/alsa-info.sh | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/alsa-info/alsa-info.sh b/alsa-info/alsa-info.sh
index cf7ad89..8fc6997 100755
--- a/alsa-info/alsa-info.sh
+++ b/alsa-info/alsa-info.sh
@@ -455,7 +455,9 @@ fi
 cat /proc/asound/modules 2>/dev/null | awk '{ print $2 }' > $TEMPDIR/alsamodules.tmp
 cat /proc/asound/cards > $TEMPDIR/alsacards.tmp
 if [[ ! -z "$LSPCI" ]]; then
-  lspci | grep -i "multi\|audio">$TEMPDIR/lspci.tmp
+	for class in 0401 0402 0403; do
+		lspci -vvnn -d "::$class" | sed -n '/^[^\t]/,+1p'
+	done > $TEMPDIR/lspci.tmp
 fi
 
 #Check for HDA-Intel cards codec#*
@@ -585,12 +587,6 @@ echo "" >> $FILE
 cat $TEMPDIR/lspci.tmp >> $FILE
 echo "" >> $FILE
 echo "" >> $FILE
-echo "!!Advanced information - PCI Vendor/Device/Subsystem ID's" >> $FILE
-echo "!!-------------------------------------------------------" >> $FILE
-echo "" >> $FILE
-lspci -vvn |grep -A1 040[1-3] >> $FILE
-echo "" >> $FILE
-echo "" >> $FILE
 fi
 
 if [ "$SNDOPTIONS" ]
-- 
1.8.3.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
