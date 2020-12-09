Return-Path: <SRS0=RrJr=FN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8BDC4361B
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Dec 2020 17:40:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D88620684
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Dec 2020 17:40:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D88620684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 31EAC16AB;
	Wed,  9 Dec 2020 18:39:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 31EAC16AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607535601;
	bh=+b2w2WRJyKmInBjpXAUca4j0kSZy1FdPUhhb/13r6b4=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qsOoIppHM8go2jcMKcXxIjaczWcc4CN2KmgfXApSpr5747+PsKS5o2OwOBSDCU8q9
	 rQMPDndJMOVYS1Yw/03uelg08fodFkvy1zsjpGZj+sWIPK/IBfO9EEl7fzA+SEDZHh
	 Pq7g4Ijta3DUnhzSNZ6TnvQrGhKjVFr5w6FkX2Ko=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 99BB7F8012C;
	Wed,  9 Dec 2020 18:39:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9ECC5F8020D; Wed,  9 Dec 2020 18:39:08 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7B941F8012C
 for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2020 18:39:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7B941F8012C
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 50143AD11
 for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2020 17:39:01 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH alsa-utils] alsa-info: Add lsusb and stream outputs
Date: Wed,  9 Dec 2020 18:39:00 +0100
Message-Id: <20201209173900.23836-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

We need more detailed information for USB-audio devices, at least the
lsusb -v output and the contents of stream* proc files.
Let's add them to alsa-info.sh output.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 alsa-info/alsa-info.sh | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/alsa-info/alsa-info.sh b/alsa-info/alsa-info.sh
index f179bfab8655..3871b97a2268 100755
--- a/alsa-info/alsa-info.sh
+++ b/alsa-info/alsa-info.sh
@@ -476,6 +476,18 @@ cat /proc/asound/card*/codec\#* > $TEMPDIR/alsa-hda-intel.tmp 2> /dev/null
 cat /proc/asound/card*/codec97\#0/ac97\#0-0 > $TEMPDIR/alsa-ac97.tmp 2> /dev/null
 cat /proc/asound/card*/codec97\#0/ac97\#0-0+regs > $TEMPDIR/alsa-ac97-regs.tmp 2> /dev/null
 
+#Check for USB descriptors
+if [ -x /usr/bin/lsusb ]; then
+    for f in /proc/asound/card[0-9]*/usbbus; do
+	test -f "$f" || continue
+	id=$(sed 's@/@:@' $f)
+	lsusb -v -s $id >> $TEMPDIR/lsusb.tmp 2> /dev/null
+    done
+fi
+
+#Check for USB stream setup
+cat /proc/asound/card*/stream[0-9]* > $TEMPDIR/alsa-usbstream.tmp 2> /dev/null
+
 #Check for USB mixer setup
 cat /proc/asound/card*/usbmixer > $TEMPDIR/alsa-usbmixer.tmp 2> /dev/null
 
@@ -649,6 +661,27 @@ if [ -s "$TEMPDIR/alsa-ac97.tmp" ]; then
 	echo "" >> $FILE
 fi
 
+if [ -s "$TEMPDIR/lsusb.tmp" ]; then
+        echo "!!USB Descriptors" >> $FILE
+        echo "!!---------------" >> $FILE
+        echo "--startcollapse--" >> $FILE
+        cat $TEMPDIR/lsusb.tmp >> $FILE
+        echo "--endcollapse--" >> $FILE
+	echo "" >> $FILE
+	echo "" >> $FILE
+fi
+
+if [ -s "$TEMPDIR/lsusb.tmp" ]; then
+        echo "!!USB Stream information" >> $FILE
+        echo "!!----------------------" >> $FILE
+        echo "--startcollapse--" >> $FILE
+        echo "" >> $FILE
+        cat $TEMPDIR/alsa-usbstream.tmp >> $FILE
+        echo "--endcollapse--" >> $FILE
+	echo "" >> $FILE
+	echo "" >> $FILE
+fi
+
 if [ -s "$TEMPDIR/alsa-usbmixer.tmp" ]; then
         echo "!!USB Mixer information" >> $FILE
         echo "!!---------------------" >> $FILE
-- 
2.26.2

