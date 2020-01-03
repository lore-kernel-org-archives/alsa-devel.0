Return-Path: <SRS0=XflM=2Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA10C2D0CE
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 18:00:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CB3E22522
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 18:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OZhlz1ig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB3E22522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ll.mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B7ECB1784;
	Fri,  3 Jan 2020 18:59:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B7ECB1784
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578074402;
	bh=Z6+uXN+p63Bi5bhFzHZo92FaPcnvVj6pv+4GCrqOrm8=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OZhlz1igqHSDTEoYH0AyjnHZKbskWhTP3H3G5f68EBS3vEDGmczhHz4tpgj31gHvq
	 0oimxlEFZGjK+p9DOxiVVy0Cc7yUluwT4EmQsYXNrDK/Xv6dBJVehq3nJ82iHmbo25
	 R1GGKHGHt4Bu3gX69tDus9bOnmEnV2yvrBS646U0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4E357F8028B;
	Fri,  3 Jan 2020 18:56:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 37D57F80271; Fri,  3 Jan 2020 18:56:24 +0100 (CET)
Received: from llmx2.ll.mit.edu (llmx2.ll.mit.edu [129.55.12.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 963F6F8015E
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2020 18:56:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 963F6F8015E
Received: from LLE2K16-MBX01.mitll.ad.local (LLE2K16-MBX01.mitll.ad.local) by
 llmx2.ll.mit.edu (unknown) with ESMTPS id 003HuHob024908;
 Fri, 3 Jan 2020 12:56:17 -0500
From: David Ward <david.ward@ll.mit.edu>
To: Takashi Iwai <tiwai@suse.de>, <alsa-devel@alsa-project.org>
Date: Fri, 3 Jan 2020 12:55:51 -0500
Message-ID: <1578074158-30328-5-git-send-email-david.ward@ll.mit.edu>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578074158-30328-1-git-send-email-david.ward@ll.mit.edu>
References: <1578074158-30328-1-git-send-email-david.ward@ll.mit.edu>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2020-01-03_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=982
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001030164
Cc: David Ward <david.ward@ll.mit.edu>
Subject: [alsa-devel] [PATCH v2 alsa-utils 04/11] alsa-info.sh: Use existing
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
index ff3cf95..a1c1449 100755
--- a/alsa-info/alsa-info.sh
+++ b/alsa-info/alsa-info.sh
@@ -708,33 +708,8 @@ if [ -n "$1" ]; then
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
