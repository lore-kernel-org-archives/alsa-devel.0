Return-Path: <SRS0=ZLIO=2L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C925C43603
	for <alsa-devel@archiver.kernel.org>; Sat, 21 Dec 2019 05:35:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8261621655
	for <alsa-devel@archiver.kernel.org>; Sat, 21 Dec 2019 05:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fVQMSqGF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8261621655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ll.mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D099D165D;
	Sat, 21 Dec 2019 06:34:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D099D165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576906543;
	bh=QWP4PbepaMgW6cSosEYrQix0vVgELIk4+JYM9pE88z8=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fVQMSqGFnCnx3Dco5tQK3efdmnGpQCTLvFekFU7ccHIjLgg2kXvrGVQ4vxsQ+agi/
	 DzCVr9nVig2ypdHrM/4aKetfp2MNYPlaogli7z2rT/KIozp0YR2YcGD1sqiGwSa4Pe
	 3f7fpI+/8326XjvLYHnq2GDiQgumkmh5V9qxZmmo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 295C1F80273;
	Sat, 21 Dec 2019 06:32:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 91D99F80266; Sat, 21 Dec 2019 06:32:27 +0100 (CET)
Received: from llmx2.ll.mit.edu (llmx2.ll.mit.edu [129.55.12.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 021F2F80234
 for <alsa-devel@alsa-project.org>; Sat, 21 Dec 2019 06:32:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 021F2F80234
Received: from LLE2K16-MBX03.mitll.ad.local (LLE2K16-MBX03.mitll.ad.local) by
 llmx2.ll.mit.edu (unknown) with ESMTPS id xBL5WMxF023811 for
 <alsa-devel@alsa-project.org>; Sat, 21 Dec 2019 00:32:22 -0500
From: David Ward <david.ward@ll.mit.edu>
To: <alsa-devel@alsa-project.org>
Date: Sat, 21 Dec 2019 00:32:04 -0500
Message-ID: <1576906331-5212-5-git-send-email-david.ward@ll.mit.edu>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576906331-5212-1-git-send-email-david.ward@ll.mit.edu>
References: <1576906331-5212-1-git-send-email-david.ward@ll.mit.edu>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-12-20_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=866
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912210045
Cc: David Ward <david.ward@ll.mit.edu>
Subject: [alsa-devel] [PATCH alsa-utils 04/11] alsa-info.sh: Use existing
	function to print ALSA configuration files
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

Signed-off-by: David Ward <david.ward@ll.mit.edu>
---
 alsa-info/alsa-info.sh | 27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/alsa-info/alsa-info.sh b/alsa-info/alsa-info.sh
index e1067d4..bf353de 100755
--- a/alsa-info/alsa-info.sh
+++ b/alsa-info/alsa-info.sh
@@ -710,33 +710,8 @@ if [ -n "$1" ]; then
 			WITHALL="no"
 			;;
 		--with-configs)
+			withconfigs
 			WITHALL="no"
-			if [[ -e $HOME/.asoundrc ]] || [[ -e /etc/asound.conf ]]
-			then
-				echo "!!ALSA configuration files" >> $FILE
-				echo "!!------------------------" >> $FILE
-				echo "" >> $FILE
-
-				#Check for ~/.asoundrc
-				if [[ -e $HOME/.asoundrc ]]
-				then
-					echo "!!User specific config file ($HOME/.asoundrc)" >> $FILE
-					echo "" >> $FILE
-					cat $HOME/.asoundrc >> $FILE
-					echo "" >> $FILE
-					echo "" >> $FILE
-				fi
-
-				#Check for /etc/asound.conf
-				if [[ -e /etc/asound.conf ]]
-				then
-					echo "!!System wide config file (/etc/asound.conf)" >> $FILE
-					echo "" >> $FILE
-					cat /etc/asound.conf >> $FILE
-					echo "" >> $FILE
-					echo "" >> $FILE
-				fi
-			fi
 			;;
 		--stdout)
 			UPLOAD="no"
-- 
1.8.3.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
