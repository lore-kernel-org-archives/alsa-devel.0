Return-Path: <SRS0=t3YC=4K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9923EC35666
	for <alsa-devel@archiver.kernel.org>; Sat, 22 Feb 2020 17:03:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23DE120707
	for <alsa-devel@archiver.kernel.org>; Sat, 22 Feb 2020 17:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Sf4iP0Iw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23DE120707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6191315F8;
	Sat, 22 Feb 2020 18:02:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6191315F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582391015;
	bh=y2bwBvi8dfSiMOlriOPEOKsA3VtSudqksJtJNxl9Cq8=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Sf4iP0IwHsovt7VO4DmG4UjvEr9saSQ/Knk8nmST9lN2CXrcTIVQtBdQn1/iN28SH
	 86QCxRG4qO2q5aG20726pDty0GsVBA3sCCLmqyuNa+zgYrpAWBDXqF68Hx7bEZPLK6
	 i4IArtoweaMQ/Jv26nWp7QCVXVwQLc7A7oFDL+w0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ECD90F8011D;
	Sat, 22 Feb 2020 18:02:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6DFAFF8011D; Sat, 22 Feb 2020 18:02:43 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 06AF8F8011D
 for <alsa-devel@alsa-project.org>; Sat, 22 Feb 2020 18:02:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 06AF8F8011D
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Feb 2020 09:02:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,472,1574150400"; d="scan'208";a="409443870"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
 by orsmga005.jf.intel.com with ESMTP; 22 Feb 2020 09:02:35 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
 (envelope-from <lkp@intel.com>)
 id 1j5YAk-0004N7-QX; Sun, 23 Feb 2020 01:02:34 +0800
Date: Sun, 23 Feb 2020 01:01:46 +0800
From: kbuild test robot <lkp@intel.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [asoc:for-5.7 134/139] sound/soc/meson/aiu-encoder-i2s.c:129:2-3:
 Unneeded semicolon
Message-ID: <202002230135.WpIL6nAs%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 kbuild-all@lists.01.org, Jerome Brunet <jbrunet@baylibre.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7
head:   b38c4a8a0291c31a660cd77761202ebb18332fb7
commit: 3e25c44598aa44134207ad7b3c5ad6b586135777 [134/139] ASoC: meson: aiu: add support for the Meson8 and Meson8b SoC families

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


coccinelle warnings: (new ones prefixed by >>)

>> sound/soc/meson/aiu-encoder-i2s.c:129:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
