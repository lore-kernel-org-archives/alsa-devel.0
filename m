Return-Path: <SRS0=W3EJ=LF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B166C48BD1
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Jun 2021 09:40:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05536613CF
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Jun 2021 09:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05536613CF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A4F711925;
	Fri, 11 Jun 2021 11:39:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A4F711925
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623404408;
	bh=ngCaAf03qLVch2+Gb0kyjOF9HCr6b/P5r6VjytldCOY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nQDzZFSpK7VYvIvfDzPNDftwKS/yThdX0LmWWxJai6HrIOItFtiIVDfWWMbd+iiWx
	 ILMxtS2F6l9Ki9FpVlQzEsZmik0cjDnflDlbEB789VENgD2RJlqsQbxnVgUAyqW1VM
	 VuGjHIDk9cO7UM8XW6duE+CPiD8x35J5UvWH3O6Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BB50DF804CA;
	Fri, 11 Jun 2021 11:37:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7FA48F804C3; Fri, 11 Jun 2021 11:37:52 +0200 (CEST)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com
 [64.147.123.19])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 80512F80276
 for <alsa-devel@alsa-project.org>; Fri, 11 Jun 2021 11:37:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 80512F80276
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="HN7RzRBI"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="ubu5f7ep"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.west.internal (Postfix) with ESMTP id CBEA01AB0;
 Fri, 11 Jun 2021 05:37:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Fri, 11 Jun 2021 05:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=fnkOzJ6AnoN5s
 GF1n5hmP0Pz9GMo/PNILUy+3TR+F1w=; b=HN7RzRBI06hy0mVIhqCvdfnCMpQUt
 rHfmV8ko4VuBnerbIyaInZ+mnh70Av+Sxnt96AEs+X6LZOVYCXn4IeqX4vb/euNW
 IXfZbgEu7zJGOC7jqUcvHys0XhtEYTb6NLc58qXa57fUl+JrkFSyU1iZIa1bQLAP
 xjPNkaKGz9M148Zm2jDCpt9QapYeq+bRpgqzI90GfsVfZGlesrN+gHEhezQxyDWY
 U6tE3Eg/tLvah8M3xsf97L+J7BFl/inVfH/eAzGG9ntY02QJa4sFw1xydcY6a8bA
 VSfZLHDEeOJWIjzaEWBFDNI3Ld/iJCHLwicjZtex/+1X0A7Kc1EyDU41g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=fnkOzJ6AnoN5sGF1n5hmP0Pz9GMo/PNILUy+3TR+F1w=; b=ubu5f7ep
 LfuyZLBIXApHlO6hoD3VnR3IniJBAzIJRZIVlL+pt1kb0daLnoux74/Tu7cNFNzc
 r1z4CoXNGnanFFdE6YVGpbgkj5E38q/60dix1uEr3rbzkBwYFeGBmHaXd2PLj+iH
 6p4BJ05VnJUZihXaK1KeHFSUqcEbCr3zbmD7EfstaisdriAK3uHsB+YLM2VLkxu7
 eJTiRvmSvtr15tRYMmsxzqVplHmvc6IolhOmxSNVrZM4bBU+Zq7ran4sxALUNMeV
 w06fjcDwBAh+GM3wY89UKUdZj0mb+YOAueWXWvlUur7ThYCzxNfZ2qT0i9aCV5Ur
 YVGGfCv7GL1TtA==
X-ME-Sender: <xms:5S7DYH6rWX57IeR1ilHxJt-_4B_ONRQ51OXHG19TyKtbBK5VDe_w1w>
 <xme:5S7DYM5UXwAPFa4ZnCTbvJ5K3RmJBOM0H9TLWQkj4p3h61p-3kZsvynqUenBqd3ef
 sWS77-7V7TWuQQuCOA>
X-ME-Received: <xmr:5S7DYOeHEJhkZ_KzddwfKz8SljLVS7aVVS1XR5x_K7nKmHBhoxOTk7Y0f7KGzh0ETdsV4UoyiEKtozNVjV7yXUYXB93tnkfllnMJkFY84HQ9Jmnoloz1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedujedgudejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
 shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepffeuveeuue
 eghfekgeefgfelffejheffhfejtdeileelkeejkeefkeeuvedujeeinecuffhomhgrihhn
 pehffhgrughordhorhhgpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
 dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgt
 tghhihdrjhhp
X-ME-Proxy: <xmx:5S7DYILT-ng9ZUxlwf8GiyZaKHrCKOsH0uEvplitygl9DGZrSeA6kw>
 <xmx:5S7DYLKe7tCkWLI8vNrbSMyTMVErrOu9qc5WQxIG7Y95v3sVoBt5dg>
 <xmx:5S7DYBwaLIG7Zeg4JafwUOJRLBfY_nt6HPmXpmS4uiFNWDz0S06iMQ>
 <xmx:5S7DYBgN1Mzp_0xl2JntvMaYF4c_JBjFCMQbsa3EuiMldNVK8tv-aA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jun 2021 05:37:40 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH 3/6] ALSA: bebob: correct device entry for Mackie D.2 FireWire
 option card
Date: Fri, 11 Jun 2021 18:37:27 +0900
Message-Id: <20210611093730.78254-4-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210611093730.78254-1-o-takashi@sakamocchi.jp>
References: <20210611093730.78254-1-o-takashi@sakamocchi.jp>
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

For Mackie D.2 FireWire option card, 0x00000f is used for the value of
immediate entry for vendor in unit directory. The value comes from report
by FFADO user in below page:

 * http://subversion.ffado.org/wiki/AvcModels/MackieD.2.

However, it seems to be wrong. There are two causes; vendor's mistake to
decide value for GUID field in configuration ROM against standard, as
Stefan Richter mentioned in below post:

 * https://lore.kernel.org/alsa-devel/1443917823-13516-1-git-send-email-o-takashi@sakamocchi.jp/#t

Another is implementation of libffado. The library doesn't print out the
value from immediate entry for vendor in unit directory. It just print out
the first 6 bytes of GUID as vendor ID.

This commit replaces with correct vendor OUI.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index 5ce25ddcbf5c..db1c1dfc0484 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -40,8 +40,7 @@ static DECLARE_BITMAP(devices_used, SNDRV_CARDS);
 #define VEN_EDIROL	0x000040ab
 #define VEN_PRESONUS	0x00000a92
 #define VEN_BRIDGECO	0x000007f5
-#define VEN_MACKIE1	0x0000000f
-#define VEN_MACKIE2	0x00000ff2
+#define VEN_MACKIE	0x00000ff2
 #define VEN_STANTON	0x00001260
 #define VEN_TASCAM	0x0000022e
 #define VEN_BEHRINGER	0x00001564
@@ -380,9 +379,9 @@ static const struct ieee1394_device_id bebob_id_table[] = {
 	/* BridgeCo, Audio5 */
 	SND_BEBOB_DEV_ENTRY(VEN_BRIDGECO, 0x00010049, &spec_normal),
 	/* Mackie, Onyx 1220/1620/1640 (Firewire I/O Card) */
-	SND_BEBOB_DEV_ENTRY(VEN_MACKIE2, 0x00010065, &spec_normal),
+	SND_BEBOB_DEV_ENTRY(VEN_MACKIE, 0x00010065, &spec_normal),
 	// Mackie, d.2 (optional Firewire card with DM1000).
-	SND_BEBOB_DEV_ENTRY(VEN_MACKIE1, 0x00010067, &spec_normal),
+	SND_BEBOB_DEV_ENTRY(VEN_MACKIE, 0x00010067, &spec_normal),
 	/* Stanton, ScratchAmp */
 	SND_BEBOB_DEV_ENTRY(VEN_STANTON, 0x00000001, &spec_normal),
 	/* Tascam, IF-FW DM */
-- 
2.30.2

