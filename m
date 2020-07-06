Return-Path: <SRS0=aG7p=AR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F272C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:04:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0637320739
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uOTCNuM8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0637320739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7EF331612;
	Mon,  6 Jul 2020 22:03:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7EF331612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594065881;
	bh=5TxH5+abgCrOOjzN1wlIMOBr+OQLbqIN9icAwkffnOI=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uOTCNuM8CfQH4fa/DLXDhOjj/YkemoO6FQaPzKRONzjPMKNuekZG+PA/QnXwCAiq1
	 5FDZOyJFHB+9jgPMnP4Zc+xYX0omGJVgzgRAzCmvV6BzyzUQrr2mOL3m0QC1K4SwIX
	 TcgYXBeM59XYqitRLOtnc2d/7H2dNLCEZZEcCQHY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3D495F801D8;
	Mon,  6 Jul 2020 22:02:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CAC51F80161; Mon,  6 Jul 2020 22:02:13 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 09A76F80150
 for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2020 22:02:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 09A76F80150
IronPort-SDR: tcVB6p4g6zt7b/P6u+yRoQ9wLj0kQhTtZPz6S6YZgv3APF68mS1dNsvv9OEwH2ijhnh/55q5l7
 dgxwk5vA8P6A==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="149010106"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; d="scan'208";a="149010106"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2020 13:01:59 -0700
IronPort-SDR: oLa8u2qRmpishpFQPzrBPTi356UnVW1yzhg5j0LFkz+nf+GxBCEm7F9mmBwGj7qGtAWXkwv9C/
 +dkqavVAk9Ig==
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; d="scan'208";a="315276291"
Received: from mghaithx-mobl1.ger.corp.intel.com (HELO [10.254.110.83])
 ([10.254.110.83])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2020 13:01:58 -0700
Subject: Re: [PATCH v2 07/10] topology: decode: Fix decoding PCM formats and
 rates
To: Piotr Maziarz <piotrx.maziarz@linux.intel.com>, alsa-devel@alsa-project.org
References: <1594026363-30276-1-git-send-email-piotrx.maziarz@linux.intel.com>
 <1594026363-30276-8-git-send-email-piotrx.maziarz@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e894c6a9-447a-7383-3a52-3317d50f2261@linux.intel.com>
Date: Mon, 6 Jul 2020 14:58:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1594026363-30276-8-git-send-email-piotrx.maziarz@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: cezary.rojewski@intel.com, amadeuszx.slawinski@intel.com
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



On 7/6/20 4:06 AM, Piotr Maziarz wrote:
> Not checking _LAST format and rate, which are valid indexes in arrays,
> makes data loss while converting binary to UCM.

In the previous version you were decoding to UML. I presume this was 
typo, but now what does decoding a topology binary to UCM means? Did you 
really mean UCM as in Use Case Management 
(https://www.alsa-project.org/alsa-doc/alsa-lib/group__ucm.html)

> Change-Id: I71ac42b65e8b1d79f2a061f805c62e29a758ad74
> ---
>   src/topology/pcm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/topology/pcm.c b/src/topology/pcm.c
> index b15b950..db40114 100644
> --- a/src/topology/pcm.c
> +++ b/src/topology/pcm.c
> @@ -549,7 +549,7 @@ int tplg_save_stream_caps(snd_tplg_t *tplg ATTRIBUTE_UNUSED,
>   	if (err >= 0 && sc->formats) {
>   		err = tplg_save_printf(dst, pfx, "\tformats '");
>   		first = 1;
> -		for (i = 0; err >= 0 && i < SND_PCM_FORMAT_LAST; i++) {
> +		for (i = 0; err >= 0 && i <= SND_PCM_FORMAT_LAST; i++) {
>   			if (sc->formats & (1ULL << i)) {
>   				s = snd_pcm_format_name(i);
>   				err = tplg_save_printf(dst, NULL, "%s%s",
> @@ -563,7 +563,7 @@ int tplg_save_stream_caps(snd_tplg_t *tplg ATTRIBUTE_UNUSED,
>   	if (err >= 0 && sc->rates) {
>   		err = tplg_save_printf(dst, pfx, "\trates '");
>   		first = 1;
> -		for (i = 0; err >= 0 && i < SND_PCM_RATE_LAST; i++) {
> +		for (i = 0; err >= 0 && i <= SND_PCM_RATE_LAST; i++) {
>   			if (sc->rates & (1ULL << i)) {
>   				s = get_rate_name(i);
>   				err = tplg_save_printf(dst, NULL, "%s%s",
> 
