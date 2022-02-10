Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F326C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Feb 2022 13:31:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CD90418FE;
	Thu, 10 Feb 2022 14:30:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CD90418FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1644499898;
	bh=2zdjWTY9pmqeyCcaii9xQhF6IAogRoT+OvBfJoZCOww=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dHKrmb50Cvt73mR2HceklcX7mk9v4XAuNX6G8y94Aeu1/1qzD5/2n7m/Lr74+VhDT
	 teudRvBE5Tvu0+PEM69kjBg9qEi2KFXPZ7pQzw1+0nkjm0pWF/f9+o1nXZ8hQMV7Er
	 zorpoOIt5dUVNaHP7KaD8Hd+K19JLwflmumNk258=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7D045F8016C;
	Thu, 10 Feb 2022 14:30:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8BC18F800A7; Thu, 10 Feb 2022 14:30:46 +0100 (CET)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 536F6F800A7
 for <alsa-devel@alsa-project.org>; Thu, 10 Feb 2022 14:30:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 536F6F800A7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="Hl6mZBaK"
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: adalessandro) with ESMTPSA id 6B6971F46453
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1644499839;
 bh=2zdjWTY9pmqeyCcaii9xQhF6IAogRoT+OvBfJoZCOww=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Hl6mZBaKFGEzPDcKwFhyRNX6jGsaW3U74lS0m6ksQUUh012PTBl+wtIFzcT9Q2Yo5
 Iyvxt7vCgsMXAbWBnc/NXBwSrKxVM2JHhKM7uUlg+sXJR+nyq4HfeVIAuYvRK4WBFK
 x0gaNSYzlo/zu1xD5QCPa+G2TXDhenaa0Nbo84hwqwyzk+KQjrC4OmamL8+y5FfNCy
 +tKaKafk2d19ukbrtFANgyEYiKQhcFnNcYEakGqQ3zRW3om+j6CsM5AKzmbc+4fOww
 ER8ivV+wQHXgliJNtji7hEPkrbn5aKGJydr+xLco3SzdMG5Oh6Jz73mlwFUd+eoyx7
 9Ks5r+BMz4T3g==
Message-ID: <2cfa6083-8f9a-2355-d99b-4ac1a8b00965@collabora.com>
Date: Thu, 10 Feb 2022 10:30:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 1/2] ASoC: bindings: fsl-asoc-card: Add compatible for
 tlv320aic31xx codec
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
References: <20220207164946.558862-1-packagers@lists.apertis.org>
 <YgUSEvMGMoSQYy5v@sirena.org.uk>
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
In-Reply-To: <YgUSEvMGMoSQYy5v@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 krzysztof.kozlowski@canonical.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
 linux-imx@nxp.com, kernel@pengutronix.de, michael@amarulasolutions.com,
 festevam@gmail.com, linux-arm-kernel@lists.infradead.org
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

Hi Mark,

On 2/10/22 10:24, Mark Brown wrote:
> On Mon, Feb 07, 2022 at 01:49:45PM -0300, Apertis package maintainers wrote:
>> From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
>>
>> Commit 8c9b9cfb7724 ("ASoC: fsl-asoc-card: Support
>> fsl,imx-audio-tlv320aic31xx codec")' added support for tlv320aic31xx
>> codec to fsl-asoc-card, but missed the related device-tree compatible
>> string documentation. Fix this.
>>
>> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
>> ---
> 
> This has a signoff from Ariel but the mail comes from something called
> "Apertis package maintainers" and I really can't tell if there's a good
> signoff chain here, please see Documentation/process/submitting-patches.rst
> for details on what this is and why it's important.  The submission
> really needs to come from an actual person who's providing a signoff.

Ugh (:hard-facepalm:) totally a misconfiguration on my mail client. Will 
resubmit right away. Sorry for not noticing it when I sent the patchset.

Thanks,
Ariel
