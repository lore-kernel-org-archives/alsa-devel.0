Return-Path: <SRS0=ZLIO=2L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED12C43603
	for <alsa-devel@archiver.kernel.org>; Sat, 21 Dec 2019 05:39:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E432220665
	for <alsa-devel@archiver.kernel.org>; Sat, 21 Dec 2019 05:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WgMSrowF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E432220665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ll.mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3CAE01673;
	Sat, 21 Dec 2019 06:38:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3CAE01673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576906774;
	bh=2hxlwxfEg/yPx/NbWLOxP9GVZhCN0zGTWuJByAWA0bk=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WgMSrowFGk3dqnZhYAJ+BzZ9hMJ0PnspdXCDi4ASTKQk6S3PbtXVQjrEQ3gIu4uxO
	 SKCPozR0K6v8jFaFfgnPtmRvtrb7T6kbUYYyk1+0pHCaQOcsEtHfOQwYZJvIa0FNSh
	 YlUm6qxIVn9ALL1hHFZ3+4TfhwlvCoC5CYnuyLog=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5E3A8F802D2;
	Sat, 21 Dec 2019 06:32:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 427A4F80268; Sat, 21 Dec 2019 06:32:34 +0100 (CET)
Received: from llmx3.ll.mit.edu (llmx3.ll.mit.edu [129.55.12.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B0E8F80266
 for <alsa-devel@alsa-project.org>; Sat, 21 Dec 2019 06:32:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4B0E8F80266
Received: from LLE2K16-MBX03.mitll.ad.local (LLE2K16-MBX03.mitll.ad.local) by
 llmx3.ll.mit.edu (unknown) with ESMTPS id xBL5WSPQ023226 for
 <alsa-devel@alsa-project.org>; Sat, 21 Dec 2019 00:32:28 -0500
From: David Ward <david.ward@ll.mit.edu>
To: <alsa-devel@alsa-project.org>
Date: Sat, 21 Dec 2019 00:32:09 -0500
Message-ID: <1576906331-5212-10-git-send-email-david.ward@ll.mit.edu>
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
Subject: [alsa-devel] [PATCH alsa-utils 09/11] alsa-info.sh: Condense nested
	commands for formatting upload result
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
 alsa-info/alsa-info.sh | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/alsa-info/alsa-info.sh b/alsa-info/alsa-info.sh
index 7560b0d..8b4745b 100755
--- a/alsa-info/alsa-info.sh
+++ b/alsa-info/alsa-info.sh
@@ -858,19 +858,15 @@ echo ""
 
 fi # dialog
 
-# See if tput is available, and use it if it is.
-if [ -n "$TPUT" ]; then
-	if [[ -z $PASTEBIN ]]; then
-		FINAL_URL=$(tput setaf 1; grep "SUCCESS:" $TEMPDIR/wget.tmp | cut -d ' ' -f 2 ; tput sgr0)
-	else
-		FINAL_URL=$(tput setaf 1; grep "SUCCESS:" $TEMPDIR/wget.tmp | sed -n 's/.*\:\([0-9]\+\).*/http:\/\/pastebin.ca\/\1/p'; tput sgr0)
-	fi
+if [ -z "$PASTEBIN" ]; then
+	FINAL_URL=$(grep "SUCCESS:" $TEMPDIR/wget.tmp | cut -d ' ' -f 2)
 else
-	if [[ -z $PASTEBIN ]]; then
-		FINAL_URL=$(grep "SUCCESS:" $TEMPDIR/wget.tmp | cut -d ' ' -f 2)
-	else
-		FINAL_URL=$(grep "SUCCESS:" $TEMPDIR/wget.tmp | sed -n 's/.*\:\([0-9]\+\).*/http:\/\/pastebin.ca\/\1/p')
-	fi
+	FINAL_URL=$(grep "SUCCESS:" $TEMPDIR/wget.tmp | sed -n 's/.*\:\([0-9]\+\).*/http:\/\/pastebin.ca\/\1/p')
+fi
+
+# See if tput is available, and use it if it is.
+if [ -x "$TPUT" ]; then
+	FINAL_URL=$(tput setaf 1; printf '%s' "$FINAL_URL"; tput sgr0)
 fi
 
 # Output the URL of the uploaded file.	
-- 
1.8.3.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
