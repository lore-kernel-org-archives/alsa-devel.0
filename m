Return-Path: <SRS0=1fsy=7W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7082C433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2020 08:53:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48CC6206D5
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2020 08:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eDrKFeOe";
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="Ix5WBkay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48CC6206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DE6F316A5;
	Tue,  9 Jun 2020 10:52:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DE6F316A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591692810;
	bh=2eaGk9LC1ac/tUUD3sRYbJ6FY3fpXCXSdq2iwj59ypA=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eDrKFeOeOtPnW9m0g4E2D+Iu14iMVsjDP9Swajyo1W4Tvzxh21OfUtnJcBwULSQRP
	 nSOV9HlhGCGfcNrtG4TH41zF1rIXrHzPWNvaLJEZoh1y3YOcSNnFu6DFXJromW74CH
	 ZoTNc3eCh5vR3+6S1SN5AtdeNipOwOie5cMYGqdo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 15E68F80291;
	Tue,  9 Jun 2020 10:50:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E1F59F802E2; Tue,  9 Jun 2020 10:50:44 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 29E54F80088
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2020 10:50:39 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id BD82EA0047;
 Tue,  9 Jun 2020 10:50:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz BD82EA0047
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1591692638; bh=EaK8chWMHR5vPJRuMUoFRExs4Zn2tyzmmyAByf0G0P4=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Ix5WBkayV/p8yJIYMq3dOeJkeYfKu+iToPfY3ak1HFKYx324wlPLh7FX7fTW9hlMS
 JNPp0TOZsKOqxz8tl3fBlcXMZSlqLUOr2IHRhYmAjmsTW78MhYqWuLYCfi4VDUay8H
 WBF4wqTFiBIO9z4ZGsja1ME8jNwu81FCL0AwpMUs=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Tue,  9 Jun 2020 10:50:36 +0200 (CEST)
Subject: Re: [PATCH 1/3] bytcr-rt5640: Fix DMIC1 not working when connected
 over AIF2
To: Hans de Goede <hdegoede@redhat.com>
References: <20200608202142.92894-1-hdegoede@redhat.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <2d965cd4-5ba1-838a-3b21-c135166d6c66@perex.cz>
Date: Tue, 9 Jun 2020 10:50:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200608202142.92894-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org
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

Dne 08. 06. 20 v 22:21 Hans de Goede napsal(a):
> The RT5640 codec has 2 ADC-s which are caled the Stereo ADC and the
> Mono ADC (even though the mono ADC seems to be stereo too?). The Stereo
> ADC is connected to the AIF1 interface of the codec and the Mono ADC
> to the AIF2 interface.
> 
> Almost all X86 BYT/CHT design use the AIF1 interface, but a few models
> use the AIF2 interface. For this reason the IN?-InternalMic.conf bits
> not only select/enable the microphone input on the Stereo ADC, but
> also on the Mono ADC, so that the analog mic. inputs also work in devices
> using the AIF2 interface.
> 
> Before this commit DigitalMics.conf was only setting up the DMIC input
> on the Stereo ADC and not on the Mono ADC, causing DMIC1 to not work
> when connected over AIF2.
> 
> This commit adds selecting / enabling DMIC1 on the Mono ADC.
> This fixes the internal microphone not working on the Toshiba Encore WT10A.
> 
> Note that for devices which use the AIF1 interface this is a no-op since
> the AIF1 interface is not connected to anything, there is no complete
> chain so DAPM will not enable any of the elements in the chain.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Applied to the alsa-ucm-conf repo. Thank you.

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
