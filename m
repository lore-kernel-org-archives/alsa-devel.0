Return-Path: <SRS0=ZLIO=2L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F74C43603
	for <alsa-devel@archiver.kernel.org>; Sat, 21 Dec 2019 05:35:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8436E21655
	for <alsa-devel@archiver.kernel.org>; Sat, 21 Dec 2019 05:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="X2oWBHwm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8436E21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ll.mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C27D01669;
	Sat, 21 Dec 2019 06:34:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C27D01669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576906499;
	bh=FCbVFqF12Pp6BEXNfeIPnlvyd2j0FQHhi5Kfz/EFWk4=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X2oWBHwmjgseEmGkwm/bUh4MD/xGoXF/he6uWjYzp9rsT30Gbf4kerIohMN3z99UG
	 OmqdlVdm23NNcaBMBue3NLU2zQMyqjkoCKBC35PAdQZihdhxN/GysSfvYWU1eUHoZq
	 Hly98W86MTdb0qU0IYjsLakliaaxvK0+OCe8pd08=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 46329F80266;
	Sat, 21 Dec 2019 06:32:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 53EE3F80253; Sat, 21 Dec 2019 06:32:25 +0100 (CET)
Received: from llmx2.ll.mit.edu (llmx2.ll.mit.edu [129.55.12.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4619DF80218
 for <alsa-devel@alsa-project.org>; Sat, 21 Dec 2019 06:32:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4619DF80218
Received: from LLE2K16-MBX03.mitll.ad.local (LLE2K16-MBX03.mitll.ad.local) by
 llmx2.ll.mit.edu (unknown) with ESMTPS id xBL5WJS0023803 for
 <alsa-devel@alsa-project.org>; Sat, 21 Dec 2019 00:32:19 -0500
From: David Ward <david.ward@ll.mit.edu>
To: <alsa-devel@alsa-project.org>
Date: Sat, 21 Dec 2019 00:32:02 -0500
Message-ID: <1576906331-5212-3-git-send-email-david.ward@ll.mit.edu>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576906331-5212-1-git-send-email-david.ward@ll.mit.edu>
References: <1576906331-5212-1-git-send-email-david.ward@ll.mit.edu>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-12-20_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=931
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912210045
Cc: David Ward <david.ward@ll.mit.edu>
Subject: [alsa-devel] [PATCH alsa-utils 02/11] alsa-info.sh: Read from
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
index 8fc6997..ed1d9e2 100755
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
