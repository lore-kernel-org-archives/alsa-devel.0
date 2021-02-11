Return-Path: <SRS0=wAKr=HN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A49C433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Feb 2021 05:26:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0163764E26
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Feb 2021 05:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0163764E26
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 25B6C16DB;
	Thu, 11 Feb 2021 06:25:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 25B6C16DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613021194;
	bh=h5qwqZK2v4tdK9nIHKiCW5NmwXEhhYW4EEFSTa3w37o=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gaL0HqqUjmBYc1GocKEuEG2lZR2xw/4nLehWcngWFueGJeigUyMA46VpvywFfWHBi
	 cdJHfADp3O/gZ50ySqulvKHVFzpQb8be/xS2LF2W4Ja0rPXqh/1cj5pSzWAZWK9gxa
	 zRVt3OTGEvM67TN2M7+QiWy2P5WGpD+8wAJrxXjA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A0AACF8016B;
	Thu, 11 Feb 2021 06:25:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 11CE4F80165; Thu, 11 Feb 2021 06:25:42 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5D6A2F80165
 for <alsa-devel@alsa-project.org>; Thu, 11 Feb 2021 06:25:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5D6A2F80165
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="NTsLaUZY"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4930064DE7;
 Thu, 11 Feb 2021 05:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1613021137;
 bh=h5qwqZK2v4tdK9nIHKiCW5NmwXEhhYW4EEFSTa3w37o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NTsLaUZYOyaQYHwdruBO4TeM+4vmqOCBiE3Tv8Y/imJhj2UEbl+IH6u4rUO2xP0no
 9NGidz/UPIPtIu7r1vSIFYjX4SGc1cwSspEfuT09WMLmxnYIsyAY3l3meJgGij69aK
 bkUU7aNq4ylQGwO8kEPZJ+HmvLVJLnBoE/2//zWoSrKfi7n3qSgW9sBXZSerwGG5wj
 S38x4rk8L65h5h1C8o+6oOEsJ/u0RtknlXOM8jjNR9A+cHJqv0dcMDcxa8o7Th9/ci
 /uk3IwK/gswGKoOGW6nDVEbEO9a1SYr0J1Po3AQfNdMKD0mNdTKL1uTp52hhSVAiIJ
 lGbuabZuEZLmg==
Date: Thu, 11 Feb 2021 10:55:33 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [RESEND PATCH v2 0/9] soundwire/regmap: use _no_pm routines
Message-ID: <20210211052533.GI2774@vkoul-mobl.Dlink>
References: <20210122070634.12825-1-yung-chuan.liao@linux.intel.com>
 <20210206102644.GN2656@vkoul-mobl.Dlink>
 <20210208125032.GF8645@sirena.org.uk>
 <20210208150449.GF879029@vkoul-mobl.Dlink>
 <20210210195818.GH4748@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210195818.GH4748@sirena.org.uk>
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
 srinivas.kandagatla@linaro.org, jank@cadence.com, sanyog.r.kale@intel.com,
 Bard Liao <yung-chuan.liao@linux.intel.com>, rander.wang@linux.intel.com,
 bard.liao@intel.com
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

On 10-02-21, 19:58, Mark Brown wrote:
> On Mon, Feb 08, 2021 at 08:34:49PM +0530, Vinod Koul wrote:
> > On 08-02-21, 12:50, Mark Brown wrote:
> 
> > > Is there a tag I can pull the new APIs from?
> 
> > Yes, please pull from below:
> 
> > git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-5.12-rc1
> 
> Ah, that's the entire Soundwire pull request including driver updates -
> that's a bit more than is ideal.  Instead if you want to pull in the
> regmap bits that might be easier:
> 
> Acked-by: Mark Brown <broonie@kernel.org>

Since I had a fix to send to Greg, I am adding these as well..

Thanks
-- 
~Vinod
