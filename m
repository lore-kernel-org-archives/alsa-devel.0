Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BAACCA47B
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jun 2022 16:37:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A972F17DC;
	Fri, 10 Jun 2022 18:36:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A972F17DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654879067;
	bh=8q5yMTIXOZ7mG0+/Uh9dptn1Eld7c9q8vQLWMVlD6Bc=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XC17jClDCx4pC3GSy+WTfTvRaPcUZoni1JlpZQOje3IXm3Ah19/NY8SG3P71+fV+s
	 Ijrlvpj4UM4gZvVi5NlDTfBZPuBdv1awZwbmxzM76P5JIdJ1TBHstfplzEJMfCBa+Z
	 oazxx6LgMzr4DAWzWWEiKSeZqF2PdKcQnn5q+baQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2BBFEF800E5;
	Fri, 10 Jun 2022 18:36:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9222FF800DF; Fri, 10 Jun 2022 18:36:55 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1367EF800DF
 for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2022 18:36:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1367EF800DF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="FAuxKpc/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654879013; x=1686415013;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=8q5yMTIXOZ7mG0+/Uh9dptn1Eld7c9q8vQLWMVlD6Bc=;
 b=FAuxKpc/5XJrVli6bFc2bpvne0LhZXTJFE4bQ/Vcj20+8fiBggcHgjpI
 gYh5yNSAPLBbJRZOApCdCVEXAX1Vo69nriW7BJFq/EF9x2dkH7bvYbJd7
 e30WyQuYwYrNZYvIR36RSYoerZF56WWBOkjmEs0clBEz9eQd8fFN+sqi/
 oIBSOgd3It6Ka8/ls2R+tEQkQzA6ZmZenS9umMmF/lKwOIFwgtlbp0o9b
 ct+oPNHasU2dJhbSlFXYTlzA65j4YHkIh8MoKW4rg9qRb6ElBzohvrmlw
 GIV6aXdKcQOzMeE0kfNn81vrpoJyEDRTLxeXuX5pgHjUSkknpMwjsJKSB g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="303054960"
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; d="scan'208";a="303054960"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2022 09:36:45 -0700
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; d="scan'208";a="725032952"
Received: from pljackso-mobl.amr.corp.intel.com (HELO [10.213.190.122])
 ([10.213.190.122])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2022 09:36:44 -0700
Message-ID: <0c493f72-de7f-4c57-f1d5-47f982abc3c8@linux.intel.com>
Date: Fri, 10 Jun 2022 09:53:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] soundwire: Intel: add trigger callback
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
References: <20220610023537.27223-1-yung-chuan.liao@linux.intel.com>
 <20220610023537.27223-3-yung-chuan.liao@linux.intel.com>
 <YqLV7qexsdhCI7ZZ@kroah.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <YqLV7qexsdhCI7ZZ@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, vinod.koul@linaro.org, tiwai@suse.de,
 linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, sanyog.r.kale@intel.com, bard.liao@intel.com
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


> Where is the in-kernel user of this new callback?  Without that, there
> is no need for this, NOR is there a way to properly review this commit.
> 
> sorry,

ASoC/SOF will be the user, this is a dependency before Mark Brown can
take additional code in his tree. It was spelled out in the cover letter.

To be clearer, the ONLY user of all the soundwire:intel code is
precisely the ASoC/SOF driver.

