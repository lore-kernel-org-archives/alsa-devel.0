Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56CEC30653
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Jul 2024 00:19:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1BDC92233;
	Mon,  1 Jul 2024 02:19:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1BDC92233
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1719793160;
	bh=qclWDWQblk91dDA0GVzaDjjEZGFR4p3CRjmmwvtKyCg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=GgyORSg0rBe1cgLwQ6O/0cKmqxA2e9r0JEE3VKy2K8p2J7VjDAq8PzEOhGEdqV9GN
	 RBN1uOtJHYcsY3FzDSG10MrXJ34+Y7dDhSaWMQJ30f6ZgcSTHJRUYsqC9nPlmYgFzz
	 fBQxBi6qi+uQxt18gdrKPMuZ5Tr0xgmT52D+ywTM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 762ABF80616; Mon,  1 Jul 2024 02:18:09 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 68E82F80622;
	Mon,  1 Jul 2024 02:18:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C9A2CF8028B; Mon,  1 Jul 2024 02:13:50 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5FA15F800E4
	for <alsa-devel@alsa-project.org>; Mon,  1 Jul 2024 02:13:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5FA15F800E4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=OpiFQ/j8
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 3D749CE0EDE;
	Mon,  1 Jul 2024 00:13:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180DAC2BD10;
	Mon,  1 Jul 2024 00:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719792825;
	bh=qclWDWQblk91dDA0GVzaDjjEZGFR4p3CRjmmwvtKyCg=;
	h=From:To:Cc:Subject:Date:From;
	b=OpiFQ/j8apaTm0zVNkSx5Bon3n4xMcwWGuPxLoT1NAqzYW7S7ejWYEoPE34JNt6k+
	 ybL55QwGyFC22tEQnZWUD4iErZGZu/P5Jf8HEUMlbdHTII3PfPf5u7BiCQpG3DdMhO
	 IxNMiKjCaRJWo0yN4FegHoty5KWKK7bykmNeolw6iSHWH63W+zPhngLmQiB4+VhXeJ
	 9+iD9QE7zf8fDUbP3IbMwn1hmEjAVWVAv789Qozbfwh+8Y3keL3SFPyjO9kwL/84yg
	 jwyAASFs5HXglwk2AO43vQ+E2JuAJeOEGEGRb6rwT4XyOOcgRLx5UduK90UarkObs4
	 2Qj3XHu3HqeHw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Simon Trimmer <simont@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 01/12] ALSA: hda: cs35l56: Fix lifecycle of codec
 pointer
Date: Sun, 30 Jun 2024 20:13:20 -0400
Message-ID: <20240701001342.2920907-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.36
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ONGAPKKLW7KNXEA7HYB7CBNGCGIGNDA3
X-Message-ID-Hash: ONGAPKKLW7KNXEA7HYB7CBNGCGIGNDA3
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ONGAPKKLW7KNXEA7HYB7CBNGCGIGNDA3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Simon Trimmer <simont@opensource.cirrus.com>

[ Upstream commit d339131bf02d4ed918415574082caf5e8af6e664 ]

The codec should be cleared when the amp driver is unbound and when
resuming it should be tested to prevent loading firmware into the device
and ALSA in a partially configured system state.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20240531112716.25323-1-simont@opensource.cirrus.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/cs35l56_hda.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index 15e20d9261393..77e8da7dffc6a 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -702,6 +702,8 @@ static void cs35l56_hda_unbind(struct device *dev, struct device *master, void *
 	if (comps[cs35l56->index].dev == dev)
 		memset(&comps[cs35l56->index], 0, sizeof(*comps));
 
+	cs35l56->codec = NULL;
+
 	dev_dbg(cs35l56->base.dev, "Unbound\n");
 }
 
@@ -807,6 +809,9 @@ static int cs35l56_hda_system_resume(struct device *dev)
 
 	cs35l56->suspended = false;
 
+	if (!cs35l56->codec)
+		return 0;
+
 	ret = cs35l56_is_fw_reload_needed(&cs35l56->base);
 	dev_dbg(cs35l56->base.dev, "fw_reload_needed: %d\n", ret);
 	if (ret > 0) {
-- 
2.43.0

