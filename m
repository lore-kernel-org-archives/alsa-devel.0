Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB05C433FE
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Sep 2022 14:42:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 75228857;
	Thu, 29 Sep 2022 16:41:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 75228857
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1664462552;
	bh=LZNlYRoXBpIqPwVeaEJOiOqjBblGK3j303JdHweNsFA=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R+O67MI4OBXJI86LrBPrlgaHKHOmNTZYTY+kOKTZSgd5B7AVrWihEw4oSOL+Y4nFb
	 HGKf0wghl8CXS/3TA9QHODWCyG+yOVRJsSea2haeSfiiw7md7jmLUnjxTaiuBDW2DV
	 aCwwGBgwvEL8vn/JTdslMJiv4eQYQeFTbS0t+8OM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EB4EAF8016D;
	Thu, 29 Sep 2022 16:41:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AC20BF8023A; Thu, 29 Sep 2022 16:41:39 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B1C32F800AA
 for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2022 16:41:33 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id F2F2CA0042;
 Thu, 29 Sep 2022 16:41:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz F2F2CA0042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1664462493; bh=mhhaUT4Ay0Fu25jbyAsIXsNKYUdlHjuJMi6m6+RlF8s=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=tyX4Ah0HiYMkRdkiDfYTIUi4Fb+fldb4oTNjeVVylJes2Wjvh9DgzSWcuo3nx84I5
 MoEupH5E1I1BUOETq5AonOupTiOojcGxPauUcvFlwYxAs5qaxd+TkM44V+0i7p1az5
 0VMt5lIitpUV2epZ0x9QGRxF0V19E4aE2RcgesIo=
Received: from [192.168.100.98] (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Thu, 29 Sep 2022 16:41:30 +0200 (CEST)
Message-ID: <93fd8d6c-a17c-5907-467c-4e93b24d04e7@perex.cz>
Date: Thu, 29 Sep 2022 16:41:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ASoC: core: clarify the driver name initialization
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
References: <20220929080654.326311-1-perex@perex.cz>
 <YzWf74wbZg6SbxNN@sirena.org.uk>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <YzWf74wbZg6SbxNN@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: ALSA development <alsa-devel@alsa-project.org>
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

On 29. 09. 22 15:38, Mark Brown wrote:
> On Thu, Sep 29, 2022 at 10:06:54AM +0200, Jaroslav Kysela wrote:
>> The driver field in the struct snd_ctl_card_info is a valid
>> user space identifier. Actually, many ASoC drivers do not care
>> and let to initialize this field using a standard wrapping method.
> 
> This breaks at least an arm multi_v7_defconfig build:
> 
> /build/stage/linux/sound/soc/soc-core.c: In function ‘snd_soc_bind_card’:
> /build/stage/linux/sound/soc/soc-core.c:2055:36: error: ‘struct snd_soc_card’ ha
> s no member named ‘dmi_longname’
>   2055 |         if (card->long_name == card->dmi_longname)
>        |                                    ^~
> 
> 
>> Also, it does not make sense to set the driver field to the
>> card name composed from DMI. This card name is longer in most
>> (all?) cases. Use a generic "ASoC-DMI" string here.
> 
> This should be a separate change, and DMI is a term specific to the
> ACPI/EFI so I don't think we should be using it as a generic here, this
> seems like a step back.  If we want to make a change there I'd expect it
> to be more picking the actual card driver name.

Thanks for the review. Yes, I made a mistake here. I wrongly mixed name and 
long name strings in my head. I removed the DMI check and posted v2 of the patch.

			Jaroslav


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
