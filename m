Return-Path: <SRS0=w4sP=X2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3356C352AA
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:57:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BA75215EA
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="C6GD04NK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA75215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A22BA167E;
	Tue,  1 Oct 2019 19:56:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A22BA167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569952660;
	bh=/gcT1HY2dXc7viZv0SfKzroKifY1KNwMo58eLjRtpbA=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C6GD04NK3oNG/5ziGcOurehjRyleMrSdIJ+AHyyrqTJk8gKUe2gmhnMxbIEo14QQf
	 19ca6K+cpscm/G9YkVrroMSV5JEmw7+NgmGtesm+SY/K8bOoM3KZYmVxmv9T8+gkkT
	 /e+dgImiSqlN6/fL5BlJqeFaHEvG/UBk8rC8Ir6k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ED973F805FB;
	Tue,  1 Oct 2019 19:55:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A8179F805FC; Tue,  1 Oct 2019 19:55:21 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9541DF80482
 for <alsa-devel@alsa-project.org>; Tue,  1 Oct 2019 19:55:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9541DF80482
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Oct 2019 10:55:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; d="scan'208";a="191527474"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
 by fmsmga007.fm.intel.com with ESMTP; 01 Oct 2019 10:55:13 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
 (envelope-from <lkp@intel.com>)
 id 1iFMMj-0007wQ-6G; Wed, 02 Oct 2019 01:55:13 +0800
Date: Wed, 2 Oct 2019 01:55:04 +0800
From: kbuild test robot <lkp@intel.com>
To: Frank Shi <shifu0704@thundersoft.com>
Message-ID: <20191001175504.ufhyxh66psrht42k@332d0cec05f4>
References: <201910020148.MBUfA91l%lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201910020148.MBUfA91l%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Mark Brown <broonie@kernel.org>, kbuild-all@01.org
Subject: [alsa-devel] [PATCH] tas2770: fix platform_no_drv_owner.cocci
	warnings
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

From: kbuild test robot <lkp@intel.com>

sound/soc/codecs/tas2770.c:796:3-8: No need to set .owner here. The core will do it.

 Remove .owner field if calls are used which set it automatically

Generated by: scripts/coccinelle/api/platform_no_drv_owner.cocci

Fixes: 1a476abc723e ("tas2770: add tas2770 smart PA kernel driver")
CC: Frank Shi <shifu0704@thundersoft.com>
Signed-off-by: kbuild test robot <lkp@intel.com>
---

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5
head:   1a476abc723e644248dba975b71122fcf878703b
commit: 1a476abc723e644248dba975b71122fcf878703b [32/32] tas2770: add tas2770 smart PA kernel driver

 tas2770.c |    1 -
 1 file changed, 1 deletion(-)

--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -793,7 +793,6 @@ MODULE_DEVICE_TABLE(of, tas2770_of_match
 static struct i2c_driver tas2770_i2c_driver = {
 	.driver = {
 		.name   = "tas2770",
-		.owner  = THIS_MODULE,
 		.of_match_table = of_match_ptr(tas2770_of_match),
 	},
 	.probe      = tas2770_i2c_probe,
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
