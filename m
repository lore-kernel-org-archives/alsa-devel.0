Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C05C3F6B0
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Aug 2022 06:22:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A888B1654;
	Wed, 17 Aug 2022 05:17:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A888B1654
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660706320;
	bh=KN+oR2ZB0OGAYHSXIKX2Szp/sjTGYxl4uDu/QzAmps0=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WQvTHlslqkZqhP6kR3XDbAH7oTrX+/mafRUt694yvTAzAY+Rh0Julsga1lNQ1XCM7
	 WSFvIpCGLT8E3vhWRXzm9oY9jgwifvhJ0gwwBhTbtIzEJhYIuy0jxACldjBX8fqjg6
	 M2fgpS1xhjjeQXYDp3PSyY7I+qbiBt52Xu9Mf/ZY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 252A8F80237;
	Wed, 17 Aug 2022 05:17:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 484EFF80088; Wed, 17 Aug 2022 05:17:47 +0200 (CEST)
Received: from mail-m11876.qiye.163.com (mail-m11876.qiye.163.com
 [115.236.118.76])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 25A2BF80088
 for <alsa-devel@alsa-project.org>; Wed, 17 Aug 2022 05:17:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25A2BF80088
Received: from [172.16.12.22] (unknown [58.22.7.114])
 by mail-m11876.qiye.163.com (Hmail) with ESMTPA id D1AB33C04DD;
 Wed, 17 Aug 2022 11:17:32 +0800 (CST)
Message-ID: <5b15df0d-428c-d2c2-6467-3c0a3a161af8@rock-chips.com>
Date: Wed, 17 Aug 2022 11:17:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Rockchip I2S commit possibly ignored
To: Geraldo Nascimento <geraldogabriel@gmail.com>,
 Mark Brown <broonie@kernel.org>
References: <YvuYZE0biiAn/sxQ@geday> <YvuZbrBWzRjHYQZj@sirena.org.uk>
 <Yvudjkjxtv7M/DPL@geday> <Yvu2PRrQvsRAJSm7@sirena.org.uk>
 <YvvZzkYQ8Ce3/Lwj@geday>
From: sugar zhang <sugar.zhang@rock-chips.com>
In-Reply-To: <YvvZzkYQ8Ce3/Lwj@geday>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFJSktLSjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaS0NCVkofSkNMTUwYGE8eHVUTARMWGhIXJB
 QOD1lXWRgSC1lBWU5DVUlJVUxVSkpPWVdZFhoPEhUdFFlBWU9LSFVKSktITkhVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pyo6CBw5Cz08NxMuHz5RD1EN
 Dy8wCRBVSlVKTU1LTEtNSU5ISE1LVTMWGhIXVQgOHBoJVQETGhUcOwkUGBBWGBMSCwhVGBQWRVlX
 WRILWUFZTkNVSUlVTFVKSk9ZV1kIAVlBT0xJQjcG
X-HM-Tid: 0a82a9ce688d2eb2kusnd1ab33c04dd
Cc: ALSA-devel <alsa-devel@alsa-project.org>
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

Hi Geraldo, Mark,

在 2022/8/17 1:54, Geraldo Nascimento 写道:
> On Tue, Aug 16, 2022 at 04:22:37PM +0100, Mark Brown wrote:
>> On Tue, Aug 16, 2022 at 10:37:18AM -0300, Geraldo Nascimento wrote:
>>
>>> This isn't my patch, it's a patch by Sugar Zhang from Rockchip that was
>>> supposed to have been applied one year ago, give or take 10 days. I
>>> can't resend a patch that wasn't authored by me.
>> There's absolutely no problem with reposting someone else's patch - just
>> add your Signed-off-by at the end of the signoff chain.
> Mark, I'm in no position to lecture anyone, least of who, you, hard-working
> ASoC maintainer that you are. But there are *tons* of problems with
> reposting someone else's patch, even if they had been previously given
> the green-light but misteriously vanished.
>
> You are assuming responsibility for someone else's work! Let's see in
> this case what would happen:
>
> In this case, the Rockchip I2S missing reset affair, I have tested
> the proposed changes, and they are OK, *if* you add the reset properties
> in the device tree.
>
> For example, I was playing with HDMI sound on the RK3399pro Radxa Rock Pi
> N10 and I added the following properties to my private rk3399.dtsi:
>
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -1695,6 +1695,8 @@ i2s2: i2s@ff8a0000 {
>   		dma-names = "tx", "rx";
>   		clock-names = "i2s_clk", "i2s_hclk";
>   		clocks = <&cru SCLK_I2S2_8CH>, <&cru HCLK_I2S2_8CH>;
> +		reset-names = "reset-m", "reset-h";
> +		resets = <&cru SRST_I2S2_8CH>, <&cru SRST_H_I2S2_8CH>;
>   		power-domains = <&power RK3399_PD_SDIOAUDIO>;
>   		#sound-dai-cells = <0>;
>   		status = "disabled";
>
> ---
>
>
> And once I okay &i2s2 and &hdmi_sound inside rk3399pro-vmarc-som.dtsi I
> get kind of working HDMI sound, very clipped, I have to software adjust
> the volume to 30% to get clean, not speaker-blowing sound. But I
> digress, the point that it kinda works is not the point at all.
>
> My main point is that without adding "resets" and "reset-names" to *at
> least* every Rockchip device tree that enables sound over HDMI, just an
> example, you get systems with non-working HDMI. I just tested it, I
> omitted "resets" and "reset-names" from my device tree and then had
> to SSH into the black screen to revert the changes to my boot partition.

Actually,  the reset is used for i2s SLAVE mode which may fail to clear 
if the MASTER

side stop the clk before i2s done. in this situation, we do reset the 
controller and

bring it back to normal state.

But, for HDMI sound,  the i2s works as MASTER mode and should not be 
fail to clear.

could you share your I2S and HDMI register dump to me to dig out the 
root cause.

OTOH，I have noticed that some patchs ignored on upstream, I will check 
and repost

those patchs.

> So it's not trivial to RESEND this. It amounts to device tree overhaul
> of arch/arm64/boot/dts/rockchip
>
> This would require community effort of say, equivalent to LibreELEC
> resources, which are not many, but they have enough patience to test
> every proposed change to Rockchip device trees, and could help upstream
> this.
>
> Thank you,
> Geraldo Nascimento

-- 
Best Regards!
张学广/Sugar
瑞芯微电子股份有限公司
Rockchip Electronics Co., Ltd.

