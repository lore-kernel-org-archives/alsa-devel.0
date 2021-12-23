Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E259C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Dec 2021 05:21:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 20B3D1752;
	Thu, 23 Dec 2021 06:20:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 20B3D1752
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1640236859;
	bh=7zJHmCoxTHJyGHd+FsDCG+BUarl2qNlDg2wAXE0J1/I=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SZPHN2pDbripuYrHVmV2nEyL+CmtLvq9Ct1j3dyUIK1UpN0grIHg7fgxZ4+maR5Vh
	 mKPjdyWAU1X58G3okjAIhb5CUx+8P0Bvgp09uUBIdwXA2iFdU+iUuQqXg71GToeajB
	 K2K3KBBbaKn2GT55G42rsB7ecmOLgsp70y8pcRnU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 83E48F800AF;
	Thu, 23 Dec 2021 06:20:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 52460F80105; Thu, 23 Dec 2021 06:20:05 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 57815F800AF
 for <alsa-devel@alsa-project.org>; Thu, 23 Dec 2021 06:19:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 57815F800AF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="CuLuhtzo"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 26C85B81F79;
 Thu, 23 Dec 2021 05:19:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BB0C36AE9;
 Thu, 23 Dec 2021 05:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640236789;
 bh=7zJHmCoxTHJyGHd+FsDCG+BUarl2qNlDg2wAXE0J1/I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CuLuhtzoG+n0sPa/rQnBXLgsb4KwfJS8oNo3hce821FZDpb3XShWu0AghSyk9Qjia
 qs+HNtqZe5sTVBmUJIe9je4kpSsfFs/1h8D2JCmKe8WQXhNsXQbGajOLi3hqOnr4Ze
 RUPOzq5+3JWzyqf4PGSym1eHyMVDmmc9LFZMpXIPT0zbo/fxNwaMmn/loM3nkA3eCu
 oP/0oAa8O6CYziRpUud/VQo2/1AQvX6gRp+ui+44hfsUYDiX6CUSLZMkeOADTYZ9uz
 KGmKEjAvS7HteFaM4yjNvuENORD0tFbG7b4HfAgm1Idy14KT7wyZkTyjchdSCb6PPi
 mgvIVclW2P5pg==
Date: Thu, 23 Dec 2021 10:49:44 +0530
From: Vinod Koul <vkoul@kernel.org>
To: "Liao, Bard" <bard.liao@intel.com>
Subject: Re: [PATCH 0/7] ASoC/SoundWire: improve suspend flows and use
 set_stream() instead of set_tdm_slots() for HDAudio
Message-ID: <YcQG8EjC5J+5721e@matsya>
References: <20211213054634.30088-1-yung-chuan.liao@linux.intel.com>
 <YcIYT57YLpHR1+9A@sirena.org.uk>
 <DM6PR11MB40741309EE8E5A7977210EC5FF7D9@DM6PR11MB4074.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB40741309EE8E5A7977210EC5FF7D9@DM6PR11MB4074.namprd11.prod.outlook.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "tiwai@suse.de" <tiwai@suse.de>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>,
 Mark Brown <broonie@kernel.org>,
 "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>, "Kale,
 Sanyog R" <sanyog.r.kale@intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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

On 22-12-21, 13:47, Liao, Bard wrote:
> > -----Original Message-----
> > From: Mark Brown <broonie@kernel.org>
> > Sent: Wednesday, December 22, 2021 2:09 AM
> > To: Bard Liao <yung-chuan.liao@linux.intel.com>
> > Cc: alsa-devel@alsa-project.org; vkoul@kernel.org; vinod.koul@linaro.org;
> > linux-kernel@vger.kernel.org; tiwai@suse.de; gregkh@linuxfoundation.org;
> > srinivas.kandagatla@linaro.org; pierre-louis.bossart@linux.intel.com; Kale,
> > Sanyog R <sanyog.r.kale@intel.com>; Liao, Bard <bard.liao@intel.com>
> > Subject: Re: [PATCH 0/7] ASoC/SoundWire: improve suspend flows and use
> > set_stream() instead of set_tdm_slots() for HDAudio
> > 
> > On Mon, Dec 13, 2021 at 01:46:27PM +0800, Bard Liao wrote:
> > 
> > > The topics are independent but the changes are dependent. So please
> > > allow me to send them in one series.
> > 
> > What's the plan for getting these merged?  Looks like they're mainly
> > ASoC changes?
> 
> Yes, maybe Vinod can ack and these patches can go through ASoC tree.

I didnt have this series :( and on checking found that gmail tagged
these and bunch of other alsa patches as spam, even my linaro email
seems to have been unsubscribed due to bounces...

Not sure what is going on, will check the patches now...

-- 
~Vinod
