Return-Path: <SRS0=8UIF=YD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29DFC4360C
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Oct 2019 16:43:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC1E320B7C
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Oct 2019 16:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DBx0v7Sc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1E320B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9C2E71614;
	Thu, 10 Oct 2019 18:42:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9C2E71614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570725788;
	bh=m6henfC1YK5jADMyL8T3P3AlTWgjD6REEou1Badyutw=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DBx0v7Sc/WDio65hHJ25kUHyHF0qiwVzJyRm7ha1af5ZE3EKEFcq4hy+g+837nKA8
	 JINOy8DTVNcZPl+asFZTgEzSI0cYrowt/eqoQjUUNcurjBYv64QB7fpNAb+432/p8T
	 VuXyeGXUdX5YxoE3KvwQvwWsa8BT97WE6cXhS+fw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 148FDF80322;
	Thu, 10 Oct 2019 18:42:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BBAE5F8038F; Thu, 10 Oct 2019 18:42:15 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 80483F800E3
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2019 18:42:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 80483F800E3
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Oct 2019 09:42:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,280,1566889200"; d="scan'208";a="207224648"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
 by fmsmga001.fm.intel.com with ESMTP; 10 Oct 2019 09:42:06 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
 (envelope-from <lkp@intel.com>)
 id 1iIbVu-0007Cm-Ea; Fri, 11 Oct 2019 00:42:06 +0800
Date: Fri, 11 Oct 2019 00:41:19 +0800
From: kbuild test robot <lkp@intel.com>
To: Dan Murphy <dmurphy@ti.com>
Message-ID: <201910110016.g5AIyc2E%lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 kbuild-all@01.org
Subject: [alsa-devel] [asoc:for-5.5 122/122]
 sound/soc/codecs/tas2562.c:195:14: sparse: sparse: restricted
 snd_pcm_format_t degrades to integer
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
head:   c173dba44c2d2ec2adaa4e607e9729b74236bd57
commit: c173dba44c2d2ec2adaa4e607e9729b74236bd57 [122/122] ASoC: tas2562: Introduce the TAS2562 amplifier
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-42-g38eda53-dirty
        git checkout c173dba44c2d2ec2adaa4e607e9729b74236bd57
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> sound/soc/codecs/tas2562.c:195:14: sparse: sparse: restricted snd_pcm_format_t degrades to integer
   sound/soc/codecs/tas2562.c:202:14: sparse: sparse: restricted snd_pcm_format_t degrades to integer
   sound/soc/codecs/tas2562.c:209:14: sparse: sparse: restricted snd_pcm_format_t degrades to integer
>> sound/soc/codecs/tas2562.c:246:58: sparse: sparse: incorrect type in argument 2 (different base types) @@    expected int bitwidth @@    got restricted snd_pcm_formint bitwidth @@
>> sound/soc/codecs/tas2562.c:246:58: sparse:    expected int bitwidth
>> sound/soc/codecs/tas2562.c:246:58: sparse:    got restricted snd_pcm_format_t
   sound/soc/codecs/tas2562.c:472:39: sparse: sparse: restricted snd_pcm_format_t degrades to integer

vim +195 sound/soc/codecs/tas2562.c

   189	
   190	static int tas2562_set_bitwidth(struct tas2562_data *tas2562, int bitwidth)
   191	{
   192		int ret;
   193	
   194		switch (bitwidth) {
 > 195		case SNDRV_PCM_FORMAT_S16_LE:
   196			snd_soc_component_update_bits(tas2562->component,
   197						      TAS2562_TDM_CFG2,
   198						      TAS2562_TDM_CFG2_RXWLEN_MASK,
   199						      TAS2562_TDM_CFG2_RXWLEN_16B);
   200			tas2562->v_sense_slot = tas2562->i_sense_slot + 2;
   201			break;
   202		case SNDRV_PCM_FORMAT_S24_LE:
   203			snd_soc_component_update_bits(tas2562->component,
   204						      TAS2562_TDM_CFG2,
   205						      TAS2562_TDM_CFG2_RXWLEN_MASK,
   206						      TAS2562_TDM_CFG2_RXWLEN_24B);
   207			tas2562->v_sense_slot = tas2562->i_sense_slot + 4;
   208			break;
   209		case SNDRV_PCM_FORMAT_S32_LE:
   210			snd_soc_component_update_bits(tas2562->component,
   211						      TAS2562_TDM_CFG2,
   212						      TAS2562_TDM_CFG2_RXWLEN_MASK,
   213						      TAS2562_TDM_CFG2_RXWLEN_32B);
   214			tas2562->v_sense_slot = tas2562->i_sense_slot + 4;
   215			break;
   216	
   217		default:
   218			dev_info(tas2562->dev, "Not supported params format\n");
   219		}
   220	
   221		ret = snd_soc_component_update_bits(tas2562->component,
   222			TAS2562_TDM_CFG5,
   223			TAS2562_TDM_CFG5_VSNS_EN | TAS2562_TDM_CFG5_VSNS_SLOT_MASK,
   224			TAS2562_TDM_CFG5_VSNS_EN | tas2562->v_sense_slot);
   225		if (ret < 0)
   226			return ret;
   227	
   228		ret = snd_soc_component_update_bits(tas2562->component,
   229			TAS2562_TDM_CFG6,
   230			TAS2562_TDM_CFG6_ISNS_EN | TAS2562_TDM_CFG6_ISNS_SLOT_MASK,
   231			TAS2562_TDM_CFG6_ISNS_EN | tas2562->i_sense_slot);
   232		if (ret < 0)
   233			return ret;
   234	
   235		return 0;
   236	}
   237	
   238	static int tas2562_hw_params(struct snd_pcm_substream *substream,
   239				     struct snd_pcm_hw_params *params,
   240				     struct snd_soc_dai *dai)
   241	{
   242		struct snd_soc_component *component = dai->component;
   243		struct tas2562_data *tas2562 = snd_soc_component_get_drvdata(component);
   244		int ret;
   245	
 > 246		ret = tas2562_set_bitwidth(tas2562, params_format(params));
   247		if (ret) {
   248			dev_err(tas2562->dev, "set bitwidth failed, %d\n", ret);
   249			return ret;
   250		}
   251	
   252		ret = tas2562_set_samplerate(tas2562, params_rate(params));
   253		if (ret)
   254			dev_err(tas2562->dev, "set bitwidth failed, %d\n", ret);
   255	
   256		return ret;
   257	}
   258	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
