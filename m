Return-Path: <SRS0=PUtL=XN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23BBC4CEC9
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Sep 2019 08:26:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2E6720578
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Sep 2019 08:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nL+zZVPE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QjtMNatK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E6720578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A27D0166D;
	Wed, 18 Sep 2019 10:25:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A27D0166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568795171;
	bh=qpSE9diFANQ4NsMIbz2z8CVoRNMS+/hCE0q9TE6cBMU=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nL+zZVPEveA9Bx3M8faE7hyzzXNYX3r7QbKj0UUNDKSOyQvwXVxPvrIPAvgOYAxpG
	 bmO4JlGcUnQ2hvMRi0vCuorsDjqzgxdqg3J+sjOR9JPfxMmESn2PBxXRvGI1Usy7Z/
	 A66q4DhYZygOLtRyG4ihi/T70il/mfd/0Ob1vlKk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1A735F804FF;
	Wed, 18 Sep 2019 10:25:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CAFC2F80506; Wed, 18 Sep 2019 10:25:19 +0200 (CEST)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 49B0BF800C1
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2019 10:25:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 49B0BF800C1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="QjtMNatK"
Received: by mail-pl1-x644.google.com with SMTP id d3so2782336plr.1
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2019 01:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VKl0NI5uuTzXRMlZIfLK2DJ9dA76CcXi+wvYjjhfeJ4=;
 b=QjtMNatKQcwth+X0GKHkr+Z2zJz6zbi9oKCgR26mEnXpfoUjWiImm9bASZSwNJTdA7
 2sYwbfAxoZKJIti+khkPv+rHKQ/aqRnzVaaVyCAV9sxHcFnNpVTLVkNumDYo8RwYrBU6
 qQ5EfggIIMUwE/rxyvwKGoh69y/Hl9FmhmtWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VKl0NI5uuTzXRMlZIfLK2DJ9dA76CcXi+wvYjjhfeJ4=;
 b=UlAS6I7ktEe00nSz7YnrkADBs+ZxZ2UREqVZNhifRjT45cK8hUufsrDv+0yDjZHI8x
 cIVd3HcH9+2VAKnbOvLwMikzrSgPZ5FcBXeFypkVq2te0cCGL7BXfow/Re92w7At8QLo
 cjFhodzQIm9l1KoUhTfPCq5dnWcZetSBO6Emga9c4+pR/3agHnE1D9LuOgnvAFUgJAdJ
 4QMq85DDpD4yazxWzx3CayNiB9Q9vfyUG9CMaDxSn/h5B78ywhNvrANCuS1ziOC2j3/6
 uPa7g2RmG4Ppc6Lr1scxxXvmLVyr0HajgA09yVYs10ci4IZ8HgIp4CSobK/x62hJf/Pg
 3DmQ==
X-Gm-Message-State: APjAAAUA5Co1UtPdGVnj/wIGX4Kl8eTL/EyT0SBahXqa2f/HgxS7NNxf
 LHV3/Z6alkLt0BFuBckiOdtCSw==
X-Google-Smtp-Source: APXvYqzayEko5q8A495MmFMU31IxcUPuZcsYT8Q3ERIy5jSSRpRvbSnJkE1FFghYilaSJdpwBGfTCA==
X-Received: by 2002:a17:902:ba95:: with SMTP id
 k21mr3061713pls.80.1568795114731; 
 Wed, 18 Sep 2019 01:25:14 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:79b4:bd83:e4a5:a720])
 by smtp.gmail.com with ESMTPSA id y28sm8689470pfq.48.2019.09.18.01.25.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Sep 2019 01:25:13 -0700 (PDT)
From: Cheng-Yi Chiang <cychiang@chromium.org>
To: linux-kernel@vger.kernel.org
Date: Wed, 18 Sep 2019 16:24:56 +0800
Message-Id: <20190918082500.209281-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>,
 Neil Armstrong <narmstrong@baylibre.com>, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, Liam Girdwood <lgirdwood@gmail.com>,
 Hans Verkuil <hverkuil@xs4all.nl>, Andrzej Hajda <a.hajda@samsung.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Takashi Iwai <tiwai@suse.com>,
 linux-rockchip@lists.infradead.org, dgreid@chromium.org,
 Cheng-Yi Chiang <cychiang@chromium.org>, tzungbi@chromium.org,
 Jonas Karlman <jonas@kwiboo.se>, Russell King <rmk+kernel@armlinux.org.uk>,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Jernej Skrabec <jernej.skrabec@siol.net>, dianders@chromium.org,
 Daniel Vetter <daniel@ffwll.ch>
Subject: [alsa-devel] [PATCH v6 0/4] Add HDMI jack support on RK3288
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

This patch series supports HDMI jack reporting on RK3288, which uses
DRM dw-hdmi driver and hdmi-codec codec driver.

The previous discussion about reporting jack status using hdmi-notifier
and drm_audio_component is at

https://lore.kernel.org/patchwork/patch/1083027/

The new approach is to use a callback mechanism that is
specific to hdmi-codec.

The dependent change on hdmi-codec.c

https://patchwork.kernel.org/patch/11047447

has been picked up by Mark Brown in ASoC tree for-5.4 branch.

Changes from v5 to v6:

1. Remove the patch for sound/soc/codecs/hdmi-codec.c because it is accepted.
2. Rebase the rest of patches based on drm-misc-next tree.

Cheng-Yi Chiang (4):
  drm: bridge: dw-hdmi: Report connector status using callback
  drm: dw-hdmi-i2s: Use fixed id for codec device
  ASoC: rockchip_max98090: Add dai_link for HDMI
  ASoC: rockchip_max98090: Add HDMI jack support

 .../drm/bridge/synopsys/dw-hdmi-i2s-audio.c   |  13 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     |  41 ++++++-
 include/drm/bridge/dw_hdmi.h                  |   4 +
 sound/soc/rockchip/Kconfig                    |   3 +-
 sound/soc/rockchip/rk3288_hdmi_analog.c       |   3 +-
 sound/soc/rockchip/rockchip_max98090.c        | 116 ++++++++++++++----
 6 files changed, 153 insertions(+), 27 deletions(-)

-- 
2.23.0.237.gc6a4ce50a0-goog

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
