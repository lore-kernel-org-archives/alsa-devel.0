Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70157C4167B
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Dec 2023 14:02:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F485E74;
	Mon, 11 Dec 2023 15:02:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F485E74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1702303332;
	bh=io5b0CtthDtVhfSuTuXBd3DmjU7bDwXaJaCfI9lzbSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Uv3rh6XW16Dlk1Mx6TQr+FiiYVsagXh3LE/+eQOEgF516XiNjl8W9rp8fu8oGrBzy
	 qSZ4R8YAr0vr54iwMJUvlkM72G/c4rmV0Eq7b87u8Ko5t1mPe8FQ3yDMVBPbbFtS6l
	 6ABFx/egdsBnCjeGCwnqbJ0Nbp0L3lIkQaFgSB1s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 598C9F80587; Mon, 11 Dec 2023 15:01:41 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BE208F8057F;
	Mon, 11 Dec 2023 15:01:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 57906F80124; Mon, 11 Dec 2023 15:01:36 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 11A17F80124
	for <alsa-devel@alsa-project.org>; Mon, 11 Dec 2023 15:01:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 11A17F80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=q8Dv2Zza
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5D13D612AC;
	Mon, 11 Dec 2023 14:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09C5C433C8;
	Mon, 11 Dec 2023 14:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702303288;
	bh=io5b0CtthDtVhfSuTuXBd3DmjU7bDwXaJaCfI9lzbSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q8Dv2Zza4xcBAULx6BUNw2c8JhDBTTIKAo/VSaYgvhVS0RsbuGiFDQ5qnyqLDOWpi
	 WAu1Q3TXyupxQwtc+/2KX4WCwzyVLEPuCxCO/jBVeDQStu0XW19j5rAkCxO4hfKxxh
	 R/OmX77y7Ew1o2EBwDQ5cFrlfXl/PCPAKAXES9vJTaKHNtTNmQAzRGs0sojmbVbyGg
	 B0vIdG7hFzrws0baWvJzmUx/KQc7i4UEgZBRdi5EA6JGQyWFomy/Z0gmw2b/qAGEvt
	 Gb8MfMpz4X7gF+ipC+0z6AigHrlhRKmnPn4eI2mKVuZW7w0giEtfzHIT8nQSGp74zm
	 CpETHYA6X5CWw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kamil Duljas <kamil.duljas@gmail.com>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	cezary.rojewski@intel.com,
	pierre-louis.bossart@linux.intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	suhui@nfschina.com,
	kuninori.morimoto.gx@renesas.com,
	zhangyiqun@phytium.com.cn,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 02/16] ASoC: Intel: Skylake: Fix mem leak in few
 functions
Date: Mon, 11 Dec 2023 09:00:26 -0500
Message-ID: <20231211140116.391986-2-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211140116.391986-1-sashal@kernel.org>
References: <20231211140116.391986-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.203
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 5S454SVJKKBQBHFGWVSDHC3UJSWMNOKV
X-Message-ID-Hash: 5S454SVJKKBQBHFGWVSDHC3UJSWMNOKV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5S454SVJKKBQBHFGWVSDHC3UJSWMNOKV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Kamil Duljas <kamil.duljas@gmail.com>

[ Upstream commit d5c65be34df73fa01ed05611aafb73b440d89e29 ]

The resources should be freed when function return error.

Signed-off-by: Kamil Duljas <kamil.duljas@gmail.com>
Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Link: https://lore.kernel.org/r/20231116125150.1436-1-kamil.duljas@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c     | 4 +++-
 sound/soc/intel/skylake/skl-sst-ipc.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index b531d9dfc2d64..c7e76111f68b7 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -251,8 +251,10 @@ static int skl_pcm_open(struct snd_pcm_substream *substream,
 	snd_pcm_set_sync(substream);
 
 	mconfig = skl_tplg_fe_get_cpr_module(dai, substream->stream);
-	if (!mconfig)
+	if (!mconfig) {
+		kfree(dma_params);
 		return -EINVAL;
+	}
 
 	skl_tplg_d0i3_get(skl, mconfig->d0i3_caps);
 
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index 7a425271b08b1..fd9624ad5f72b 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -1003,8 +1003,10 @@ int skl_ipc_get_large_config(struct sst_generic_ipc *ipc,
 
 	reply.size = (reply.header >> 32) & IPC_DATA_OFFSET_SZ_MASK;
 	buf = krealloc(reply.data, reply.size, GFP_KERNEL);
-	if (!buf)
+	if (!buf) {
+		kfree(reply.data);
 		return -ENOMEM;
+	}
 	*payload = buf;
 	*bytes = reply.size;
 
-- 
2.42.0

