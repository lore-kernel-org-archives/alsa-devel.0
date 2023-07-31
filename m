Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D60C001DE
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Jul 2023 21:39:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 61F16836;
	Mon, 31 Jul 2023 23:39:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 61F16836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690839594;
	bh=eIHSLTn49PLH6BaHj9sdqt6aQ09Bsd1DBy7WeFJFRvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=kQWraN/wDjWs25SLsK5QJGPcSSqOnYi2zngDtL/5ydhJk97JDs3yfuSkoMZLlhCg9
	 GgMw/lWebP55E2e3833DGUqNozXkPxZmgVRZ/CIehVhgpKrNyU0yU4wSnCu6zNCWdY
	 8jl2gcpi5D17zfxFda46QKie25bS3WhaA7i5Sh7k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4B47AF80544; Mon, 31 Jul 2023 23:38:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C5246F80544;
	Mon, 31 Jul 2023 23:38:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A92FAF8055C; Mon, 31 Jul 2023 23:38:15 +0200 (CEST)
Received: from mgamail.intel.com (unknown [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B9CE3F80563
	for <alsa-devel@alsa-project.org>; Mon, 31 Jul 2023 23:38:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B9CE3F80563
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=nxGNcvC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690839494; x=1722375494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eIHSLTn49PLH6BaHj9sdqt6aQ09Bsd1DBy7WeFJFRvA=;
  b=nxGNcvC4cH2nb2OPMJbEie+wwoYgLtpCvfBuo94z/5BeQIswWNThlpj6
   41j+Lxl6aKpC4eHxffMBGm2MX47uqUzSnUN42VHQFK4ZuIATgNqJ3hvvL
   ar7Joq5VXkEKhyFgzIUZbBabopEaphpYZuaW7t5YMVIVA3EhSue25ZTRd
   G55jHOiHDxcRwKVS/+Md1NDk5dlUzSLzSXIzOn8qlcYLGYzW/edRC5Bi+
   vnLITXxuokxoNWarQkpZ/d7QOVW2RscQVCshpNquW5wHw4bNMAMsZQSQO
   ENqqK3ZQBjU6DaNzf9k3KBhWyT350I/PNmQdR0vk0G4n9wV8PwVDdpn5/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="366604116"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200";
   d="scan'208";a="366604116"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 14:38:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="793880069"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200";
   d="scan'208";a="793880069"
Received: from youngnic-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.180.66])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 14:38:10 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	broonie@kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Rander Wang <rander.wang@intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Yaochun Hung <yc.hung@mediatek.com>
Subject: [PATCH 5/8] ASoC: SOF: mediatek: remove error checks on NULL ipc
Date: Mon, 31 Jul 2023 16:37:45 -0500
Message-Id: <20230731213748.440285-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230731213748.440285-1-pierre-louis.bossart@linux.intel.com>
References: <20230731213748.440285-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ERUS7LZ25KT6XL6TIRJUF2EVGJRWFNGW
X-Message-ID-Hash: ERUS7LZ25KT6XL6TIRJUF2EVGJRWFNGW
X-MailFrom: pierre-louis.bossart@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ERUS7LZ25KT6XL6TIRJUF2EVGJRWFNGW/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

mtk_adsp_ipc_get_data() can return NULL, but the value is not checked
before being used, leading to static analysis warnings.

sound/soc/sof/mediatek/mt8195/mt8195.c:90:32: error: dereference of
NULL ‘0’ [CWE-476] [-Werror=analyzer-null-dereference]

   90 |         spin_lock_irqsave(&priv->sdev->ipc_lock, flags);
      |                            ~~~~^~~~~~

It appears this is not really a possible problem, so remove those checks.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Yaochun Hung <yc.hung@mediatek.com>
---
 include/linux/firmware/mediatek/mtk-adsp-ipc.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/firmware/mediatek/mtk-adsp-ipc.h b/include/linux/firmware/mediatek/mtk-adsp-ipc.h
index 28fd313340b8..5b1d16fa3f56 100644
--- a/include/linux/firmware/mediatek/mtk-adsp-ipc.h
+++ b/include/linux/firmware/mediatek/mtk-adsp-ipc.h
@@ -46,17 +46,11 @@ struct mtk_adsp_ipc {
 
 static inline void mtk_adsp_ipc_set_data(struct mtk_adsp_ipc *ipc, void *data)
 {
-	if (!ipc)
-		return;
-
 	ipc->private_data = data;
 }
 
 static inline void *mtk_adsp_ipc_get_data(struct mtk_adsp_ipc *ipc)
 {
-	if (!ipc)
-		return NULL;
-
 	return ipc->private_data;
 }
 
-- 
2.39.2

