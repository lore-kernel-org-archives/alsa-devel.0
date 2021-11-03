Return-Path: <SRS0=wMeK=PW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA43C433F5
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Nov 2021 22:10:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4533961101
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Nov 2021 22:10:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4533961101
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0ACA6166B;
	Wed,  3 Nov 2021 23:09:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0ACA6166B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635977445;
	bh=1Y7s9XKGOhVcrDzPDw6mT6Vmftu/ds9ncXRrAMDn0KM=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fxu+AzwjFFewwm9BPVZPWXooCvZJ+PzY6oLrZcv19OBaY6z85Bx1nh+4IM+XoWFj5
	 RnJxvYX0H60OZvmX4NP88MwjhZZBjgTHw6uWg6lnU23F33wqQy66navWkNEbW/yvEZ
	 rAxW9V5gFzDs5Ovzc61O8ohD3Y+opRmf2bPbleoo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 670DEF80269;
	Wed,  3 Nov 2021 23:09:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4044DF8026A; Wed,  3 Nov 2021 23:09:51 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3799FF80224
 for <alsa-devel@alsa-project.org>; Wed,  3 Nov 2021 23:09:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3799FF80224
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="231451819"
X-IronPort-AV: E=Sophos;i="5.87,207,1631602800"; d="scan'208";a="231451819"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2021 15:09:07 -0700
X-IronPort-AV: E=Sophos;i="5.87,207,1631602800"; d="scan'208";a="578357318"
Received: from dennisal-mobl.amr.corp.intel.com ([10.254.55.201])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2021 15:09:06 -0700
Message-ID: <742d9c1c833d5857538343e9ceeb2fcca2f77708.camel@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF:control: Fix variable type in
 snd_sof_refresh_control()
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, lgirdwood@gmail.com, 
 broonie@kernel.org
Date: Wed, 03 Nov 2021 15:09:06 -0700
In-Reply-To: <20211103082710.17165-1-peter.ujfalusi@linux.intel.com>
References: <20211103082710.17165-1-peter.ujfalusi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: guennadi.liakhovetski@linux.intel.com, alsa-devel@alsa-project.org,
 seppo.ingalsuo@linux.intel.com, pierre-louis.bossart@linux.intel.com,
 kai.vehmanen@linux.intel.com
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

On Wed, 2021-11-03 at 10:27 +0200, Peter Ujfalusi wrote:
> From: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> 
> The second parameter for snd_sof_ipc_set_get_comp_data() is ipc_cmd,
> not
> ipc_ctrl_type and the type is u32.
> 
> Fixes: 756bbe4205bc6 ("ASoC: SOF: Handle control change notification
> from firmware")
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

Thanks, Peter.

Acked-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>


