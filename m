Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA20C32774
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Aug 2022 18:44:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 126DB839;
	Mon, 22 Aug 2022 20:43:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 126DB839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661193839;
	bh=Kbss1+JFwLtb0GEmgL7j9Rfb2dyxymy/4juddSkwcoE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QJgThp5Tl0AgXM4EpX7dLcyD7Sr+955ieC/PX1FGv6OnGvQ/OSjr30SjelZffEyIa
	 6JvEIuGV/r1kRrY36/Ltp4QSxei+hRZ2tU/hdwgxz4KfC5zu8/e7I4Qy3AgFx1Tc2w
	 ao/5dVChoAV6rMF1A5F+fboPVDNlzfXZAnNbVhjo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A77EAF80154;
	Mon, 22 Aug 2022 20:43:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E7178F8026A; Mon, 22 Aug 2022 20:43:06 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D9EE5F80152
 for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2022 20:43:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D9EE5F80152
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="Sp0mPdY+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1661193784; x=1692729784;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Kbss1+JFwLtb0GEmgL7j9Rfb2dyxymy/4juddSkwcoE=;
 b=Sp0mPdY+YMUlBkaqfZQKY0DDuHEn7u2Ty6j+Rf1UlHejhwUYL8IRz8fN
 ADplwE5/HbSj9sE2mtAczxchJFtUywXQRwqP730ByUg+PHE+vdDa/U2yG
 rzM0xuiRBTORbnm4irTjRWc79WMgoacMNP7wkqJgrUVfs9FTiL2PKAh3y
 WUFWOO1ZiNTSULwEiIBYphBxOV7g28Tz1AK7SjKgHqgWHAXBvPwCgKmHX
 ZYS/2vNxEB2/LaGysfg6LYOiS8byiCkxAPH7DdoQ9quMreIr73nUPmlHv
 0w7sPftyrswnQ1SP5Yqi3oFx+oV+HjANG9/rZlHuwzREyHom8z14VpMsL Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="293488936"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; d="scan'208";a="293488936"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2022 11:43:00 -0700
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; d="scan'208";a="669671017"
Received: from apascali-mobl2.ger.corp.intel.com (HELO pbossart-mobl3.home)
 ([10.252.42.21])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2022 11:42:59 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/5] ASoC: codecs: minor cppcheck cleanups
Date: Mon, 22 Aug 2022 20:42:34 +0200
Message-Id: <20220822184239.169757-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
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

Small number of cleanups that were either missed in previous versions
or detected by new cppcheck version.

Pierre-Louis Bossart (5):
  ASoC: hdmi-codec: remove unused definitions
  ASoC: wcd-mbhc-v2: remove always-true condition
  ASoC: wcd9335: remove always-true condition
  ASoC: fsl: fsl-utils: remove useless assignment
  ASoC: ti: omap-mcbsp: remove useless assignment

 sound/soc/codecs/hdmi-codec.c  | 4 ----
 sound/soc/codecs/wcd-mbhc-v2.c | 2 +-
 sound/soc/codecs/wcd9335.c     | 4 +---
 sound/soc/fsl/fsl_utils.c      | 2 +-
 sound/soc/ti/omap-mcbsp.c      | 2 +-
 5 files changed, 4 insertions(+), 10 deletions(-)

-- 
2.34.1

