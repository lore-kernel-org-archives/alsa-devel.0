Return-Path: <SRS0=DG6G=YR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D583CA9EB9
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Oct 2019 01:09:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F05120856
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Oct 2019 01:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qyxWrDSl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F05120856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EF878950;
	Thu, 24 Oct 2019 03:08:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EF878950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571879373;
	bh=PptuIT/bPAT+I4k6yWeqn1+aCSjWHL5/tQ2Kbd9TmH4=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qyxWrDSlMjJccM6nMuvVTpc55CCJOdYBFO+EbJ+/h2xbiAK4y31RdEgAzTfY+OU8z
	 MZKWaMKeSCO4zlnmBnGTy/rBafdN2CyjVls/uTpkWgjEBmFDhyQKVKRNeI6n8G3Dwz
	 Z+7dtic5Of84YYlEwutNj7VEmGSlX5XbU2OuO+8c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7B026F80321;
	Thu, 24 Oct 2019 03:08:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C1054F80368; Thu, 24 Oct 2019 03:08:40 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 333C2F80112
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2019 03:08:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 333C2F80112
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Oct 2019 18:08:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,222,1569308400"; d="scan'208";a="210212306"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
 by orsmga002.jf.intel.com with ESMTP; 23 Oct 2019 18:08:30 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
 (envelope-from <lkp@intel.com>)
 id 1iNRc6-0007qF-BD; Thu, 24 Oct 2019 09:08:30 +0800
Date: Thu, 24 Oct 2019 09:07:33 +0800
From: kbuild test robot <lkp@intel.com>
To: Ben Zhang <benzh@chromium.org>
Message-ID: <201910240927.cIw8uUAi%lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 kbuild-all@lists.01.org, Curtis Malainey <cujomalainey@chromium.org>
Subject: [alsa-devel] [asoc:for-5.5 160/172]
 sound/soc/codecs/rt5677-spi.c:148:33: sparse: sparse: Using plain integer
 as NULL pointer
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5
head:   175fc928198236037174e5c5c066fe3c4691903e
commit: a0e0d135427cf699fe2dee77da0924e0b47f3170 [160/172] ASoC: rt5677: Add a PCM device for streaming hotword via SPI
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-dirty
        git checkout a0e0d135427cf699fe2dee77da0924e0b47f3170
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> sound/soc/codecs/rt5677-spi.c:148:33: sparse: sparse: Using plain integer as NULL pointer
>> sound/soc/codecs/rt5677-spi.c:365:13: sparse: sparse: symbol 'rt5677_spi_pcm_page' was not declared. Should it be static?

vim +148 sound/soc/codecs/rt5677-spi.c

   139	
   140	static int rt5677_spi_hw_free(
   141			struct snd_soc_component *component,
   142			struct snd_pcm_substream *substream)
   143	{
   144		struct rt5677_dsp *rt5677_dsp =
   145				snd_soc_component_get_drvdata(component);
   146	
   147		mutex_lock(&rt5677_dsp->dma_lock);
 > 148		rt5677_dsp->substream = 0;
   149		mutex_unlock(&rt5677_dsp->dma_lock);
   150	
   151		return snd_pcm_lib_free_vmalloc_buffer(substream);
   152	}
   153	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
