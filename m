Return-Path: <SRS0=ZrTp=W5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D557AC3A59E
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Sep 2019 12:53:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62A772168B
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Sep 2019 12:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SqGh0ds9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A772168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A153516BC;
	Mon,  2 Sep 2019 14:52:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A153516BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567428823;
	bh=VGZ9VQkTT1VFCYlrrcAwYKhuiYkovYyDlOBD0X8v4A0=;
	h=Date:From:To:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SqGh0ds916AYTVpGXLo+P1SS908060ngdib7scnhLRzPJp/xQiXoUyTkGfZZe7A1q
	 nUA1OE5hw9PUa9rlcNfKCT6rMofYlT0ZDIJIfj88jvb0jkzWwnX06uLo+VGXgtbWI2
	 I6QjvTE87s4MrLOY22zxixaTDR1mjlGW7dvvq1Fw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 22CBBF80394;
	Mon,  2 Sep 2019 14:52:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9BEBBF803D0; Mon,  2 Sep 2019 14:52:52 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F1EDBF802E0
 for <alsa-devel@alsa-project.org>; Mon,  2 Sep 2019 14:52:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1EDBF802E0
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 Sep 2019 05:52:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,459,1559545200"; d="scan'208";a="189550911"
Received: from zeliteleevi.tm.intel.com ([10.237.55.130])
 by FMSMGA003.fm.intel.com with ESMTP; 02 Sep 2019 05:52:45 -0700
Date: Mon, 2 Sep 2019 15:52:44 +0300 (EEST)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@zeliteleevi
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5h8src2hci.wl-tiwai@suse.de>
Message-ID: <alpine.DEB.2.21.1909021516200.16459@zeliteleevi>
References: <20190829135348.23569-1-kai.vehmanen@linux.intel.com>
 <20190829135348.23569-6-kai.vehmanen@linux.intel.com>
 <s5h8src2hci.wl-tiwai@suse.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Cc: libin.yang@intel.com, alsa-devel@alsa-project.org,
 pierre-louis.bossart@linux.intel.com,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 5/7] ALSA: hda/hdmi - implement
 mst_no_extra_pcms flag
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

Hi Takashi,

On Thu, 29 Aug 2019, Takashi Iwai wrote:

> On Thu, 29 Aug 2019 15:53:46 +0200,
> Kai Vehmanen wrote:
> >  static int generic_hdmi_build_pcms(struct hda_codec *codec)
> >  {
[...]
> > +	if (codec->mst_no_extra_pcms)
> > +		pcm_num = spec->num_nids;
> > +	else
> > +		pcm_num = spec->num_nids + spec->dev_num - 1;
>
> Instead of changing this, we can simply take dev_num=1 like below.
[...]
> -	if (is_haswell_plus(codec)) {
> +	if (codec->mst_no_extra_pcms) {
> +		/* for SOF/SST, no backup PCM streams can be assigned */
> +		dev_num = 1; 
> +		spec->dev_num = 1;
> +	} else if (is_haswell_plus(codec)) {

hmm, I think we need to keep dev_num as 3, to create the MST per_pin 
structs for each port. I.e. we still have the virtual pins, although we 
limit PCM count to 3. Unless we do this, at least jack detection is broken 
in DP-MST mode.

One option would be to set
   dev_num = 3;
   spec->dev_num = 1;

... spec->dev_num is not really used elsewhere than 
generic_hdmi_build_pcms(), so this works.

But, but, this seems quite confusing. So ok if I keep in original form and 
have separate logic in generic_hdmi_build_pcms()?

Br, Kai
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
