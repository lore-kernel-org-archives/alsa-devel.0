Return-Path: <SRS0=XflM=2Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E392C2D0C2
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 18:02:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0CC7215A4
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 18:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="k0e1dqGL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0CC7215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ll.mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E27EC179B;
	Fri,  3 Jan 2020 19:01:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E27EC179B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578074527;
	bh=1ZFW7I9YBd1KEjXHGhDpeqNvLJXr5rPJwMGJeyfhU38=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k0e1dqGLLlXhORRI5wAWFPCzjd+hzjSWK+M3QhTDa36oHOZZwKCgvhh6POmVE/Mtq
	 sgaRNAtpW7UGuuINDM5stNPdlNnIDub7i4APSVihSUTbN08d91ZpaNQ90QoS33eBRs
	 aLEvEbtWV3KsCB+YqC0z5gYi5E6zC2+pLDpzBgQc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C6354F8029A;
	Fri,  3 Jan 2020 18:56:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B924FF8028B; Fri,  3 Jan 2020 18:56:27 +0100 (CET)
Received: from llmx3.ll.mit.edu (llmx3.ll.mit.edu [129.55.12.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E10F4F8015C
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2020 18:56:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E10F4F8015C
Received: from LLE2K16-MBX01.mitll.ad.local (LLE2K16-MBX01.mitll.ad.local) by
 llmx3.ll.mit.edu (unknown) with ESMTPS id 003HuMXh011855;
 Fri, 3 Jan 2020 12:56:22 -0500
From: David Ward <david.ward@ll.mit.edu>
To: Takashi Iwai <tiwai@suse.de>, <alsa-devel@alsa-project.org>
Date: Fri, 3 Jan 2020 12:55:54 -0500
Message-ID: <1578074158-30328-8-git-send-email-david.ward@ll.mit.edu>
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
Subject: [alsa-devel] [PATCH v2 alsa-utils 07/11] alsa-info.sh: Remove
	progress spinner during upload without dialog
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

The spinner did not actually provide information about the status
of the file upload, and caused other problems: it would repeatedly
spawn new pgrep processes (without a delay between them), and it
blocked the script if any wget process was running on the system.

Signed-off-by: David Ward <david.ward@ll.mit.edu>
---
 alsa-info/alsa-info.sh | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/alsa-info/alsa-info.sh b/alsa-info/alsa-info.sh
index 7204c8e..f958599 100755
--- a/alsa-info/alsa-info.sh
+++ b/alsa-info/alsa-info.sh
@@ -849,22 +849,12 @@ else
 
 if [[ -z $PASTEBIN ]]; then
 	echo -n "Uploading information to www.alsa-project.org ... " 
-	wget -O - --tries=5 --timeout=60 --post-file=$FILE http://www.alsa-project.org/cardinfo-db/ &>$TEMPDIR/wget.tmp &
+	wget -O - --tries=5 --timeout=60 --post-file=$FILE "http://www.alsa-project.org/cardinfo-db/" &>$TEMPDIR/wget.tmp
 else
 	echo -n "Uploading information to www.pastebin.ca ... " 
-	wget -O - --tries=5 --timeout=60 --post-file=$FILE http://pastebin.ca/quiet-paste.php?api=$PASTEBINKEY &>$TEMPDIR/wget.tmp &
+	wget -O - --tries=5 --timeout=60 --post-file=$FILE "http://pastebin.ca/quiet-paste.php?api=$PASTEBINKEY" &>$TEMPDIR/wget.tmp
 fi
 
-#Progess spinner for wget transfer.
-i=1
-sp="/-\|"
-echo -n ' '
-while pgrep wget &>/dev/null
-do
-	echo -en "\b${sp:i++%${#sp}:1}"
-done
-
-echo -e "\b Done!"
 echo ""
 
 fi # dialog
-- 
1.8.3.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
