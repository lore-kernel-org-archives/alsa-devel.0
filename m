Return-Path: <SRS0=fLcx=YP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A465FCA9EA0
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 11:16:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78D5121783
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 11:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Y6ROTPC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D5121783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 59B331607;
	Tue, 22 Oct 2019 13:15:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 59B331607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571743007;
	bh=2riWWhodJQxDAI3qTukDXi0TFzXBrQpdl2wcTEofkRs=;
	h=Date:From:To:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y6ROTPC0j7HhInWz6sxG9YuOqfmy4P634kiDntZFt02wM48ZT9R4zXapf9b9Vdkhu
	 p1lcniJ+u0QH7Po59SZPsx56pxE7rMj0JC1zprYu3Ll0VV+e5ZvzvYXpnd0Cz3JDYv
	 mXpwczj6oAM61tJQsDieJgA4aNlHI2rzYIRHmwEA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CA80CF802FB;
	Tue, 22 Oct 2019 13:15:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 86358F8031A; Tue, 22 Oct 2019 13:15:54 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7BE03F8026A
 for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2019 13:15:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7BE03F8026A
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Oct 2019 04:15:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,326,1566889200"; d="scan'208";a="227664843"
Received: from zeliteleevi.tm.intel.com ([10.237.55.130])
 by fmsmga002.fm.intel.com with ESMTP; 22 Oct 2019 04:15:47 -0700
Date: Tue, 22 Oct 2019 14:15:46 +0300 (EEST)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@zeliteleevi
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5hk193iyoh.wl-tiwai@suse.de>
Message-ID: <alpine.DEB.2.21.1910221401580.16459@zeliteleevi>
References: <20191011112745.25800-1-kai.vehmanen@linux.intel.com>
 <20191011112745.25800-4-kai.vehmanen@linux.intel.com>
 <s5hk193iyoh.wl-tiwai@suse.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Cc: libin.yang@intel.com, alsa-devel@alsa-project.org,
 pierre-louis.bossart@linux.intel.com,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v6 3/9] ASoC: Intel: skl-hda-dsp-generic:
 use snd-hda-codec-hdmi
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

On Thu, 17 Oct 2019, Takashi Iwai wrote:
> Kai Vehmanen wrote:
> > +static inline struct snd_pcm *hda_dsp_hdmi_pcm_handle(struct snd_soc_card *card,
> > +						      int hdmi_idx)
> > +{
[...]
> > +static inline int hda_dsp_hdmi_build_controls(struct snd_soc_card *card,
> > +					      struct snd_soc_component *comp)
>
> These additions look a bit too large for inline functions.
> Wouldn't it be difficult to make them non-inline?

ack, shouldn't be too difficult. I'll make the update and also rebase on 
top of Mark's tree.

My rationale for inlining was that these functions are used by machine 
drivers only, so each machine driver got a copy anyways in the end, plus 
I wanted to avoid modifying the Makefile rules for all the machine drivers
I touched. But neither is a hard requirement, so let's put the new helpers
into their own compilation unit.

Thanks for the review!

Br, Kai
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
