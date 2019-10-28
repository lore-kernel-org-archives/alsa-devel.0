Return-Path: <SRS0=lYxt=YV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2509FCA9EC0
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 17:34:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A540E208C0
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 17:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ajlj8X0g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A540E208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D452B2098;
	Mon, 28 Oct 2019 18:33:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D452B2098
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572284085;
	bh=kG0NRtCDUMkowcSpVtR12cKn6G7i/N9KZ9mQjRBoOlk=;
	h=Date:From:To:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ajlj8X0gCskPxk8Gk4mwqYHW/tMAmG+0oHsFeeqEL6zIyMnsUU0kJ5aljCfaM3cod
	 0N+KX0Ct0+OmCfaX5ndlb0EmJDl5TFxLYftwve2PJzxDoRmUMA/PQhGWtFy53eS0Pn
	 yRqoo038iUdavULHpDqg/d1GKbQWL0LC1CB2Br/g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3DDCBF803D6;
	Mon, 28 Oct 2019 18:33:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 87738F8048E; Mon, 28 Oct 2019 18:33:52 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 589D4F800E7
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2019 18:33:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 589D4F800E7
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Oct 2019 10:33:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,240,1569308400"; d="scan'208";a="205236369"
Received: from zeliteleevi.tm.intel.com ([10.237.55.130])
 by FMSMGA003.fm.intel.com with ESMTP; 28 Oct 2019 10:33:45 -0700
Date: Mon, 28 Oct 2019 19:33:44 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@zeliteleevi
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5hpnigu7rs.wl-tiwai@suse.de>
Message-ID: <alpine.DEB.2.21.1910281931040.16459@zeliteleevi>
References: <20191023090331.10531-1-kai.vehmanen@linux.intel.com>
 <20191023090331.10531-7-kai.vehmanen@linux.intel.com>
 <s5hpnigu7rs.wl-tiwai@suse.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Cc: libin.yang@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v7 6/9] ASoC: Intel: bxt-da7219-max98357a:
 common hdmi codec support
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

thanks for the review!

On Mon, 28 Oct 2019, Takashi Iwai wrote:

> On Wed, 23 Oct 2019 11:03:28 +0200,
> Kai Vehmanen wrote:
> > -snd-soc-sst-bxt-da7219_max98357a-objs := bxt_da7219_max98357a.o
> > +snd-soc-sst-bxt-da7219_max98357a-objs := bxt_da7219_max98357a.o hda_dsp_common.o
> 
> Hrm, this can be a problem.  I see there are multiple drivers that are
> built with this object.  When they are built as modules and more than
> one module get loaded on a system, it'll lead to a conflict because
> both modules try to put the same stuff.
[...]
> But I'm not entirely sure whether this is true on the recent kernel
> build.  At least it *was* a problem in the past.
> 
> In anyway, please try to load the two modules on your system and check
> whether the module loading works.

hmm, did a quick test and no problems seen, all modules load fine.

Another option is to go back to solution in v6 of the series and
have the helper functions inlines. But it seems v7 works as well, so maybe 
we'll stick with this.

Br, Kai

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
