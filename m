Return-Path: <SRS0=8ObE=OK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C16DC433FE
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Sep 2021 16:43:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8425F61177
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Sep 2021 16:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8425F61177
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diwic.se
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2553916C1;
	Mon, 20 Sep 2021 18:42:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2553916C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632156217;
	bh=XO4M4LS4xS69mz1TuBLg17lHJcaxAT6HtWlaKFkHvqY=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hCmjWaf1BiOnXkz012xoQsbkPvKAiW+rU4nYNgoX+W+wU4mdaT/CQ1XMC2bSz/XXd
	 T4VzSHYoaty2NSUg56TxDdyMHrIHiEt+D22Ob59JGhJdEtSXXp+0ipzvwXr/lZTseS
	 GSohpcCPpF+93nO4+QmpvWp79o/pSs79vxlDzCW8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A787AF8025D;
	Mon, 20 Sep 2021 18:42:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B3850F8025D; Mon, 20 Sep 2021 18:42:45 +0200 (CEST)
Received: from ns4.inleed.net (mailout4.inleed.net
 [IPv6:2a0b:dc80:cafe:104::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9EC35F80152
 for <alsa-devel@alsa-project.org>; Mon, 20 Sep 2021 18:42:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9EC35F80152
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=diwic.se header.i=@diwic.se
 header.b="R54V3cke"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=diwic.se;
 s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yEv9NWBu3uZpQsNDkbdOJOgm0v68XHpSZXS3lb+TOUs=; b=R54V3ckeJXd61eLuED5tqhSloZ
 yYSqr1i1x+37xVvJw459/m2nDfZtzwJXyf/B8v6HTnBXaRr41H9SbV69W9YUpNm8t3l/tWRGBDrB5
 yZlAHfMuTWlqunJXhPeYKciThNuan7hGyU5jVg5792B/2ZWPTigN6MNM3uL6gkbQl06urwkzNey+j
 rMf3Tcreb3RAHbiepLGkKB1HlNHxFgQxuEM3zPWXZgCRoz3ZtMhxvu/wmWJYrhnXuuPI1TfFM4L/g
 9QAX0wrqxQ4A6tf91bA/tYyn25Bzt+008nFIpQ7GQI6rcOuvDrKT3wHtrqjbOcMAfkDWZvaE0tAFd
 WsY4FEjQ==;
Received: from c83-254-143-147.bredband.tele2.se ([83.254.143.147]
 helo=[192.168.5.6]) by ns4.inleed.net with esmtpsa (TLS1.2) tls
 TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <coding@diwic.se>)
 id 1mSMND-00DanS-QZ; Mon, 20 Sep 2021 18:42:31 +0200
Subject: Re: [PATCH] ALSA: rawmidi: introduce SNDRV_RAWMIDI_IOCTL_USER_PVERSION
To: Jaroslav Kysela <perex@perex.cz>,
 ALSA development <alsa-devel@alsa-project.org>
References: <20210920083538.128008-1-perex@perex.cz>
From: David Henningsson <coding@diwic.se>
Message-ID: <5f2b66ef-01f2-f371-e8af-afa236f10cc5@diwic.se>
Date: Mon, 20 Sep 2021 18:42:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210920083538.128008-1-perex@perex.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Id: coding@diwic.se
Cc: Takashi Iwai <tiwai@suse.de>, stable@vger.kernel.org
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


On 2021-09-20 10:35, Jaroslav Kysela wrote:
> The new framing mode causes the user space regression, because
> the alsa-lib code does not initialize the reserved space in
> the params structure when the device is opened.
>
> This change adds SNDRV_RAWMIDI_IOCTL_USER_PVERSION like we
> do for the PCM interface for the protocol acknowledgment.
>
> Cc: David Henningsson <coding@diwic.se>
> Cc: <stable@vger.kernel.org>
> Fixes: 08fdced60ca0 ("ALSA: rawmidi: Add framing mode")
> BugLink: https://github.com/alsa-project/alsa-lib/issues/178
> Signed-off-by: Jaroslav Kysela <perex@perex.cz>
> ---
>   include/sound/rawmidi.h     | 1 +
>   include/uapi/sound/asound.h | 1 +
>   sound/core/rawmidi.c        | 9 +++++++++
>   3 files changed, 11 insertions(+)
>
> diff --git a/include/sound/rawmidi.h b/include/sound/rawmidi.h
> index 989e1517332d..7a08ed2acd60 100644
> --- a/include/sound/rawmidi.h
> +++ b/include/sound/rawmidi.h
> @@ -98,6 +98,7 @@ struct snd_rawmidi_file {
>   	struct snd_rawmidi *rmidi;
>   	struct snd_rawmidi_substream *input;
>   	struct snd_rawmidi_substream *output;
> +	unsigned int user_pversion;	/* supported protocol version */
>   };
>   
>   struct snd_rawmidi_str {
> diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
> index 1d84ec9db93b..f906e50a7919 100644
> --- a/include/uapi/sound/asound.h
> +++ b/include/uapi/sound/asound.h
> @@ -784,6 +784,7 @@ struct snd_rawmidi_status {
>   
>   #define SNDRV_RAWMIDI_IOCTL_PVERSION	_IOR('W', 0x00, int)
>   #define SNDRV_RAWMIDI_IOCTL_INFO	_IOR('W', 0x01, struct snd_rawmidi_info)
> +#define SNDRV_RAWMIDI_IOCTL_USER_PVERSION _IOW('A', 0x02, int)

How come it's not 'W' here but 'A' instead?

Looks good otherwise, given a quick glance. It'll need a corresponding 
alsa-lib patch to actually call SNDRV_RAWMIDI_IOCTL_USER_PVERSION.

Thanks for helping to sort this out.

// David

