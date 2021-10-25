Return-Path: <SRS0=4dkw=PN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63273C433FE
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 19:01:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10CDF6101C
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 19:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 10CDF6101C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A257416C7;
	Mon, 25 Oct 2021 21:00:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A257416C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635188458;
	bh=u4MwtOoYA1+s5iA4ent6Gl/ZgX67Dl/lbdfSb4cos2I=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=n0+b97rod47a0tuZsBEnPK8P0Qgv35bb6EXRDr4mZjthH1OjNsF0kv4QtaUHuKKXW
	 lFbJwQzRGrLN1/ssdBs9+tYHrvY75FSuiXJDDHgU3Q1fyaxHA+d6Ao0YV6MxGg4RMS
	 NTTxS75KCeZtrHEjmrODdu0reJGAwl6SJrZaSUGw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D5605F8027B;
	Mon, 25 Oct 2021 21:00:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 84377F80271; Mon, 25 Oct 2021 21:00:05 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9355BF80086
 for <alsa-devel@alsa-project.org>; Mon, 25 Oct 2021 20:59:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9355BF80086
X-IronPort-AV: E=McAfee;i="6200,9189,10148"; a="216908138"
X-IronPort-AV: E=Sophos;i="5.87,181,1631602800"; d="scan'208";a="216908138"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2021 11:59:53 -0700
X-IronPort-AV: E=Sophos;i="5.87,181,1631602800"; d="scan'208";a="554318446"
Received: from ssubbar1-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.118.197])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2021 11:59:53 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/8] ASoC: minor cleanup of warnings
Date: Mon, 25 Oct 2021 13:59:25 -0500
Message-Id: <20211025185933.144327-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

Sparse, make W=1 and cppcheck all report minor warnings.

The only functional change is in patch7 where the error code is now
returned to the caller.

Pierre-Louis Bossart (8):
  ASoC: topology: handle endianness warning
  ASoC: rt5682s: use 'static' qualifier
  ASoC: nau8821: fix kernel-doc
  ASoC: nau8821: clarify out-of-bounds check
  ASoC: mediatek: remove unnecessary initialization
  ASoC: mediatek: mt8195: rename shadowed array
  ASoC: mediatek: mt8195: fix return value
  ASoC: rockchip: i2s_tdm: improve return value handling

 sound/soc/codecs/nau8821.c                  | 6 ++++--
 sound/soc/codecs/rt5682s.c                  | 6 +++---
 sound/soc/mediatek/common/mtk-afe-fe-dai.c  | 2 +-
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c  | 4 ++--
 sound/soc/mediatek/mt8195/mt8195-dai-etdm.c | 2 +-
 sound/soc/rockchip/rockchip_i2s_tdm.c       | 2 +-
 sound/soc/soc-topology.c                    | 2 +-
 7 files changed, 13 insertions(+), 11 deletions(-)

-- 
2.25.1

