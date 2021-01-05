Return-Path: <SRS0=jAxA=GI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44661C433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Jan 2021 13:01:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87581229F0
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Jan 2021 13:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87581229F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BC6CB1684;
	Tue,  5 Jan 2021 14:00:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BC6CB1684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609851698;
	bh=Cee9dn3J26ogGJf1aocVmfV3X08Zl+6NjXMRmFopdT8=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SwdiJFqOYOddJIRs+thmbtkF9RPuNOatO7QbszxVP+3sMNf/PgQlQ2PJKtkvqjgnT
	 H6oPDDN5giMX8fYOTkkHQd7kDUHZNDIeg5Bbayv9oKzQCsqCISLZ7apJsDL70Rf0R5
	 VBfY6/bvN987ObBujz0A2j2MjclsHkjwfnZy+mGs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B3126F80268;
	Tue,  5 Jan 2021 14:00:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 25030F801F5; Tue,  5 Jan 2021 14:00:42 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B85B7F8012B;
 Tue,  5 Jan 2021 14:00:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B85B7F8012B
IronPort-SDR: t9DsfmPF2528XyNveD83LuDD6xLFoGuqXqM7sQhJn8K326UysjFCk4wK2d4O6DZRtIVchKmKir
 pyGDZyRXyh6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="261864616"
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; d="scan'208";a="261864616"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2021 05:00:33 -0800
IronPort-SDR: kXyPxD3/i3+kNgTomQl+sswUl8Rflu/3/SRDgEEtE1Ld9v2Wray4IHsfXB2hJkeiC5YkBmUol3
 alzeW5ytCncw==
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; d="scan'208";a="378861333"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2021 05:00:19 -0800
Date: Tue, 5 Jan 2021 14:57:19 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v2 1/3] ASoC: SOF: Intel: hda: Resume codec to do jack
 detection
In-Reply-To: <20210104140853.228448-1-kai.heng.feng@canonical.com>
Message-ID: <alpine.DEB.2.22.394.2101051425560.864696@eliteleevi.tm.intel.com>
References: <20210104140853.228448-1-kai.heng.feng@canonical.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, kai.vehmanen@linux.intel.com,
 lgirdwood@gmail.com, Rander Wang <rander.wang@intel.com>,
 open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 ranjani.sridharan@linux.intel.com, pierre-louis.bossart@linux.intel.com,
 Mark Brown <broonie@kernel.org>,
 Payal Kshirsagar <payalskshirsagar1234@gmail.com>, daniel.baluta@nxp.com,
 "moderated list:SOUND - SOUND OPEN FIRMWARE \(SOF\) DRIVERS"
 <sound-open-firmware@alsa-project.org>
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

On Mon, 4 Jan 2021, Kai-Heng Feng wrote:

> Instead of queueing jackpoll_work, runtime resume the codec to let it
> use different jack detection methods based on jackpoll_interval.

hmm, but jackpoll_work() does the same thing, right? So end result should 
be the same.

> This matches SOF driver's behavior with commit a6e7d0a4bdb0 ("ALSA: hda:
> fix jack detection with Realtek codecs when in D3"). Since SOF only uses
> Realtek codec, we don't need any additional check for the resume.

This is not quite correct. First, SOF does support any HDA codec, not just 
Realteks (see e.g. https://github.com/thesofproject/linux/issues/1807), 
and second, this doesn't really match the hda_intel.c patch you mention. 
SOF implements a more conservative approach where we basicly assume 
codec->forced_resume=1 to always apply, and do not implement support for 
codec->relaxed_resume. So the above patch doesn't fully apply to SOF as 
the design is not same.

> diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
> index 6875fa570c2c..df59c79cfdfc 100644
> --- a/sound/soc/sof/intel/hda-codec.c
> +++ b/sound/soc/sof/intel/hda-codec.c
> @@ -93,8 +93,7 @@ void hda_codec_jack_check(struct snd_sof_dev *sdev)
>  		 * has been recorded in STATESTS
>  		 */
>  		if (codec->jacktbl.used)
> -			schedule_delayed_work(&codec->jackpoll_work,
> -					      codec->jackpoll_interval);
> +			pm_request_resume(&codec->core.dev);

I think this change is still good. Just drop the but about Realtek 
codecs from commit message and maybe s/matches/aligns/.

Br, Kai
