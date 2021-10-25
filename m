Return-Path: <SRS0=4dkw=PN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBA4C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 12:59:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B8DA61057
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 12:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9B8DA61057
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2C6E016CD;
	Mon, 25 Oct 2021 14:58:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2C6E016CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635166768;
	bh=kggSCSu6rdv94kVQ1AAvUlB38PLMb9JZujLErCGKwDk=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zccv131h/pkug3lUadlKAd0oUrwREJR2h+b+96ekVEujN13YZ8LGAIGZidKMiUkSI
	 cPJJW3UIXS/qlOH2uIzEX5nO4sVxGKxQkQLOnzgyD24EoborzvlXD2T57r6LqWFJMV
	 xEOvfaIrh/OxNuj+Z9W2uL3RK+Y0bwVvJmsAyzv4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B95CCF80166;
	Mon, 25 Oct 2021 14:58:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 92FF1F8025A; Mon, 25 Oct 2021 14:58:36 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0EC2AF80086
 for <alsa-devel@alsa-project.org>; Mon, 25 Oct 2021 14:58:27 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 5B1D5A003F;
 Mon, 25 Oct 2021 14:58:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 5B1D5A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1635166702; bh=2eZ26/VaEzftwu3ZmYsfOCPTwZ9yZoE3hgkj1VEFB+I=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BHt3MaR/tnH1YLlX0CxYPQLb0TApnFbI0kfh54oCDK9UYHer4A5PCYcG7fNDlI9Wl
 l/rAVmzVS+aGmJ4bJnEpVBj4S8+Ub5Xqkq1fW4Tar5TF0/zuRCsbSOMsJdgCWNlEhi
 hZMMBpuIDsoRSFlTW5nddFWLYAwb1aOChP6N3TgM=
Received: from [192.168.100.98] (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon, 25 Oct 2021 14:58:13 +0200 (CEST)
Message-ID: <79541c76-2c2b-fd4b-60c8-67ee6b8ea3fa@perex.cz>
Date: Mon, 25 Oct 2021 14:58:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] ASoC: tegra: Add master volume/mute control support
Content-Language: en-US
To: Sameer Pujar <spujar@nvidia.com>, broonie@kernel.org,
 lgirdwood@gmail.com, tiwai@suse.com
References: <1635159976-17355-1-git-send-email-spujar@nvidia.com>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <1635159976-17355-1-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
 thierry.reding@gmail.com, linux-kernel@vger.kernel.org, jonathanh@nvidia.com
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

On 25. 10. 21 13:06, Sameer Pujar wrote:

> @@ -150,11 +186,22 @@ static int tegra210_mvc_put_mute(struct snd_kcontrol *kcontrol,

...
>   
>   	return 1;

It's a bit unrelated comment to this change, but it may be worth to verify all 
kcontrol put callbacks in the tegra code. Ensure that value 1 is returned only 
when something was really changed in hardware.

The tegra210_i2s_put_control() has opposite problem for example - returns 
always 0 which means that the change notifications are not send to subscribed 
applications.

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
