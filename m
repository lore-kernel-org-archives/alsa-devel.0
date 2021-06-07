Return-Path: <SRS0=v4AK=LB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A79C47082
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Jun 2021 08:17:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CDA760FF1
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Jun 2021 08:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CDA760FF1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE5F3169C;
	Mon,  7 Jun 2021 10:16:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE5F3169C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623053834;
	bh=0XfFBwrQVJ8UfqvlHfCNZjdCLCp9bDs6bH8/ZL7vAYI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DpDhAo96HKRSpufKf/tmRf0EWb2r2X3G6dXmJjbodJRNFmf/Nz5vMOJOClL5l9CxD
	 febCRrdjRWwvsc0Dbt7dE4l7dH4afuYh5HZeV57a05yhPAdCQo294h6m31LZRgxx92
	 0BbZjz9Vq5MIi1YFCejhNR2GOivnfJ3yLrmLafSg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3C827F804F3;
	Mon,  7 Jun 2021 10:13:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A5FA9F804D0; Mon,  7 Jun 2021 10:13:21 +0200 (CEST)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C60EEF8032C
 for <alsa-devel@alsa-project.org>; Mon,  7 Jun 2021 10:13:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C60EEF8032C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="GkQYnCZC"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="Skhz1GD2"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 0F4F65C012E;
 Mon,  7 Jun 2021 04:13:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Mon, 07 Jun 2021 04:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=NPvg0gQFZoER1
 AozOO55g+iRxgN6A5dFR/Q0x/qN2/Q=; b=GkQYnCZCwhx8hFGxixacjQt008YPa
 d1z1HN63SWeAS+TxoMhTO6boGxzJuJ1JJA98TCjwOHzoU5pg+y2LPSxw3W10/Yv3
 qtcs9gfmJGgGruBmGJVhNxojXul2yzHxLH3eJSrP/bTkkl8xh7jZFf8ecSdVGJES
 udCdeQkdguuUHY9U7k9HlWnWLnnagjHmBqLKc6ph5TfJZy5Uv9umopym1oZIYBhR
 rld3iTRx+bdlNjtYyuEfJxS1dg8Ykua54JweyyumPymQW+2TIo8fiwhXM57PUk6Z
 5V9D772cKI3i9VvE4IKWQEcxsvMUKxFuZHC/M28uZJNSathvE9gMzKVGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=NPvg0gQFZoER1AozOO55g+iRxgN6A5dFR/Q0x/qN2/Q=; b=Skhz1GD2
 mbmUi1tv+M/8JV0ORQkC/mTLAe0qc49DpH8twgWPdJb0zj21lQNNr/tPCQIKfr/S
 VtydjUhsZlUJ2xpf5gf9gwvQxNqb6AaK4b4LLllWM61nmv3JDLn/qZhfLBF3TFwN
 iyfUD1CZ8XNyOpf2xNKY8zWY0kp6IuEmtxLhCtbPoUhdbJcOV4nYJ5SaMay5nhnh
 DD4y/oCK4GuzQZC0MB8sUhdvKqoCINk9erNIKkpy+s5gplFbKrY1SWNUh2u3wvbx
 ZMt/pkBtexlcvUOLUYoNxQVh9ELlkPSvUr8fiddGWVncQ/V4RSJpAY8KuAm/mN0Z
 KUVAc35QyLnzqg==
X-ME-Sender: <xms:FNW9YEXRHnmRUdQf0oe5ufIlEglFYZmsSBfXwq1hoccunYh5WnMseA>
 <xme:FNW9YIk0tUs4bdNcnJA87WQAjT14IHe5o5aIBAswJr0EArRyoUAmYRBHu45KEEx2q
 r6GVHAZi6nJDYH9PwA>
X-ME-Received: <xmr:FNW9YIbMBj2gIhT0h4yc9PGdqIbbCMJfMdjADDSRsh7rZQETwrcL19edyh329_wxe_91-kA-Ry7TCP55MFQNEyMvmnVaEXvwDYdTfWpY02-2xNFcULyC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedtjecutefuodetggdotefrodftvfcurf
 hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertdertd
 dtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhi
 sehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevfefffeektefgve
 egfeelheffhfeujedtjeevtefhkeevkedtjeejvddtjefhjeenucevlhhushhtvghrufhi
 iigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrg
 hmohgttghhihdrjhhp
X-ME-Proxy: <xmx:FNW9YDXlEBzUBDD41ZpV3hT_3UX3TuySQm1CHIuKkFQxLPCVtrUiTA>
 <xmx:FNW9YOn5PqDSr97wIFwLGvuRl4_8qxqUr_c5U1GKwqrYJtsAUI20QA>
 <xmx:FNW9YIdaCsGvjh_oBr7h9ezks0san0nhCSBqlMRqJRzQ-snhKntMFg>
 <xmx:FdW9YCuCiUPzcaQxORmP6dpaYFr9zUY8rA6OJA49H_QVDUEdX1_f5g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jun 2021 04:13:07 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH 9/9] ALSA: firewire-lib: delete unused kernel API
Date: Mon,  7 Jun 2021 17:12:50 +0900
Message-Id: <20210607081250.13397-10-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210607081250.13397-1-o-takashi@sakamocchi.jp>
References: <20210607081250.13397-1-o-takashi@sakamocchi.jp>
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

No driver use snd_fw_schedule_registration(). Let's delete it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/lib.c | 32 --------------------------------
 sound/firewire/lib.h |  3 ---
 2 files changed, 35 deletions(-)

diff --git a/sound/firewire/lib.c b/sound/firewire/lib.c
index 85c4f4477c7f..e0a2337e8f27 100644
--- a/sound/firewire/lib.c
+++ b/sound/firewire/lib.c
@@ -67,38 +67,6 @@ int snd_fw_transaction(struct fw_unit *unit, int tcode,
 }
 EXPORT_SYMBOL(snd_fw_transaction);
 
-#define PROBE_DELAY_MS		(2 * MSEC_PER_SEC)
-
-/**
- * snd_fw_schedule_registration - schedule work for sound card registration
- * @unit: an instance for unit on IEEE 1394 bus
- * @dwork: delayed work with callback function
- *
- * This function is not designed for general purposes. When new unit is
- * connected to IEEE 1394 bus, the bus is under bus-reset state because of
- * topological change. In this state, units tend to fail both of asynchronous
- * and isochronous communication. To avoid this problem, this function is used
- * to postpone sound card registration after the state. The callers must
- * set up instance of delayed work in advance.
- */
-void snd_fw_schedule_registration(struct fw_unit *unit,
-				  struct delayed_work *dwork)
-{
-	u64 now, delay;
-
-	now = get_jiffies_64();
-	delay = fw_parent_device(unit)->card->reset_jiffies
-					+ msecs_to_jiffies(PROBE_DELAY_MS);
-
-	if (time_after64(delay, now))
-		delay -= now;
-	else
-		delay = 0;
-
-	mod_delayed_work(system_wq, dwork, delay);
-}
-EXPORT_SYMBOL(snd_fw_schedule_registration);
-
 MODULE_DESCRIPTION("FireWire audio helper functions");
 MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_LICENSE("GPL v2");
diff --git a/sound/firewire/lib.h b/sound/firewire/lib.h
index dc815dc3933e..664dfdb9e58d 100644
--- a/sound/firewire/lib.h
+++ b/sound/firewire/lib.h
@@ -23,7 +23,4 @@ static inline bool rcode_is_permanent_error(int rcode)
 	return rcode == RCODE_TYPE_ERROR || rcode == RCODE_ADDRESS_ERROR;
 }
 
-void snd_fw_schedule_registration(struct fw_unit *unit,
-				  struct delayed_work *dwork);
-
 #endif
-- 
2.27.0

