Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D672CC5475B
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Mar 2024 10:13:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0D37FE94;
	Mon, 11 Mar 2024 11:13:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0D37FE94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1710152037;
	bh=ODVqP+lwq6xFwMgn2BlGi8UA6y56bCAsF8FKu0VoNGM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=L7jme8Y619eoX4R43HT5icLy8l65MM2KGprS9OBreyOJvL69njBkzcAm8cKE91yCt
	 Ins9KZduE06GykXdpnDGqdKkA0NQoZWkEc0AxN5bJxon1Z3ojzaMbwMAU0lneLMthF
	 tEjjaNNprOkNQCAvbk0LKaAfmrNWqDYGlqWXhsxs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 49689F8071C; Mon, 11 Mar 2024 11:11:22 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8877BF80717;
	Mon, 11 Mar 2024 11:11:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CAC08F806CD; Mon, 11 Mar 2024 11:11:13 +0100 (CET)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 86C61F805BD
	for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2024 11:10:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 86C61F805BD
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 431391A1979;
	Mon, 11 Mar 2024 11:10:29 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E9D511A0B42;
	Mon, 11 Mar 2024 11:10:28 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 3350B183AD24;
	Mon, 11 Mar 2024 18:10:27 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: hverkuil@xs4all.nl,
	sakari.ailus@iki.fi,
	tfiga@chromium.org,
	m.szyprowski@samsung.com,
	mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v14 13/16] media: uapi: Add an entity type for audio resampler
Date: Mon, 11 Mar 2024 17:53:58 +0800
Message-Id: <1710150841-26991-14-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1710150841-26991-1-git-send-email-shengjiu.wang@nxp.com>
References: <1710150841-26991-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Message-ID-Hash: ZG6EYOMDM2PM7SKOOS2USZO35HMPTYIM
X-Message-ID-Hash: ZG6EYOMDM2PM7SKOOS2USZO35HMPTYIM
X-MailFrom: shengjiu.wang@nxp.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZG6EYOMDM2PM7SKOOS2USZO35HMPTYIM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add and document a media entity type for an audio resampler.
It is MEDIA_ENT_F_PROC_AUDIO_RESAMPLER.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 Documentation/userspace-api/media/mediactl/media-types.rst | 6 ++++++
 include/uapi/linux/media.h                                 | 1 +
 2 files changed, 7 insertions(+)

diff --git a/Documentation/userspace-api/media/mediactl/media-types.rst b/Documentation/userspace-api/media/mediactl/media-types.rst
index adfb37430f8e..d353f17c3344 100644
--- a/Documentation/userspace-api/media/mediactl/media-types.rst
+++ b/Documentation/userspace-api/media/mediactl/media-types.rst
@@ -40,6 +40,7 @@ Types and flags used to represent the media graph elements
 .. _MEDIA-ENT-F-PROC-VIDEO-ENCODER:
 .. _MEDIA-ENT-F-PROC-VIDEO-DECODER:
 .. _MEDIA-ENT-F-PROC-VIDEO-ISP:
+.. _MEDIA-ENT-F-PROC-AUDIO-RESAMPLER:
 .. _MEDIA-ENT-F-VID-MUX:
 .. _MEDIA-ENT-F-VID-IF-BRIDGE:
 .. _MEDIA-ENT-F-DV-DECODER:
@@ -208,6 +209,11 @@ Types and flags used to represent the media graph elements
 	  combination of custom V4L2 controls and IOCTLs, and parameters
 	  supplied in a metadata buffer.
 
+    *  -  ``MEDIA_ENT_F_PROC_AUDIO_RESAMPLER``
+       -  An Audio Resampler device. An entity capable of
+	  resampling an audio stream from one sample rate to another sample
+	  rate. Must have one sink pad and at least one source pad.
+
     *  -  ``MEDIA_ENT_F_VID_MUX``
        - Video multiplexer. An entity capable of multiplexing must have at
          least two sink pads and one source pad, and must pass the video
diff --git a/include/uapi/linux/media.h b/include/uapi/linux/media.h
index 9ff6dec7393a..a8266eaa8042 100644
--- a/include/uapi/linux/media.h
+++ b/include/uapi/linux/media.h
@@ -125,6 +125,7 @@ struct media_device_info {
 #define MEDIA_ENT_F_PROC_VIDEO_ENCODER		(MEDIA_ENT_F_BASE + 0x4007)
 #define MEDIA_ENT_F_PROC_VIDEO_DECODER		(MEDIA_ENT_F_BASE + 0x4008)
 #define MEDIA_ENT_F_PROC_VIDEO_ISP		(MEDIA_ENT_F_BASE + 0x4009)
+#define MEDIA_ENT_F_PROC_AUDIO_RESAMPLER	(MEDIA_ENT_F_BASE + 0x400a)
 
 /*
  * Switch and bridge entity functions
-- 
2.34.1

