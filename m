Return-Path: <SRS0=jeAA=KJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11F9C433ED
	for <alsa-devel@archiver.kernel.org>; Fri, 14 May 2021 08:56:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D606613AA
	for <alsa-devel@archiver.kernel.org>; Fri, 14 May 2021 08:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D606613AA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EA914174F;
	Fri, 14 May 2021 10:55:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EA914174F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620982598;
	bh=BFfnE0qZAzSktyzJ4xeRZD3xNMxfarYBS7SK1MERo7M=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oLY3mcYop4Z024lCcB5ZtCuknU+SbiPPMVF5RsStUoQjbIs7u8BKHTPBJjcUYE+XI
	 scaWB/NzyVU/myVU57PZdc7CCDDnsjKBcK4lY2DzytR+PXoY92UgHh0N94bX3hilRD
	 RQLe3q7Uary01tfnUkqMrcjwqWoTalBuTHeeLjaA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7CA60F802CA;
	Fri, 14 May 2021 10:54:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 68C83F8042F; Fri, 14 May 2021 10:54:53 +0200 (CEST)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 70E48F80240
 for <alsa-devel@alsa-project.org>; Fri, 14 May 2021 10:54:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 70E48F80240
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="OoBXYh74"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="CD+Hbmm8"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id A24A25C0176;
 Fri, 14 May 2021 04:54:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Fri, 14 May 2021 04:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=3gXlu3chREjvW
 +3PqzAWlI6OoLAGk9ilFjAWOEBpFz0=; b=OoBXYh74+WXdRI9AmUkCDZ7VamLXv
 DrvQPFkVXQoFXixW2yZpJA6d5dBIVM7WyjKjk6mqUPaPbYhyea11YkYiNSAVGTS1
 6AssdRgHzISIXxjqshUZJ3QMW/1ZZplr3wfl+rC+T2L8zyh8EG+Or04XjlL92umM
 7aGZTlYl8Y1hR8BN2XHuo4ozqqOdBZTsALWD9OV1NCYIwGZfMPo/xbiHK5Clat32
 BDBNqB7a26axiSPNJUXS36HvScWIbebHKD+3EXTZ3cBLJVr8PucJXwbVW0bv2eO9
 ho+jHUYy1f8hm6/fG5G3bevDqiQaQN6pv5EHOevwqhAh8FXBXHA0ow0WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=3gXlu3chREjvW+3PqzAWlI6OoLAGk9ilFjAWOEBpFz0=; b=CD+Hbmm8
 W3Z5oDW2y7iAq0dBX3Ay+21GDmnFSalXWuyL9xTPED+WFOzGznVyoyoj1DXQ2U45
 eR0ZLLN53WxiZygWLZtaEXx5ZIgQdJGCeKTzVpw5f9q5D7LkIKl9rg1g+YSLv4bW
 Ge4tGCIE1VXWc8u1Ss9I6nLAaEtQQdii8DLmdXwN/lx0S/+hQ5QEG+s1Z5mAwiMy
 nWcY1o0h/LVq9LJoBtk+hSlNs4h+PiBzCUCs25F3VGvOzJE5H3SdhbEPaeHhEZUM
 GfrGrX0zv1rMgBtJ4Yagv/yN6PIPYft2BpUaK3CcTgoNXMeVgGOZKW0KJMlye/YK
 lhh5a85B1qhUkg==
X-ME-Sender: <xms:1jqeYOpGWxtDk_7BMHd1LA1Y-IW0bskR_SXvlHAGs0kN9erbB2W-aA>
 <xme:1jqeYMqJQTuf85Z458CLBhvHlVvGXTTeKGcjs2RTG7dYbRT9KQu905pt3d38ncO3k
 HZtfFeLhvL2CW_y9-s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdehhedgudefjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
 ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
 rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevfefffe
 ektefgveegfeelheffhfeujedtjeevtefhkeevkedtjeejvddtjefhjeenucfkphepudeg
 rdefrdeihedrudejheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:1jqeYDN_S0ZMct3OiRx8m2CRvTQ2WXcQjKAI1z99IxXqB2JUTABSwA>
 <xmx:1jqeYN5mVITBNM_cdbQJ7vGYhEW8_aLcPHzaP8OesJ48Rp7hDOIkQw>
 <xmx:1jqeYN4ER8GsPj6YkLrdgmqtGWgPONmFwhi1Hq3syTL7y-DooOW5og>
 <xmx:1jqeYKgvaCsbIIAAF8w5I7PpMkXkXOtjVqjIGbOK8eFGZEnsQBR36g>
Received: from workstation.flets-east.jp (ae065175.dynamic.ppp.asahi-net.or.jp
 [14.3.65.175]) by mail.messagingengine.com (Postfix) with ESMTPA;
 Fri, 14 May 2021 04:54:45 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH 4/7] ALSA: oxfw: add comment for the type of ASICs
Date: Fri, 14 May 2021 17:54:32 +0900
Message-Id: <20210514085435.92807-5-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210514085435.92807-1-o-takashi@sakamocchi.jp>
References: <20210514085435.92807-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
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

ALSA OXFW supports two types of ASICS; OXFW970 and OXFW971. The former
is known to have a quirk we call 'jumbo payload' that some isochronous
cycles are skipped to transfer isochronous packets during handling
asynchronous transaction. The quirk seems to correspond to firmware
initially delivered by Oxford Semiconductor since the quirk is not
confirmed for Mackie Onyx Satellite in which the revised firmware is
available. The quirk is not confirmed in the latter.

This commit adds code comment to describe the quirk.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index b1596b1fecfd..958f5100b794 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -332,14 +332,30 @@ static const struct compat_info lacie_speakers = {
 }
 
 static const struct ieee1394_device_id oxfw_id_table[] = {
+	//
+	// OXFW970 devices:
+	// Initial firmware has a quirk to postpone isoc packet transmission during finishing async
+	// transaction. As a result, several isochronous cycles are skipped to transfer the packets
+	// and the audio data frames which should have been transferred during the cycles are put
+	// into packet at the first isoc cycle after the postpone. Furthermore, the value of SYT
+	// field in CIP header is not reliable as synchronization timing,
+	//
 	OXFW_DEV_ENTRY(VENDOR_GRIFFIN, 0x00f970, &griffin_firewave),
 	OXFW_DEV_ENTRY(VENDOR_LACIE, 0x00f970, &lacie_speakers),
-	// Behringer,F-Control Audio 202.
+	// Behringer,F-Control Audio 202. The value of SYT field is not reliable at all.
 	OXFW_DEV_ENTRY(VENDOR_BEHRINGER, 0x00fc22, NULL),
-	// Loud Technologies, Tapco Link.FireWire 4x6.
+	// Loud Technologies, Tapco Link.FireWire 4x6. The value of SYT field is always 0xffff.
 	OXFW_DEV_ENTRY(VENDOR_LOUD, 0x000460, NULL),
-	// Loud Technologies, Mackie Onyx Satellite.
+	// Loud Technologies, Mackie Onyx Satellite. Although revised version of firmware is
+	// installed to avoid the postpone, the value of SYT field is always 0xffff.
 	OXFW_DEV_ENTRY(VENDOR_LOUD, MODEL_SATELLITE, NULL),
+	// Miglia HarmonyAudio. Not yet identified.
+
+	//
+	// OXFW971 devices:
+	// The value of SYT field in CIP header is enough reliable. Both of blocking and non-blocking
+	// transmission methods are available.
+	//
 	// Any Mackie(Loud) models (name string/model id):
 	//  Onyx-i series (former models):	0x081216
 	//  d.4 pro:				Unknown
-- 
2.27.0

