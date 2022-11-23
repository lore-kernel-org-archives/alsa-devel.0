Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D0CC433FE
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Nov 2022 14:53:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4438F1686;
	Wed, 23 Nov 2022 15:52:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4438F1686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669215217;
	bh=4+w/qhSkQClDEWpGCuK5vMgYnSvhUvQxBjmnRyx0UDs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pdz9nvHxuZbt5zYhPmKOGq5J32IaIrOsAq0SaJ/uubcaY3HO/ZaVjVTov1ayKBgna
	 wv6hXRVG/bnWFk7zUyOreq126XrE4TgmsNPnADrGN0IMVlxs4t/9UZWiuxkQGEyEnS
	 x3iKPvxrD+NvbE1VzBgWh+T5kyWF1jjx6FNV58F0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9ACCDF80559;
	Wed, 23 Nov 2022 15:52:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 62DE8F8055A; Wed, 23 Nov 2022 15:52:26 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 71CE3F80558
 for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2022 15:52:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 71CE3F80558
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Gix4xn+u"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 91DF2B8201C;
 Wed, 23 Nov 2022 14:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC79CC433D6;
 Wed, 23 Nov 2022 14:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669215138;
 bh=4+w/qhSkQClDEWpGCuK5vMgYnSvhUvQxBjmnRyx0UDs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Gix4xn+ujjY3jz1kv+t2KtHR93OvXBdQS3254ozepDJ30B+EwHS+aGvOuJ6jeylmK
 C/iOljO12vuJkUCcqGpZESc4t8Tc0V+AG/qwJfIRambbaMH0vITOmGbMoH53Q9DMhL
 JLUJmf2xRHRUN/M7FpIQ5rWKBfi3FfGCNGNdYyuK91gzMisTmN6nl3XxC/5PQe+izk
 uyfY9WJ7Dl7qnt9sr8d22pKbgZD7M5Rp6ocMACGKMELTdTmbHnay+78hKKrnJ5jMdb
 hxa6jxvzfG7qkeqduenlJNym4nNHGhAHQydjp3C4wkbswcOWaUy8nVL+IFjG5Fk5ve
 siAxD68yTe/Dw==
Date: Wed, 23 Nov 2022 20:22:14 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC/soundwire: remove is_sdca boolean property
Message-ID: <Y34znr8o9+RceRif@matsya>
References: <20221118025807.534863-1-yung-chuan.liao@linux.intel.com>
 <20221118025807.534863-2-yung-chuan.liao@linux.intel.com>
 <Y3enHzY8XY70/nWR@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3enHzY8XY70/nWR@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 pierre-louis.bossart@linux.intel.com, ranjani.sridharan@linux.intel.com,
 peter.ujfalusi@linux.intel.com, bard.liao@intel.com
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

On 18-11-22, 15:39, Mark Brown wrote:
> On Fri, Nov 18, 2022 at 10:58:06AM +0800, Bard Liao wrote:
> > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > 
> > The Device_ID registers already tell us if a device supports the SDCA
> > specification or not, in hindsight we never needed a property when the
> > information is reported by both hardware and ACPI.
> 
> Acked-by: Mark Brown <broonie@kernel.org>

Hey Mark,

sound/soc/codecs/rt1318-sdw.c does not exist for me in sdw/next. Can I
get a tag for the changes merged into ASoC for this

Thanks
-- 
~Vinod
