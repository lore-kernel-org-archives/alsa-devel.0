Return-Path: <SRS0=LtCP=G4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B985DC433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Jan 2021 14:03:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7156922C9E
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Jan 2021 14:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7156922C9E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 809B7181D;
	Mon, 25 Jan 2021 15:02:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 809B7181D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611583400;
	bh=suUJxUXloT8y6TxoQvo7MX1qEjT2gA+tvK4SfMIJGVM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TYf6o01XQVfGB/byUPnC6Y3VEwvr9CwwUAmEoAUwjN8Gq9PtnpKybomR5qh1se3Cv
	 0pJr+xYG+V2eO0k6y6GB0HwcaLVXcMk9ojRpvM2a+FkUj/Fzwz67l9NDD91+xwlYis
	 AsQXQYqnQ+SkgGkcVgTuy3OdCzHXfm2D+/cR7lFo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AA7AEF80218;
	Mon, 25 Jan 2021 15:02:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 29B89F80259; Mon, 25 Jan 2021 15:02:27 +0100 (CET)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 96578F8012D
 for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2021 15:02:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 96578F8012D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="Km/ih3cA"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="fCFKzfON"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 9E0CE3BE;
 Mon, 25 Jan 2021 09:02:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Mon, 25 Jan 2021 09:02:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm3; bh=qcNVNqsBJ/AH74ls90eo94RTZu
 Zm7/px/y3mLSKrpz8=; b=Km/ih3cAlMS8lQLEroldPUgmcZbCnzQyKqSCOwn8hd
 nhcmT4AjEQAt6Q/6l+dtm6PSJa49GB86tqq/CHP/uH8afpmwakBmzmJT7A8RyR7L
 0rsKHzTSi+itI+ba8HMawl0I55ZNC1d3xXDFyDEPbzpgby6qxjE+T7UkB1dxVn5q
 Z/6IiNOVsUN+xtpSsHMgnOStaPFKjaVRz1IMg0z29KiEt3sVr74rSu4mUCuDTx6E
 FieCbmHuazMeS9JVbGB7aiCbPUX47aqZhmmpXGzvXYpdzkrD9v2M4gSPc22G9onb
 GfVo3offdgBKQIVgfPcUIBItkbYIa3TFw73+nPGTRNCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=qcNVNqsBJ/AH74ls9
 0eo94RTZuZm7/px/y3mLSKrpz8=; b=fCFKzfONIjJQKz8sOriYjQIy9lsjlRc/R
 nc1/M0W+L2vRD0BZiSyteaG1YnZXdcHabUEVrp55almmz5OvGajJsEmgujGDPWR6
 Us0jpU8bIhrKhXDzQVnk/ZBSaep1ClUGANIXWJaXPGYPsAcw8gBgEKyhcEftiUx5
 48lA4MqJ1144Qu8D8OyLfOyDFQ4x/URmarfXbRSSelGj1/wh8TDHRBy1zqpkEVj3
 EYuDS4Zov6Rdu9E8t/U93HRZIvoqd6u0PGwLfOGtAsQDX+fGLCTONLs/xv1Us7Tz
 WrA+auAdifBViGqoGBcM3w/4W3fB8C3BUEgbaepkdDEKv5KLVk9sg==
X-ME-Sender: <xms:Y88OYH3dFa4xxyPVEsECfRBUezjFa0X-W004VxJMxtNPE2jmasa3IQ>
 <xme:Y88OYGG4f6Ee2lD-xPLWp9v00jTZMGJHB_HdEwFWvXkfWJvp5M3oEwzkU-bbNKJjM
 8S4vwNDBb0Y9pBWgDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdefgdehjecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepvfgrkhgrshhhihcu
 ufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjpheqne
 cuggftrfgrthhtvghrnhepudejteelhfdttdekgfdtueeilefhgfetjeejheekgeevuddv
 veegieehueeukeejnecukfhppeduudekrddvgeefrdejkedrheeknecuvehluhhsthgvrh
 fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgr
 khgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:Y88OYH7_1JHqHDYUMzztmZJuvbDHJqQZF_smPV5-wZdCt9IX5fblUA>
 <xmx:Y88OYM1oR4YXSb6GfKaC7AQucYbOoTilN-w7Ng7ueMm920KwgZKwew>
 <xmx:Y88OYKGRz_ME480EN3JTW5FVnYnh4k7YvgasJZ5J1iE43wkmd9bOZQ>
 <xmx:ZM8OYPTRRCE-DskJ2lpwTrHS3mHE5EyNNn94c_YnCAxEs2lJh2PNVA>
Received: from workstation.flets-east.jp (y078058.dynamic.ppp.asahi-net.or.jp
 [118.243.78.58])
 by mail.messagingengine.com (Postfix) with ESMTPA id 1C875108005B;
 Mon, 25 Jan 2021 09:02:09 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de,
	perex@perex.cz
Subject: [PATCH] ALSA: bebob: remove an unnecessary condition in hwdep_read()
Date: Mon, 25 Jan 2021 23:02:08 +0900
Message-Id: <20210125140208.26318-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Dan Carpenter <dan.carpenter@oracle.com>
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

Drivers in ALSA firewire stack supports eventing to userspace
applications via ALSA hwdep interface. All of the drivers supports stream
lock events. Some of them supports their unique events according to
specification of target device.

ALSA bebob driver supports the stream lock event only. In the case, it's
enough to check condition only in loop with process blocking. However,
current implementation check it again after breaking the loop.

This commit removes the redundant check.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob_hwdep.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/firewire/bebob/bebob_hwdep.c b/sound/firewire/bebob/bebob_hwdep.c
index 8677e3ec8d14..6f9331655d43 100644
--- a/sound/firewire/bebob/bebob_hwdep.c
+++ b/sound/firewire/bebob/bebob_hwdep.c
@@ -37,11 +37,9 @@ hwdep_read(struct snd_hwdep *hwdep, char __user *buf,  long count,
 
 	memset(&event, 0, sizeof(event));
 	count = min_t(long, count, sizeof(event.lock_status));
-	if (bebob->dev_lock_changed) {
-		event.lock_status.type = SNDRV_FIREWIRE_EVENT_LOCK_STATUS;
-		event.lock_status.status = (bebob->dev_lock_count > 0);
-		bebob->dev_lock_changed = false;
-	}
+	event.lock_status.type = SNDRV_FIREWIRE_EVENT_LOCK_STATUS;
+	event.lock_status.status = (bebob->dev_lock_count > 0);
+	bebob->dev_lock_changed = false;
 
 	spin_unlock_irq(&bebob->lock);
 
-- 
2.27.0

