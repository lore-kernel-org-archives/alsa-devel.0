Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11162C4332F
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Nov 2022 02:15:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 42FD11651;
	Fri, 11 Nov 2022 03:14:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 42FD11651
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668132944;
	bh=7xegAUbZpkrU7W44Zn4R5tO1p9I94hcYLtcpaHdKlHc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SO15Au9fRu6OZAVgnaMA7xN1Sdz/UiPjIk69EcBbISW1davJYHszS7SHLQzF95X0A
	 fo3gd2dtjVZ9LTKCOrevY4XkSil7HuGtkAEiY3Tf30l3oyGorPVx6++xHikjd29PaW
	 5+FA7EUxKEhVNR5pptJfziTKmgi6Sbz+tGKF9WPA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D722BF802E8;
	Fri, 11 Nov 2022 03:14:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2E703F802E8; Fri, 11 Nov 2022 03:14:53 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EDAEEF80104
 for <alsa-devel@alsa-project.org>; Fri, 11 Nov 2022 03:14:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EDAEEF80104
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="cntCfhcD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1668132890; x=1699668890;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=7xegAUbZpkrU7W44Zn4R5tO1p9I94hcYLtcpaHdKlHc=;
 b=cntCfhcDqet86OxNyFylEGK6QtktF0FgdT2MEIqQMjnDFgOeOKA4HlEF
 6MmRb6QwwEdH3vOjRF5OgWjPZGDLW85x1o9IdAG1r9HTX/6uNmPNm6lw/
 fopD+0uEdX1EJlKRkn+sQR7e9TPWax7Iz0f++TDh4MzOQ60t7hQkGAyzZ
 p7UYbUQ1YcfHNTTZpWZiXbSf8HT0ijql6xdnIwxAj48M7k9REriGQByD+
 w4gw1PBIK3gK2v4KBpVqEoQSUPljPuz1WXkeovtt6QSD037WnfGSXWA/w
 rLQOEz5XWc9DSWmjnzFt8knyPpKgxL4zPlKfX1K9Oy0XH53Jtr/Rd6UqQ g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="291904402"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; d="scan'208";a="291904402"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2022 18:14:44 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="615335544"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; d="scan'208";a="615335544"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2022 18:14:42 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 0/2] soundwire: revisit support for clock registers
Date: Fri, 11 Nov 2022 10:16:31 +0800
Message-Id: <20221111021633.39908-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org,
 bard.liao@intel.com, linux-kernel@vger.kernel.org
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

SoundWire clock base and scale registers are only supported for SDCA
devices. That's fine, but that leaves SoundWire 1.2 with optional
registers not supported. This is a corner case that needs to be supported.

Pierre-Louis Bossart (2):
  soundwire: remove is_sdca boolean property
  soundwire: enable optional clock registers for SoundWire 1.2 devices

 drivers/soundwire/bus.c           | 11 ++++++-----
 include/linux/soundwire/sdw.h     |  6 ++++--
 sound/soc/codecs/rt1316-sdw.c     |  1 -
 sound/soc/codecs/rt711-sdca-sdw.c |  1 -
 4 files changed, 10 insertions(+), 9 deletions(-)

-- 
2.25.1

