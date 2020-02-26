Return-Path: <SRS0=ZBV5=4O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093E1C4BA12
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Feb 2020 12:52:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 768A224684
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Feb 2020 12:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="me+oiXOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 768A224684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=apparatus.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CE4321657;
	Wed, 26 Feb 2020 13:52:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CE4321657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582721570;
	bh=Ss1DxhAlXwFasbOETeRivACMVvQBwqZ7h2ELjSI1OCE=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=me+oiXOawUV77ea07ic30wDl1giePenjTDmaooN/niTpPNGXOThR1c4XLMRjJV+6S
	 QuFvZiNQ8h5o2gaQ2S3HspVksRrlrmVgaduQ7N4fuXxPN9cjlY2lT2W8hpsSmHft+g
	 per56UXgerAuo0wDbH+ew/kkIr4K25dquFAZbl1Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 69100F800E8;
	Wed, 26 Feb 2020 13:52:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DCF34F8014D; Wed, 26 Feb 2020 13:51:57 +0100 (CET)
Received: from apparatus.de (apparatus.de [116.203.57.180])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 97886F800AD
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2020 13:51:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 97886F800AD
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
 by apparatus.de (Postfix) with ESMTPA id AE58CFF28B
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2020 12:51:54 +0000 (UTC)
Subject: Re: snd_dice: Clicking artifacts with TC StudioKonnekt 48
To: alsa-devel@alsa-project.org
References: <921a3b13-b44e-3300-bb72-84cbc9e3dd88@apparatus.de>
 <20200222012510.GA4883@laptop>
 <e29617da-9d34-c99f-f425-5d2aef59b623@apparatus.de>
 <20200224002031.GA10405@laptop>
From: Mathias Buhr <napcode@apparatus.de>
Message-ID: <3b42e75b-07ec-9dd4-b399-dbad30afc5a4@apparatus.de>
Date: Wed, 26 Feb 2020 13:51:53 +0100
MIME-Version: 1.0
In-Reply-To: <20200224002031.GA10405@laptop>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Authentication-Results: apparatus.de;
 auth=pass smtp.auth=buhr@apparatus.de smtp.mailfrom=napcode@apparatus.de
X-Spamd-Bar: /
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

On 24.02.20 01:20, Takashi Sakamoto wrote:
> Hi,
>
> On Sat, Feb 22, 2020 at 05:49:29PM +0100, Mathias Buhr wrote:
>> Thanks for your reply Takashi! It clarifies the situation. I'lll stick
>> with ffado then.
>>
>> Regards,
>>
>> Mathias
> Both of libffado2 and ALSA dice driver have problems for each, but it's
> a convenient option for users of Dice-based devices to use the former,
> at present. I've been improved ALSA dice driver for years with the other
> drivers, but it doesn't bring so hasty changes since it's a kind of
> reverse-engineering; no one knows the actual design and few ones can
> make discussion based on the fact.
>
>
> Well, I also own TC Electronic Sudio Konnekt 48 and I've investigated
> its protocol to configure I/O routings on internal DSP. After my
> vacation, I'll send information about it for your convenience
> (maybe next week).
>
>
> Regards
>
> Takashi Sakamoto

Thanks Takashi! I'd appreciate that!

Regards

-Mathias
