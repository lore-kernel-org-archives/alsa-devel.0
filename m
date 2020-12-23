Return-Path: <SRS0=3cEE=F3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61311C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Dec 2020 02:20:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D79E523331
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Dec 2020 02:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D79E523331
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 473831794;
	Wed, 23 Dec 2020 03:19:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 473831794
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608690036;
	bh=EKJcK/wUfnWd6IN0z7Hud2iRWPZFoGnTfP+9M2qTpso=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eZE3Km9u7OruNOCqlANUgyPQy01NJxK6GgSjKCKzBVZ1m7jccvmNLIu2QwcpXWE4r
	 TWAh24/QEVUjh4IEWt33cz0cajMpMTk5pyEgE+58Xnbt4bYQM69KxjJxHMTF//vVuL
	 lWj3Rrt6Gj2ZCZgHBc/ecom9zApcivO1ZRFRpH+A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C09E8F8027D;
	Wed, 23 Dec 2020 03:19:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D1DBEF804BD; Wed, 23 Dec 2020 03:19:33 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 37D7DF80168
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2020 03:19:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 37D7DF80168
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="qRtAq6LW"
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEB6D2312E;
 Wed, 23 Dec 2020 02:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1608689965;
 bh=EKJcK/wUfnWd6IN0z7Hud2iRWPZFoGnTfP+9M2qTpso=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qRtAq6LWjGYeUr6HpjB/IoH6dfxLajC3KNAToIwaW33g+A7MHTM7ZAYQ6B36RZZ11
 6KV8iFkbGyy0F010ajswriQ+o2PhDC2mJvB3yOUmXhtXiSOXMgKo4FnEza5B4EIYhY
 IwyPass8+lhOzIPQIvcLp6cohSB7BY3vpTpcSpvD6tsgMEf0HL7sfGpwYpIA5p54hO
 DF4kRZNb5GdcXCQbqvM7RX+0bD/EjB0TmWyKVC8k2af+u7z0XdUwkqvqsUZlyKzh6q
 +V1l+ne70io2KYm5qyU1kxsZ3gZX01wnPtGiKKXS2E3qJHCnzy4zLCqGNDYgSnD2vE
 WdIZD8HYikYmw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 056/130] ALSA: usb-audio: Don't call
 usb_set_interface() at trigger callback
Date: Tue, 22 Dec 2020 21:16:59 -0500
Message-Id: <20201223021813.2791612-56-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201223021813.2791612-1-sashal@kernel.org>
References: <20201223021813.2791612-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
 alsa-devel@alsa-project.org, Dylan Robinson <dylan_robinson@motu.com>,
 Keith Milner <kamilner@superlative.org>
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

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 4974b7950929e4a28d4eaee48e4ad07f168ac132 ]

The PCM trigger callback is atomic, hence we must not call a function
like usb_set_interface() there.  Calling it from there would lead to a
kernel Oops.

Fix it by moving the usb_set_interface() call to set_sync_endpoint().

Also, apply the snd_usb_set_interface_quirk() for consistency, too.

Tested-by: Keith Milner <kamilner@superlative.org>
Tested-by: Dylan Robinson <dylan_robinson@motu.com>
Link: https://lore.kernel.org/r/20201123085347.19667-3-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/pcm.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 49ad4e7bb70b5..87389ab69b5ee 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -232,21 +232,6 @@ static int start_endpoints(struct snd_usb_substream *subs)
 	    !test_and_set_bit(SUBSTREAM_FLAG_SYNC_EP_STARTED, &subs->flags)) {
 		struct snd_usb_endpoint *ep = subs->sync_endpoint;
 
-		if (subs->data_endpoint->iface != subs->sync_endpoint->iface ||
-		    subs->data_endpoint->altsetting != subs->sync_endpoint->altsetting) {
-			err = usb_set_interface(subs->dev,
-						subs->sync_endpoint->iface,
-						subs->sync_endpoint->altsetting);
-			if (err < 0) {
-				clear_bit(SUBSTREAM_FLAG_SYNC_EP_STARTED, &subs->flags);
-				dev_err(&subs->dev->dev,
-					   "%d:%d: cannot set interface (%d)\n",
-					   subs->sync_endpoint->iface,
-					   subs->sync_endpoint->altsetting, err);
-				return -EIO;
-			}
-		}
-
 		dev_dbg(&subs->dev->dev, "Starting sync EP @%p\n", ep);
 
 		ep->sync_slave = subs->data_endpoint;
@@ -512,6 +497,19 @@ static int set_sync_endpoint(struct snd_usb_substream *subs,
 
 	subs->data_endpoint->sync_master = subs->sync_endpoint;
 
+	if (subs->data_endpoint->iface != subs->sync_endpoint->iface ||
+	    subs->data_endpoint->altsetting != subs->sync_endpoint->altsetting) {
+		err = usb_set_interface(subs->dev,
+					subs->sync_endpoint->iface,
+					subs->sync_endpoint->altsetting);
+		if (err < 0)
+			return err;
+		dev_dbg(&dev->dev, "setting usb interface %d:%d\n",
+			subs->sync_endpoint->iface,
+			subs->sync_endpoint->altsetting);
+		snd_usb_set_interface_quirk(dev);
+	}
+
 	return 0;
 }
 
-- 
2.27.0

