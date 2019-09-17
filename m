Return-Path: <SRS0=kA1C=XM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB75C4CEC9
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Sep 2019 11:33:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A33621881
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Sep 2019 11:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oE6Omyxl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A33621881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CB51E84B;
	Tue, 17 Sep 2019 13:32:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CB51E84B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568719986;
	bh=LUqd0cMtGmkoQe4Jha7gTYWVXG/yJVkEDSNkc7rTTag=;
	h=Date:From:To:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oE6OmyxlDMpoZWp+nq1l9Uuf3KsfpoM8U5hfGMa9uIbi3sZWDPO9HnYyXgBYEn3YB
	 6MQA9/vTVynI1gklRFz9unkIgEboaLIlRiQodlOqUO5OAAj9icJecPHY2LWoJLPsiM
	 KZ70svwCz9v+fqNfDZKhEE3XZLzgCX3ir7A2tuOM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 32863F80307;
	Tue, 17 Sep 2019 13:32:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 61D64F80361; Tue, 17 Sep 2019 13:32:13 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E6F1EF80146
 for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2019 13:32:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E6F1EF80146
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Sep 2019 04:32:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,516,1559545200"; d="scan'208";a="180744093"
Received: from zeliteleevi.tm.intel.com ([10.237.55.130])
 by orsmga008.jf.intel.com with ESMTP; 17 Sep 2019 04:32:04 -0700
Date: Tue, 17 Sep 2019 14:32:03 +0300 (EEST)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@zeliteleevi
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <5579b62d-d949-ec62-0a85-45d0842af38f@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1909171415520.16459@zeliteleevi>
References: <20190912142200.8031-1-kai.vehmanen@linux.intel.com>
 <5579b62d-d949-ec62-0a85-45d0842af38f@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH v4 0/9] adapt SOF to use snd-hda-codec-hdmi
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

Hi,

On Mon, 16 Sep 2019, Pierre-Louis Bossart wrote:

> The series looks good to me so
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

thank you Pierre and Takashi for the reviews!

> I would recommend that we have a matching change for the Skylake driver and
> validation that both SOF and cAVS/SST drivers can operate with this mode set.
> Our goal is still to have coexistence between the two drivers in a single
> build/distro, e.g. cAVS for SKL/KBL/APL and SOF for newer platforms. This can
> be done in a follow-up patch but it needs to be done before distros start
> selecting this common HDMI mode.

The current patchset actually does allow that. You can select the common 
HDMI codec in kernel config, build both SOF and SST drivers and based on
runtime selection of the platform, either SOF with patch_hdmi.c will be 
used or SST with hdac-hdmi. This is achieved by setting the 
common-hdmi-codec mach-params flag in sof/intel/hda.c, so with SST 
drivers, this will never be set.

To change SST to use patch_hdmi.c as well, is a bigger effort. There 
are more (and much older) platforms impacted by the alsa mixer name 
changes. I'm not sure whether this is worth the trouble. But open to 
ideas here.

Br, Kai
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
