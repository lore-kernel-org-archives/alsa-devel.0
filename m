Return-Path: <SRS0=LPcU=4F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0BFC3B1BF
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 03:18:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143A52070B
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 03:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rNHnGv3M";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="nEeqMrk6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143A52070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 53D3C826;
	Mon, 17 Feb 2020 04:17:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 53D3C826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581909479;
	bh=kgrkQl+fjrA5thZaF38z/2bzHd5XYpv+Tm7+jwzryIQ=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rNHnGv3Mve9GqlL85RYQ2p6MnaPVWZAeheuNCjQOriI/fmq11jM1++RZFK3xaKt1T
	 jTKb+T8q/jfOsBm+kIchtBCmEoi0/lF29/56TP1hheUAEgq7mYQdd/OW1TJY8ZKtnf
	 0U0X/pWI7d5JhLWNuzvITSZicVlyuZnyrRLw8RvE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CADB5F8015E;
	Mon, 17 Feb 2020 04:17:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BA658F80096; Mon, 17 Feb 2020 04:17:06 +0100 (CET)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com
 [IPv6:2607:f8b0:4864:20::54a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DA8BBF80096
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2020 04:17:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DA8BBF80096
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="nEeqMrk6"
Received: by mail-pg1-x54a.google.com with SMTP id h14so7141314pgd.15
 for <alsa-devel@alsa-project.org>; Sun, 16 Feb 2020 19:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=95LDy22BpOxyIQvBk6FRPJlH91thVepwqVtwc6u1oGw=;
 b=nEeqMrk6uvG7rmPyXEGMSsIzelMz2dF99i37OZljcuo4oh7xZZoesAk4KrAQMOsWWY
 dTXreQy8BM9DKwR58wY7FRf4V9otbgQ2XYeTYDnHZE5mwrwLwuzImNlHIxOYMJTELfpn
 Oj3mN6jy/gx0BWtD1qG2u+X3A/guxcA70lSFPD9ekQq7rxSFDroFkBkLCEB23lH4+s+Q
 z9csLL3pxzo89k/O1pFjcwy9Wsr5bFBxD1GgMiWnQ4CKwXX9VjrgXroTSSEhWGrFgWCn
 A8/mcR4NzEWuyhlTwVoQ1RUK7TvfpCEUgR7ilK/luqlKNWo5sZacMLWsquJBcfmQt92V
 iirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=95LDy22BpOxyIQvBk6FRPJlH91thVepwqVtwc6u1oGw=;
 b=co1QciLHi0/BlGJXU62e3sF4xr0G0FtN4s51mh2iMfUYdkRepxxZd9V5s81H5gZdQR
 arvngaDmaiXfVMxOc1NO2KWQ8PtBgztuRBqbIBaHqaqYClNwv4Zi0YxaYsHa4hsnP5V0
 GR4eKhKfwgdoxN/OctwZjEW7R1ojzDNgqG3oIRhHbQ8Ka0jx7wvtMh9la407noxt+JYG
 GjJYMrwx6+PmydYPI8HT94R9pBJYoS9Jjlsis/6kHNCgckGT6TNFG2D01lLg9lABSfx4
 p2EqR5GNNVOcCS6xBS6O8lxUfP92ZYIILYmHOwfcDNJ098WDkAGCeJaMrXlkU3cF3T7U
 pFhw==
X-Gm-Message-State: APjAAAWh6PKIVkhPc0oi1lKxM8o4zNwv1+Srafg2/IN7qAAL63wpaF2b
 HmjLsVfMJqer5rT7ZV06oXos29LWOg06
X-Google-Smtp-Source: APXvYqxBjslw8uxUiWz+4Eukc1k6XyGzGLU0KOA8j+kAfZKXNmE12yvV1aiYrnwpHrjkFRt+J4989fLX4IEC
X-Received: by 2002:a65:4c82:: with SMTP id m2mr15138678pgt.432.1581909421205; 
 Sun, 16 Feb 2020 19:17:01 -0800 (PST)
Date: Mon, 17 Feb 2020 11:16:51 +0800
Message-Id: <20200217031653.52345-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org, airlied@linux.ie, daniel@ffwll.ch
Cc: alsa-devel@alsa-project.org, cychiang@google.com, tzungbi@google.com,
 dri-devel@lists.freedesktop.org, ck.hu@mediatek.com,
 linux-mediatek@lists.infradead.org, p.zabel@pengutronix.de,
 matthias.bgg@gmail.com, dgreid@google.com,
 linux-arm-kernel@lists.infradead.org
Subject: [alsa-devel] [PATCH v2 0/2] ASoC hdmi-codec: fix HDMI jack reporting
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

With proper unbinding audio components and inserting the HDMI external
display, kernel crashes as the following messages:

Unable to handle kernel NULL pointer dereference at virtual address ...
[snip]
Call trace:
 plugged_cb+0x1c/0x74
 mtk_hdmi_update_plugged_status+0x48/0x6c
 hdmi_conn_detect+0x1c/0x28
 drm_helper_probe_detect+0x110/0x170
 drm_helper_probe_single_connector_modes+0xd4/0x608
 drm_mode_getconnector+0x1e8/0x418

The 1st patch fixes the crash by notifying hdmi-codec's consumers to not
report jack status anymore when component removing.

The 2nd patch fixes race condition in mediatek/mtk_hdmi.c.

Changes from v1:
(https://patchwork.kernel.org/patch/11379979/)
- added the 1st patch
- use mutex to protect plugged_cb and codec_dev in 2nd patch

Tzung-Bi Shih (2):
  ASoC: hdmi-codec: set plugged_cb to NULL when component removing
  drm/mediatek: fix race condition for HDMI jack status reporting

 drivers/gpu/drm/mediatek/mtk_hdmi.c | 11 ++++++++++-
 sound/soc/codecs/hdmi-codec.c       | 10 ++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

-- 
2.25.0.265.gbab2e86ba0-goog

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
