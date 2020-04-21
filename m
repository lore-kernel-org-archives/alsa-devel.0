Return-Path: <SRS0=/Ps/=6F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F877C54FCC
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Apr 2020 15:07:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9F6D206E9
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Apr 2020 15:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KeRZLCej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F6D206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1653316C5;
	Tue, 21 Apr 2020 17:06:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1653316C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587481652;
	bh=XhncJwYKTyyDlks0all9XkiNVB9ZD8wgrNMF4z/1TO4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KeRZLCejXIKl6p9tZ45d4rRk/xADVG8fX+XNxMnMO8+CfaTqKnptkBB128NxgYUoZ
	 ietsk9rCSombehSVBxuTeJagPdZHNhSbEfysE6IjKtDn0YGeswSga1+8QEAeUoD+7h
	 hKHwuy5vLceRSBbXzNGahHoetgBpxDc3zmnG0PKU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A388DF800FF;
	Tue, 21 Apr 2020 17:06:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AA1CFF801EC; Tue, 21 Apr 2020 17:06:40 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 68EF9F800FF
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2020 17:06:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 68EF9F800FF
IronPort-SDR: V4j1JGS3HxdyA29Q45GGLw/RoSQr/YEyylcxrqOdg8m6BHbhCFzzqfcUGSpmOboSXphrEaOm1B
 fOz+Tvp+k6oA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2020 08:06:20 -0700
IronPort-SDR: m07o34MraKooma/QLVZpR2+xslWAJCWS0hDzBbgA2IUdrnnWx+hHxNQ8I/kOlHZ0ip5OMSJiwP
 NazpzpvB76sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,410,1580803200"; d="scan'208";a="291624855"
Received: from mklessen-mobl.amr.corp.intel.com (HELO [10.251.142.187])
 ([10.251.142.187])
 by orsmga008.jf.intel.com with ESMTP; 21 Apr 2020 08:06:19 -0700
Subject: Re: [PATCH 1/2] ASoC: SOF: Fix "no reply expected" error during
 firmware-boot
To: Hans de Goede <hdegoede@redhat.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
References: <20200402184948.3014-1-hdegoede@redhat.com>
 <1ecf6c31-4eb1-0288-2353-7a7a421fe5e7@linux.intel.com>
 <a0d5d95e-113b-3543-cfc5-43dfa3f9142c@redhat.com>
 <be66d657-f4c5-46d8-d0b5-4879d7aa7463@linux.intel.com>
 <20200420124815.GB10045@sirena.org.uk>
 <84764e4c-8077-15b6-ff4c-9d002d42734a@linux.intel.com>
 <alpine.DEB.2.21.2004202320370.2957@eliteleevi.tm.intel.com>
 <ed11f532-432e-cc4c-160e-31b0ec427b82@redhat.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <36de465a-0db4-f978-6830-0aa5b51f3f08@linux.intel.com>
Date: Tue, 21 Apr 2020 08:36:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ed11f532-432e-cc4c-160e-31b0ec427b82@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>
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


> I've retested with 5.7-rc2 (previous testing was on 5.6-rc# + the
> "ASoC: SOF: Intel: hda-loader: clear the IPC ack bit after FW_PURGE" patch)
> and I'm no longer seeing this. So I guess fixing this also needed some 
> other
> patches which have now landed in 5.7.
> 
> So this is resolved now and my patch for this can be dropped.

Thanks for confirming Hans. We followed-up on your suggestion and 
demoted additional error messages to avoid polluting the logs.
