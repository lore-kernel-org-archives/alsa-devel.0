Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD682C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Nov 2021 13:57:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 35E2F178F;
	Wed, 24 Nov 2021 14:56:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 35E2F178F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637762257;
	bh=mfTFWKbe2PFF3eyl9pwcDqRXF1qtutj8V3O+DJfTt5s=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i3hXyzkIhiJJjb6yQuf8rfWNbmMjEvM8ima6y1tArcnguFGH5MP1ffmnwp5/Rvf+x
	 nrIJoVhykIjJt+1eBnvvJ4Io5VLrbiZ5/73M5zDvtJ4POaNclo3clf5qHMa7Rmu5il
	 7gJkq7m78UqoOPXP6Tv6HB+ByAWJFnCjUPHHfLnY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B7806F8014D;
	Wed, 24 Nov 2021 14:56:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 64730F801F7; Wed, 24 Nov 2021 14:56:45 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 76F0CF8011F
 for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2021 14:56:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 76F0CF8011F
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="298684455"
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; d="scan'208";a="298684455"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2021 05:56:35 -0800
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; d="scan'208";a="509881362"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2021 05:56:33 -0800
Date: Wed, 24 Nov 2021 15:49:01 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/3] ASoC: SOF: sof-audio: setup sched widgets during
 pipeline complete step
In-Reply-To: <YZ42x4GkTEboP1bi@sirena.org.uk>
Message-ID: <alpine.DEB.2.22.394.2111241518470.3554566@eliteleevi.tm.intel.com>
References: <20211123171606.129350-1-kai.vehmanen@linux.intel.com>
 <YZ42x4GkTEboP1bi@sirena.org.uk>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, daniel.baluta@nxp.com,
 ranjani.sridharan@linux.intel.com, lgirdwood@gmail.com,
 yung-chuan.liao@linux.intel.com
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

Hi,

On Wed, 24 Nov 2021, Mark Brown wrote:

> On Tue, Nov 23, 2021 at 07:16:04PM +0200, Kai Vehmanen wrote:
> 
> > Fixes: 5fcdbb2d45df ("ASoC: SOF: Add support for dynamic pipelines")
> > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> This doesn't actually apply as a fix FWIW, I've queued it for -next.

ack, this won't apply on top of for-5.16. The dependencies around the SOF 
dynamic pipelines (and related code) are unfortunately rather complicated 
with many recent changes. I now sent these on top of for-5.17/65c16dd2942 
as baseline.

Given the limited use of dynamic pipelines in current SOF topologies,
we should be good for 5.16 even if these are left out. The Fixes
tags should still be useful for anyone backporting patches to older
kernels.

Br, Kai
