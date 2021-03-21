Return-Path: <SRS0=B97g=IT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (unknown [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4658C433DB
	for <alsa-devel@archiver.kernel.org>; Sun, 21 Mar 2021 03:31:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DD066195F
	for <alsa-devel@archiver.kernel.org>; Sun, 21 Mar 2021 03:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD066195F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B6EC166C;
	Sun, 21 Mar 2021 04:30:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B6EC166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616297464;
	bh=WElzBxNbI/8LU4TkUxks8/wD1EVg0/93SLYCX+she1o=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZQBhKbjWVYBtq9G6FErlwezZ1H2Jue8hXy2LleFsynZjY9OO2/4by5fMx1gOK5Ucs
	 O56VGYDPECfk4DMHoA3xVlle8l85LY2vYrMo9DGzplBO7D4v2p2nqhOMwsmi18FB6X
	 EuGuzY0rNT/FWJ4ZecQGeu/C7r38wZUix6dF5WC4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EB3D6F8026D;
	Sun, 21 Mar 2021 04:29:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9E2FCF80254; Sun, 21 Mar 2021 04:29:03 +0100 (CET)
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4899BF8012F
 for <alsa-devel@alsa-project.org>; Sun, 21 Mar 2021 04:28:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4899BF8012F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="UdqIIrqr"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="C0gQL57B"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id EA1691844;
 Sat, 20 Mar 2021 23:28:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Sat, 20 Mar 2021 23:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=opk5iVXDnSiFd
 tePBipGpfN085CAYMu8qBwrorUIKsE=; b=UdqIIrqrrga4LQAXGgbR+ZVukrbO8
 wZ1uB1U87HJtBZxvl7Ovqt54Oi2Gy4euvQxPFUG0YO1Fq7Ff4W5jrqIS8cn4UDZM
 oRkRw2m63s5chKa5Npexz/y5+e2tWMoYZ8LLWn6L+450yoHXtJOxuQA66DM+kYuI
 crTdUnjB+Ini+ypFyFxWnlxDKhkO3jWzWYFqU3sMAoDOoUcvpUWnGFRYbktd8Bp7
 quBq+OqqWHUzZH48b0a9cfJJyjq04NMXKgREXfYhvZiz+4T9IwasZ2F4hXP9273W
 u2f/lVY1gbZS86NH0zzRimCp/NZQv2sG54CS2UTHApDOXrRX0+Wy9yfHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=opk5iVXDnSiFdtePBipGpfN085CAYMu8qBwrorUIKsE=; b=C0gQL57B
 cJ7dPVQkel43K7mC1Kt5DIHvitTGd5jFu44PywkGlHT9daQAwRuBUhxzCyuR/1iq
 4lLnU2ner6UEfFNV6GtvfRPHz9dWIs/HPD9nwGvYk86cYQAET+YZfE+4fnuqqjtL
 02BcP0OIFeOqGIxapHEAsfF9sr7Bu0DAHKy4W//N1lXb600oTFUD1cZST3C2a3pq
 7ukvFHnr9fxOegLuAwhmOakAS2LNcu84tMQ1URmC8BTeHy+TrrylpKfRv6QsCUPX
 joGnxCHgZSAvlyG/T3GrEPVOWAkyVebWyKhcF/DcYQ+RMYcwje+tP70xqFUzekri
 5cqnXJ3aEOI1cA==
X-ME-Sender: <xms:ZL1WYB07zS17V0AfKfuP13JMD_2ZVF-RBSEe-zn5MKpCX6HO7mfyLA>
 <xme:ZL1WYIFVMNDgo4TSLRo0YLegVBQrhp6qMBU-_QuJhAWFFpgxjjUAq0B-sRCBR9QLB
 B8uH4ys_6FkVErAKGU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeguddgieduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
 shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveefffefke
 etgfevgeefleehfffhueejtdejveethfekveektdejjedvtdejhfejnecukfhppedugedr
 fedrieehrddujeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:ZL1WYB6msrmeW1I3GpozU6Ukyn9guLjmRqCpALih2FIEQb4foFXmbw>
 <xmx:ZL1WYO0a2_6IWCmehFc__CQcjPyK8S31rhEq0tv51iymAGpdLXw-Mw>
 <xmx:ZL1WYEEpO_JGomNOOnV_N_OdSjz5mZxIE8pPggGbZhA7IKLeN-5GIA>
 <xmx:ZL1WYPMo17Hq_yWuYKCekafHZqaZLL06ebHLBENRNKokg-nNC4uOTA>
Received: from workstation.flets-east.jp (ae065175.dynamic.ppp.asahi-net.or.jp
 [14.3.65.175])
 by mail.messagingengine.com (Postfix) with ESMTPA id 995F42403E0;
 Sat, 20 Mar 2021 23:28:35 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH 1/3] ALSA: bebob: code refactoring for stream format detection
Date: Sun, 21 Mar 2021 12:28:29 +0900
Message-Id: <20210321032831.340278-2-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210321032831.340278-1-o-takashi@sakamocchi.jp>
References: <20210321032831.340278-1-o-takashi@sakamocchi.jp>
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

ALSA bebob driver scans supported formats of packet for each direction
when probing the target device. Some helper functions are used for the
scanning, however its implementation is not necessarily irredundant.

This commit refactors the helper functions to remove redundant codes.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob_stream.c | 68 ++++++++++-------------------
 1 file changed, 24 insertions(+), 44 deletions(-)

diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index bbae04793c50..d96d2feb15a8 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -796,42 +796,42 @@ parse_stream_formation(u8 *buf, unsigned int len,
 	return 0;
 }
 
-static int
-fill_stream_formations(struct snd_bebob *bebob, enum avc_bridgeco_plug_dir dir,
-		       unsigned short pid)
+static int fill_stream_formations(struct snd_bebob *bebob, u8 addr[AVC_BRIDGECO_ADDR_BYTES],
+				  enum avc_bridgeco_plug_dir plug_dir, unsigned int plug_id,
+				  struct snd_bebob_stream_formation *formations)
 {
+	enum avc_bridgeco_plug_type plug_type;
 	u8 *buf;
-	struct snd_bebob_stream_formation *formations;
 	unsigned int len, eid;
-	u8 addr[AVC_BRIDGECO_ADDR_BYTES];
 	int err;
 
+	avc_bridgeco_fill_unit_addr(addr, plug_dir, AVC_BRIDGECO_PLUG_UNIT_ISOC, plug_id);
+
+	err = avc_bridgeco_get_plug_type(bebob->unit, addr, &plug_type);
+	if (err < 0) {
+		dev_err(&bebob->unit->device,
+			"Fail to get type for isoc %d plug 0: %d\n", plug_dir, err);
+		return err;
+	} else if (plug_type != AVC_BRIDGECO_PLUG_TYPE_ISOC)
+		return -ENXIO;
+
 	buf = kmalloc(FORMAT_MAXIMUM_LENGTH, GFP_KERNEL);
 	if (buf == NULL)
 		return -ENOMEM;
 
-	if (dir == AVC_BRIDGECO_PLUG_DIR_IN)
-		formations = bebob->rx_stream_formations;
-	else
-		formations = bebob->tx_stream_formations;
+	for (eid = 0; eid < SND_BEBOB_STRM_FMT_ENTRIES; ++eid) {
+		avc_bridgeco_fill_unit_addr(addr, plug_dir, AVC_BRIDGECO_PLUG_UNIT_ISOC, plug_id);
 
-	for (eid = 0; eid < SND_BEBOB_STRM_FMT_ENTRIES; eid++) {
 		len = FORMAT_MAXIMUM_LENGTH;
-		avc_bridgeco_fill_unit_addr(addr, dir,
-					    AVC_BRIDGECO_PLUG_UNIT_ISOC, pid);
-		err = avc_bridgeco_get_plug_strm_fmt(bebob->unit, addr, buf,
-						     &len, eid);
-		/* No entries remained. */
+		err = avc_bridgeco_get_plug_strm_fmt(bebob->unit, addr, buf, &len, eid);
+		// No entries remained.
 		if (err == -EINVAL && eid > 0) {
 			err = 0;
 			break;
 		} else if (err < 0) {
 			dev_err(&bebob->unit->device,
-			"fail to get stream format %d for isoc %s plug %d:%d\n",
-				eid,
-				(dir == AVC_BRIDGECO_PLUG_DIR_IN) ? "in" :
-								    "out",
-				pid, err);
+				"fail to get stream format %d for isoc %d plug %d:%d\n",
+				eid, plug_dir, plug_id, err);
 			break;
 		}
 
@@ -908,33 +908,13 @@ int snd_bebob_stream_discover(struct snd_bebob *bebob)
 		goto end;
 	}
 
-	avc_bridgeco_fill_unit_addr(addr, AVC_BRIDGECO_PLUG_DIR_IN,
-				    AVC_BRIDGECO_PLUG_UNIT_ISOC, 0);
-	err = avc_bridgeco_get_plug_type(bebob->unit, addr, &type);
-	if (err < 0) {
-		dev_err(&bebob->unit->device,
-			"fail to get type for isoc in plug 0: %d\n", err);
-		goto end;
-	} else if (type != AVC_BRIDGECO_PLUG_TYPE_ISOC) {
-		err = -ENOSYS;
-		goto end;
-	}
-	err = fill_stream_formations(bebob, AVC_BRIDGECO_PLUG_DIR_IN, 0);
+	err = fill_stream_formations(bebob, addr, AVC_BRIDGECO_PLUG_DIR_IN, 0,
+				     bebob->rx_stream_formations);
 	if (err < 0)
 		goto end;
 
-	avc_bridgeco_fill_unit_addr(addr, AVC_BRIDGECO_PLUG_DIR_OUT,
-				    AVC_BRIDGECO_PLUG_UNIT_ISOC, 0);
-	err = avc_bridgeco_get_plug_type(bebob->unit, addr, &type);
-	if (err < 0) {
-		dev_err(&bebob->unit->device,
-			"fail to get type for isoc out plug 0: %d\n", err);
-		goto end;
-	} else if (type != AVC_BRIDGECO_PLUG_TYPE_ISOC) {
-		err = -ENOSYS;
-		goto end;
-	}
-	err = fill_stream_formations(bebob, AVC_BRIDGECO_PLUG_DIR_OUT, 0);
+	err = fill_stream_formations(bebob, addr, AVC_BRIDGECO_PLUG_DIR_OUT, 0,
+				     bebob->tx_stream_formations);
 	if (err < 0)
 		goto end;
 
-- 
2.27.0

