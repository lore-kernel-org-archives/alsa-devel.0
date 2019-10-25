Return-Path: <SRS0=ik9t=YS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4B7CA9EA0
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Oct 2019 17:49:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEC8E21D81
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Oct 2019 17:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EwZuraRf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC8E21D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D7ABC1876;
	Fri, 25 Oct 2019 19:48:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D7ABC1876
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572025744;
	bh=NFgMp5wN3dCGUuSeS+nDuYmSqzZm46xT4W3CrXd/s5I=;
	h=Date:From:To:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EwZuraRfr5IzcAlbiX1+I1x/qxqpL1sj3jEchPlnL/uQQKc+MKeB5da/PnXsCMgue
	 PHsVqtfZnzGkjJs6A9y75aqzD8KB+6JXmeWg1RdcBjJAuHhVus0DtdAZZ0x1EHU8aJ
	 jL+paOXB2j/ChmI8HbZrMMA1Sew1tGXR0ZU0eCI0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 48B1BF80368;
	Fri, 25 Oct 2019 19:48:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 37870F8036F; Fri, 25 Oct 2019 19:48:11 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AF86DF802A0
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2019 19:48:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AF86DF802A0
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 10:48:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,229,1569308400"; d="scan'208";a="192610386"
Received: from zeliteleevi.tm.intel.com ([10.237.55.130])
 by orsmga008.jf.intel.com with ESMTP; 25 Oct 2019 10:48:02 -0700
Date: Fri, 25 Oct 2019 20:48:01 +0300 (EEST)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@zeliteleevi
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
In-Reply-To: <6f6bbd75-a371-812e-0901-3e263ab37f45@ti.com>
Message-ID: <alpine.DEB.2.21.1910252014070.16459@zeliteleevi>
References: <20191025123038.19728-1-perex@perex.cz>
 <alpine.DEB.2.21.1910251542360.16459@zeliteleevi>
 <6f6bbd75-a371-812e-0901-3e263ab37f45@ti.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Cc: ALSA development <alsa-devel@alsa-project.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Takashi Iwai <tiwai@suse.de>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: change 'HDMI/DP, pcm=' to 'HDMI/DP,
 pcm=' Jack control names
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

Hi Peter,

On Fri, 25 Oct 2019, Peter Ujfalusi wrote:

> On 10/25/19 3:44 PM, Kai Vehmanen wrote:
> > When the common-hdmi patches go in (v7 sent earlier this week), SOF will 
> > switch to common-hdmi and the also the naming will be aligned. 
> 
> Which is going to break existing users, if any ;)

valid point :) but I have actually gone to great lengths to not break 
existing user-space. I did consider the same approach as Jaroslav 
(especially as there is still limited number of SOF clients in the wild 
still), but dropped the idea based on userspace feedback. So in the end, 
backward compatibility is kept in the patchset just for this reason.

The common-hdmi patch adds ability to use SOF with both codec drivers and 
I even added a module parameter to allow distros to compile both drivers 
in, and select the driver to use, at runtime from user-space.

Slowly as user-space migrates to the new driver (more features), we can
at some point drop the old and get rid of "'HDMI/DP, pcm=' notation. Of 
course, proving there is no one left is not easy, so we likely need 
to maintain both for a looong time.

Br, Kai
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
