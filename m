Return-Path: <SRS0=XflM=2Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38545C2D0C2
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 17:58:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9FF9215A4
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 17:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rAvHvoFb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9FF9215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ll.mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EF8E6177D;
	Fri,  3 Jan 2020 18:58:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EF8E6177D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578074333;
	bh=Tofm1QdCqBjFm6DZA+O2IdyMi25o6cFe8pXsN54JYwU=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rAvHvoFboEXzJ4z28fUG8dKKXw1JAXNPZK9u5A+faXqQ7qVtCFkxnlr6XKX872BSU
	 HogWUSXm+0RcYRHcivIwcX7DkInFoC0xHRsmz4kvNxMw1bZ86jDDYTlS8E3LqJ1Srm
	 kASU8DN6+gg9VBfNg71iRq7aGF9pT15ENW2z5RQ8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 69404F80271;
	Fri,  3 Jan 2020 18:56:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1808EF8015C; Fri,  3 Jan 2020 18:56:21 +0100 (CET)
Received: from llmx2.ll.mit.edu (llmx2.ll.mit.edu [129.55.12.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3FC5AF8015C
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2020 18:56:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3FC5AF8015C
Received: from LLE2K16-MBX01.mitll.ad.local (LLE2K16-MBX01.mitll.ad.local) by
 llmx2.ll.mit.edu (unknown) with ESMTPS id 003HuFpC024900;
 Fri, 3 Jan 2020 12:56:15 -0500
From: David Ward <david.ward@ll.mit.edu>
To: Takashi Iwai <tiwai@suse.de>, <alsa-devel@alsa-project.org>
Date: Fri, 3 Jan 2020 12:55:49 -0500
Message-ID: <1578074158-30328-3-git-send-email-david.ward@ll.mit.edu>
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
Subject: [alsa-devel] [PATCH v2 alsa-utils 02/11] alsa-info.sh: Read from
	/proc/modules and sort the result
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

Sorting the list of loaded modules makes it much easier to compare
two alsa-info.txt files, even if they are both from the same system
(since the order actually changes after each reboot).

lsmod just formats the contents of /proc/modules. After this script
calls lsmod, it strips everything but module names from the output.
This same result can be obtained just as easily by reading directly
from /proc/modules; then there is no need to remove the header line
printed by lsmod before sorting the output.

Signed-off-by: David Ward <david.ward@ll.mit.edu>
---
 alsa-info/alsa-info.sh | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/alsa-info/alsa-info.sh b/alsa-info/alsa-info.sh
index 2dcfcbf..d6d0935 100755
--- a/alsa-info/alsa-info.sh
+++ b/alsa-info/alsa-info.sh
@@ -35,7 +35,7 @@ BGTITLE="ALSA-Info v $SCRIPT_VERSION"
 PASTEBINKEY="C9cRIO8m/9y8Cs0nVs0FraRx7U0pHsuc"
 
 WGET=$(which wget 2>/dev/null | sed 's|^[^/]*||' 2>/dev/null)
-REQUIRES="mktemp grep pgrep whereis ping awk date uname cat dmesg amixer alsactl"
+REQUIRES="mktemp grep pgrep whereis ping awk date uname cat sort dmesg amixer alsactl"
 
 #
 # Define some simple functions
@@ -131,11 +131,11 @@ withaplay() {
 	echo "" >> $FILE
 }
 
-withlsmod() {
+withmodules() {
 	echo "!!All Loaded Modules" >> $FILE
 	echo "!!------------------" >> $FILE
 	echo "" >> $FILE
-	lsmod | awk '{print $1}' >> $FILE
+	awk '{print $1}' < /proc/modules | sort >> $FILE
 	echo "" >> $FILE
 	echo "" >> $FILE
 }
@@ -254,7 +254,7 @@ withall() {
 	withaplay
 	withamixer
 	withalsactl
-	withlsmod
+	withmodules
 	withsysfs
 	withdmesg
 	WITHALL="no"
@@ -366,7 +366,6 @@ information about your ALSA installation and sound related hardware.
 
   dmesg
   lspci
-  lsmod
   aplay
   amixer
   alsactl
-- 
1.8.3.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
