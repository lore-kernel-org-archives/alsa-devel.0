Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD17C4332F
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Nov 2023 11:58:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8E75484D;
	Mon, 13 Nov 2023 12:57:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8E75484D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1699876720;
	bh=LrGiV2mdGsMPCAdXVZozUjPusVyFIfH5TlLORvgYBNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=vUYl5QAop/acHBX5vgCuvy4kVSD0gXOjj6BvZdvNNE/4rQl+fsZKn9cc86uVrorhh
	 3F+yGyVNGGqIRyZ4C6SloNLbaX2qqyutjEW+QubIS3eZBlE0rFD981O/Wcc+D4tMnF
	 KWT+XHdTo3AiOqAO66BG8WfehTwjMipnvbcb4CLg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B975EF8057C; Mon, 13 Nov 2023 12:57:29 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D0C39F8057C;
	Mon, 13 Nov 2023 12:57:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E090BF80249; Mon, 13 Nov 2023 11:22:28 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2B0CCF801D5
	for <alsa-devel@alsa-project.org>; Mon, 13 Nov 2023 11:22:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2B0CCF801D5
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 7B3FFB80D1C;
	Mon, 13 Nov 2023 10:22:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AB3C433C9;
	Mon, 13 Nov 2023 10:22:12 +0000 (UTC)
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
To: linux-media@vger.kernel.org
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>,
	alsa-devel@alsa-project.org,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 4/8] libmedia_dev: support v4l-audio
Date: Mon, 13 Nov 2023 11:18:45 +0100
Message-ID: 
 <45d2bae97fa5a317cfe35cf4e156fc141fef01d9.1699870530.git.hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.42.0
In-Reply-To: 
 <7889c22b922214ebcc0e62feeeb167b40d5042ec.1699870530.git.hverkuil-cisco@xs4all.nl>
References: 
 <7889c22b922214ebcc0e62feeeb167b40d5042ec.1699870530.git.hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: SRS0=a+Jp=G2=xs4all.nl=hverkuil-cisco@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: ADPFFFMRSYRXVXSCNOEB2URKJSUXP4MN
X-Message-ID-Hash: ADPFFFMRSYRXVXSCNOEB2URKJSUXP4MN
X-Mailman-Approved-At: Mon, 13 Nov 2023 11:57:19 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ADPFFFMRSYRXVXSCNOEB2URKJSUXP4MN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Detect v4l-audioX devices.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 utils/libmedia_dev/get_media_devices.c | 4 ++++
 utils/libmedia_dev/get_media_devices.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/utils/libmedia_dev/get_media_devices.c b/utils/libmedia_dev/get_media_devices.c
index 21920867..51635acf 100644
--- a/utils/libmedia_dev/get_media_devices.c
+++ b/utils/libmedia_dev/get_media_devices.c
@@ -226,6 +226,8 @@ static int add_v4l_class(struct media_device_entry *md)
 		md->type = MEDIA_V4L_RADIO;
 	else if (strstr(md->node, "v4l-touch"))
 		md->type = MEDIA_V4L_TOUCH;
+	else if (strstr(md->node, "v4l-audio"))
+		md->type = MEDIA_V4L_AUDIO;
 	else if (strstr(md->node, "v4l-subdev"))
 		md->type = MEDIA_V4L_SUBDEV;
 
@@ -379,6 +381,8 @@ const char *media_device_type(enum device_type type)
 		return "swradio";
 	case MEDIA_V4L_TOUCH:
 		return "v4l-touch";
+	case MEDIA_V4L_AUDIO:
+		return "v4l-audio";
 	case MEDIA_V4L_SUBDEV:
 		return "v4l subdevice";
 
diff --git a/utils/libmedia_dev/get_media_devices.h b/utils/libmedia_dev/get_media_devices.h
index 1a62c54e..235a8c4a 100644
--- a/utils/libmedia_dev/get_media_devices.h
+++ b/utils/libmedia_dev/get_media_devices.h
@@ -37,6 +37,7 @@ enum device_type {
 	MEDIA_V4L_RADIO,
 	MEDIA_V4L_SWRADIO,
 	MEDIA_V4L_TOUCH,
+	MEDIA_V4L_AUDIO,
 	MEDIA_V4L_SUBDEV,
 
 	MEDIA_DVB_VIDEO = 100,
-- 
2.42.0

