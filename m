Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5E1CA9EC0
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Oct 2026 19:41:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0F846601F9;
	Sat, 10 Oct 2026 21:41:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0F846601F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791661309;
	bh=dI/ediDEtYW1zJEmi2TVBHlg+BaG4nXKtBtA6rC2rD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=vTWgxUtQ0QHdSxYdpLZr0jYpMTNpyVNfTbST2FvB9jAfIfCikHUbtKePjwNiOLDe7
	 CpeKTov5QRJoPdBHvhstg0STmmyw67xnUfFal4XyaFQ6wf1i2BBxhRK7zauvvlJ7ki
	 pLgGGj11ZNsPE8aShLY1Fpuno0LiJPC5B9MoOGd0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0A3D5F80610; Sat, 10 Oct 2026 21:40:57 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0A383F80611;
	Sat, 10 Oct 2026 21:40:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A1757F805F1; Thu,  8 Oct 2026 21:01:26 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791486084;
	b=B6hJU964AQCygPLVsSFQMB9Ttn4b8ObJSIpM8doMLeEKMSZwvy83dXqKyYXLQ9fsbPRA
	 4oRzCYIMNueEnmqEgEPeYAP9V2FYWcDNNTD6qk4KwrVXm6Exn3OotjCuO5Ilb+nlVHYYo
	 JJKEy2+/BlkJjQgtY0PbiJIpg6+387iGmAyeWdPvVPIwusOIRwSRIwgLOZc+WJPIu3iGn
	 Kfhl5nRqvSuMQlDHzdRGyNX6N2mRwnaCA37uhRdLG3YNQ9wS0dU5vz/iRglTPjqvUPwK9
	 EZXugY0bb7CsplnB7xNARqC1niC66wlzL2x84vzO058dygxy+nDbedLUtp94d+EY9HA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791486084;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=dI/ediDEtYW1zJEmi2TVBHlg+BaG4nXKtBtA6rC2rD4=;
	b=S5n4klyTTL9OtyaNrZjzE8v2jaSoo1eRp5Xocw6FVB7Gjnf+nvVsq0i1Rt4Ivk49XCK8
	 S/U9Qf7co+5803FP9qv/70bWuT4zijWVdMM687Cp/WNN/Dpo+mXOfe6t7GFs7Cx6AYuyw
	 85pPiTNKi3Ttcct6bfsYZu3Rs+waJKd0MO5tIXPsf2DN0AiqtUHYrviyZQK3q7oGjl/CQ
	 9er7Z+7+UVpNnYmZ+u69PdFWsvwO6TXcxBG4COZQRHK4qpiPrZ6UmX0xc0kZmbltale6L
	 2u4kWSxY9twrIbfDR4G6Ntx6L+Jx2Sfege45zgUv1aPEt8nO+n2upP6p4BxDsXGoiGQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=trailofbits.com header.i=@trailofbits.com
 header.a=rsa-sha256 header.s=google header.b=Vdue2JZW;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7609BF80571
	for <sound-open-firmware@alsa-project.org>;
 Thu,  8 Oct 2026 21:01:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7609BF80571
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=trailofbits.com header.i=@trailofbits.com
 header.a=rsa-sha256 header.s=google header.b=Vdue2JZW
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-33c2520ad38so8022894eec.1
        for <sound-open-firmware@alsa-project.org>;
 Thu, 08 Oct 2026 12:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1791486081; x=1792090881;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wH0vSAnuTtk11qs15jI11qzpg6PrfnUwzzqFGPyRMD0=;
        b=Vdue2JZWR6FYNxgyOY+Ynoe1DgbF5hk/6Qwrn5UeqxH1U3t59Fk5aVbPMXt149kqtN
         3HNZmxVPFSGGQbNZUz3U9XCz9T4tYzPXzaMgW0zuiJFhT8yi7fe1wL0tkIioJz+gRhOR
         orke/SuVPms0Phq2qYDx0Wz7mno0GNZsr0IGWy+WMzkIuHE8p9Rs37tSYL3bEk2VeCxW
         5hqr44uGTMOWY+5RUqZhsYQswDy3qJiUI0iX+K+uT28f1MaTGzUFogkhQLPtxIP/0ZUV
         uOjQxnNIZVSATeoFoMgSgo85cgzLjv/oASTtY82vkxu/acILmN31g8MpP5g4WmdPGNfB
         oKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791486081; x=1792090881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wH0vSAnuTtk11qs15jI11qzpg6PrfnUwzzqFGPyRMD0=;
        b=y424XfZ7rOjT/+hYGFMPBEt9YlMhp9CzmV6+eSiT2eee2+EM/5GdDtlwOnfBkjCLm2
         m1Z8rtfbOT/ckvFnO1UAQPrXt0upGAvkbcrIHqoflL65LhK4R7coogWbY4ML2ChC2ooO
         sWGmPxm0EG8wSR+qrzMfXif6KzchdMmdcshxke0d8v6mtshLY3XOppdKbYrOpHNWeKWE
         q5T7ak1+fz2NnCEMRCDZs9Ubhc1bPyQT5fLqX6Oflf6etqAY64ZLSHlmHYDZY1QQtDia
         2ll+W4yXlmoliEUJxm7pTZzzCn1lTUA5Cp90Nk2kotxIxRMZ5dgyPCMD1P5PI073IEdC
         6inA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxY/Ism59pTQevnDogKPCpjr6AD7M3d2cqN6DzjJqgkZ4faPDLQVGq4oLteBK1E4IGySNh2A9ti3tPns2z4pvR22ROj@alsa-project.org
X-Gm-Message-State: AFuF++kswGaxGYEx67sNG5C3Lvqwbc/SNb+CDbX4cchQz6PxJVPaw3kd
	/PYb20v6oOvqalBFKZJv13smzFbokoNbsMtKrhxrWwgw5bU4f044GmqatLOrXyhNVNw=
X-Gm-Gg: AYBFou3hOlstTolzdJfu1ab5ZS1giFirXtqE3/pR8t2fGpDgSw4yxtpm3Ga4DkfAIDL
	6NGFuJ7iirG+BDLX/8FikrOhNFwnDPjJmhIQLNt27U2Yh4fb8TevTebDMQ4odxLILXAhc/3d4Uz
	KD1qdYLNyFbIglVEx9yutlBHaoQVSiBGqMm/4p91o1CqvTKCbMHHp0rPICIN5tOlbgoSR/6a58a
	bEMspzMLApVnmcy6bTBGqoY2Nwztb/C70VhaG4P+I/CI8qINaHi16VIxIIAUSp966Q3X43aRGh0
	/6taLJNVPbpBKtc41d7w4/gFH6Ji/2qiIOvhvlN45djdccsB5LCGZ4RbN3CBYe+xFERMQgQDOre
	sh24/N/5F3PTMtodwjeaOeXhuM0Cyzu1WZ9SWSqYcnqV46P1J/6RHY/DF/rOjlz+9I9ybE6UL8M
	C9+Z1rLxBb9R6PxS7B6rF6GG5UiyoSxNwy6mslE/+8gclBGNssik/wtnX3P8yaGto3hjo4RB6YM
	D9V2gEReBuu9+WoAzt14jCXftnMGNM0d3FdlJkB0+oWlFs4JCRSf4GbZpQurhLN2iv0B+o=
X-Received: by 2002:a05:7022:2513:b0:14b:1e78:a19f with SMTP id
 a92af1059eb24-161fdbedf4bmr10042490c88.6.1791486079633;
        Thu, 08 Oct 2026 12:01:19 -0700 (PDT)
Received: from localhost.localdomain
 ([2603:8001:5f01:8bab:bc88:5ec1:4f8a:5b23])
        by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537b3eccebsm405691eec.12.2026.10.08.12.01.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 12:01:18 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	sound-open-firmware@alsa-project.org,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	linux-sound@vger.kernel.org
Subject: [PATCH 6.6.y 2/2] ASoC: SOF: ipc4-topology: Harden loops for looking
 up ALH copiers
Date: Thu,  8 Oct 2026 15:01:04 -0400
Message-ID: <20261008190108.96660-3-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008190108.96660-1-artem@trailofbits.com>
References: <20261008190108.96660-1-artem@trailofbits.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: artem@trailofbits.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-sound-open-firmware.alsa-project.org-0;
 header-match-sound-open-firmware.alsa-project.org-1; emergency;
 member-moderation
Message-ID-Hash: JVFTXE6EUJEYYYRPWVD37UWCZQOJW2SS
X-Message-ID-Hash: JVFTXE6EUJEYYYRPWVD37UWCZQOJW2SS
X-Mailman-Approved-At: Sat, 10 Oct 2026 19:40:48 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JVFTXE6EUJEYYYRPWVD37UWCZQOJW2SS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit 6fd60136d256b3b948333ebdb3835f41a95ab7ef ]

Other, non DAI copier widgets could have the same  stream name (sname) as
the ALH copier and in that case the copier->data is NULL, no alh_data is
attached, which could lead to NULL pointer dereference.
We could check for this NULL pointer in sof_ipc4_prepare_copier_module()
and avoid the crash, but a similar loop in sof_ipc4_widget_setup_comp_dai()
will miscalculate the ALH device count, causing broken audio.

The correct fix is to harden the matching logic by making sure that the
1. widget is a DAI widget - so dai = w->private is valid
2. the dai (and thus the copier) is ALH copier

[ Backport to 6.6.y: Apply both widget-kind and ALH-type predicates to
  the target loops; the newer node_type local is absent and unused by
  this implementation. ]

Fixes: a150345aa758 ("ASoC: SOF: ipc4-topology: add SoundWire/ALH aggregation support")
Reported-by: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
Link: https://github.com/thesofproject/sof/pull/9652
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://patch.msgid.link/20250206084642.14988-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
This is patch 2 of 2 in the ordered 6.6.y backport series.
This change addresses CVE-2025-21870. Limits ALH aggregation searches to
DAI widgets of ALH type, preventing NULL private-data dereferences and
incorrect device counts from same-name non-DAI widgets.
Each loop checks WIDGET_IS_DAI() before interpreting w->private as a
DAI, then checks SOF_DAI_INTEL_ALH before incrementing the device
count or accessing copier data.

The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y.
This fix also affects 6.1.y, which will need a separate backport; this
submission contains only the 6.6.y patch.

 sound/soc/sof/ipc4-topology.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 18096aefce13..8911c075251c 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -577,10 +577,16 @@ static int sof_ipc4_widget_setup_comp_dai(struct snd_sof_widget *swidget)
 		}
 
 		list_for_each_entry(w, &sdev->widget_list, list) {
-			if (w->widget->sname &&
+			struct snd_sof_dai *alh_dai;
+
+			if (!WIDGET_IS_DAI(w->id) || !w->widget->sname ||
 			    strcmp(w->widget->sname, swidget->widget->sname))
 				continue;
 
+			alh_dai = w->private;
+			if (alh_dai->type != SOF_DAI_INTEL_ALH)
+				continue;
+
 			blob->alh_cfg.device_count++;
 		}
 
@@ -1692,11 +1698,13 @@ sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
 			 */
 			i = 0;
 			list_for_each_entry(w, &sdev->widget_list, list) {
-				if (w->widget->sname &&
+				if (!WIDGET_IS_DAI(w->id) || !w->widget->sname ||
 				    strcmp(w->widget->sname, swidget->widget->sname))
 					continue;
 
 				dai = w->private;
+				if (dai->type != SOF_DAI_INTEL_ALH)
+					continue;
 				alh_copier = (struct sof_ipc4_copier *)dai->private;
 				alh_data = &alh_copier->data;
 				blob->alh_cfg.mapping[i].device = alh_data->gtw_cfg.node_id;
-- 
2.39.5
