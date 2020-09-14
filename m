Return-Path: <SRS0=y4EY=CX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D3DC43461
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Sep 2020 08:05:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 194FB204FD
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Sep 2020 08:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vCoroPJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 194FB204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 48DEC1676;
	Mon, 14 Sep 2020 10:04:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 48DEC1676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600070731;
	bh=aq92fPFO8EkssZym62idpbM1yR6yNyjKpuQWa0el114=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vCoroPJ5vhsOK1z5exRcA2yXT08uyYOH3QVYFLtbS0RTajqwHDgplagO/HybWrZQs
	 cIP8sZdASGS3ZXq9N9bGMXXwQxGoo9RqWrT0h8y6CcO8s0ASCLpyKa1Xjp8mcvCmNk
	 oebReI604aae/YkG6w7o25oJpNrVQXeu0FKKHyIk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A532AF80150;
	Mon, 14 Sep 2020 10:04:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5C332F8015A; Mon, 14 Sep 2020 10:04:38 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7FE1AF800AA
 for <alsa-devel@alsa-project.org>; Mon, 14 Sep 2020 10:04:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7FE1AF800AA
Received: from [125.35.49.90] (helo=[10.0.0.22])
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <hui.wang@canonical.com>)
 id 1kHjTJ-0002K5-2f; Mon, 14 Sep 2020 08:04:21 +0000
Subject: Re: [PATCH] ALSA: hda/realtek: Enable front panel headset LED on
 Lenovo ThinkStation P520
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, tiwai@suse.com
References: <20200914070231.13192-1-kai.heng.feng@canonical.com>
From: Hui Wang <hui.wang@canonical.com>
Message-ID: <c4a9ed79-1c9d-8fbc-8c3b-eab191bd56bd@canonical.com>
Date: Mon, 14 Sep 2020 16:04:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200914070231.13192-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Cc: "moderated list:SOUND" <alsa-devel@alsa-project.org>,
 Kailang Yang <kailang@realtek.com>, open list <linux-kernel@vger.kernel.org>,
 =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
 Thomas Hebb <tommyhebb@gmail.com>, Jian-Hong Pan <jian-hong@endlessm.com>,
 Huacai Chen <chenhc@lemote.com>
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

Thanks Kaiheng, and we just had one P520 in the Beijing office and I 
also worked on this issue happenly. Does the led change according to 
jack plugging in or plugging out with your patch? I also prepared a 
patchset but my patchset has more code than yours, please take a look. :-)

Thanks.

Hui.

On 2020/9/14 下午3:02, Kai-Heng Feng wrote:
> On Lenovo P520, the front panel headset LED isn't lit up right now.
>
> Realtek states that the LED needs to be enabled by ALC233's GPIO2, so
> let's do it accordingly to light the LED up.
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>   sound/pci/hda/patch_realtek.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index c521a1f17096..ba941bd0b792 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -6017,6 +6017,7 @@ static void alc_fixup_thinkpad_acpi(struct hda_codec *codec,
>   #include "hp_x360_helper.c"
>   
>   enum {
> +	ALC269_FIXUP_GPIO2,
>   	ALC269_FIXUP_SONY_VAIO,
>   	ALC275_FIXUP_SONY_VAIO_GPIO2,
>   	ALC269_FIXUP_DELL_M101Z,
> @@ -6194,6 +6195,10 @@ enum {
>   };
>   
>   static const struct hda_fixup alc269_fixups[] = {
> +	[ALC269_FIXUP_GPIO2] = {
> +		.type = HDA_FIXUP_FUNC,
> +		.v.func = alc_fixup_gpio2,
> +	},
>   	[ALC269_FIXUP_SONY_VAIO] = {
>   		.type = HDA_FIXUP_PINCTLS,
>   		.v.pins = (const struct hda_pintbl[]) {
> @@ -7013,6 +7018,8 @@ static const struct hda_fixup alc269_fixups[] = {
>   	[ALC233_FIXUP_LENOVO_MULTI_CODECS] = {
>   		.type = HDA_FIXUP_FUNC,
>   		.v.func = alc233_alc662_fixup_lenovo_dual_codecs,
> +		.chained = true,
> +		.chain_id = ALC269_FIXUP_GPIO2
>   	},
>   	[ALC233_FIXUP_ACER_HEADSET_MIC] = {
>   		.type = HDA_FIXUP_VERBS,
