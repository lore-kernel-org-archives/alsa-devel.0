Return-Path: <SRS0=LPcU=4F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD62C35242
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 03:58:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18FCD2072C
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 03:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="smR8oODE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="vCAQfKnY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qcS2DU9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18FCD2072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 61C161671;
	Mon, 17 Feb 2020 04:57:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 61C161671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581911898;
	bh=cREhbl68qp6ngV4n2XpyKMkSSWpv11kaaaq+lIgB4A4=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=smR8oODElymXGjz8cRtPVPkZHaqMo4yg7PuArptu34576mxBkN5CpSCzWRlpgM9Nw
	 7OjwweS10PQfqAeXl57pAx79xfxnOQAw8NmOukaZADinMmugWCR8lsdV4UDDqB1j6p
	 8GcS7mlJHxsg2ApVMP6NllWI2mnsFJL1hm/bvoJw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BC215F800C4;
	Mon, 17 Feb 2020 04:57:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 88D32F80172; Mon, 17 Feb 2020 04:57:25 +0100 (CET)
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com
 [66.111.4.221])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 14675F800C4
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2020 04:57:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 14675F800C4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org
 header.b="vCAQfKnY"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="qcS2DU9Z"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailnew.nyi.internal (Postfix) with ESMTP id D796E66CF;
 Sun, 16 Feb 2020 22:57:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Sun, 16 Feb 2020 22:57:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 subject:to:cc:references:from:message-id:date:mime-version
 :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=s
 Eb3W4fDy5WMXH64z7KYeDZVXMFQ3arbDkHKhfiZhKo=; b=vCAQfKnYMabbL3fR9
 acRl8pTgj/z6kV2tO+937sGOQHDebph4QmKKjuctkC8B/aQrBgHGf2lXIpCPUrqZ
 vJCUwNKcxbMqI0RJgcPY+MEv3BMiwrLxJw9MZcGLq3ydBAOFmORFwRKDXdU7dxqA
 YLWVlaB0o/O8Ed8hbsyh/b3dNlyh1kBF74DHT76psgoTuvrqFSvWwv0I1aGRsHq4
 FLJL2FFlKWzHj6ISeT9iFYUPICoCBZLB/MoPEWjZTMNHbsJYU8Lr0b7oH06qIIvC
 A0/lG3aCyhhfsZ2GOTSvYdEZiBwIsCJzQSvYuUuVF/gLU1qXuh8B+VvflGq8viP+
 eiJZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; bh=sEb3W4fDy5WMXH64z7KYeDZVXMFQ3arbDkHKhfiZh
 Ko=; b=qcS2DU9Zp/IgNYWdaO9FP9AO+SAB4VDmwkR5FKpZtAZyKt+VznLOLKRzo
 KYy4KNj9pNwJbcDMvbQ4gip812YY2vlksaaxCCWeEMuwDXI8k1pvTc99NjbDZWk5
 gY/Z4XTw39Xg6+VIn+nh28KH2ubpBcQ3923Ng4YTdewTlQGBCzcaLJqb3eVLY9aw
 UW0dqjANKOIvybxtVlaCfFaXkAH445nZebk6B82Jp5KVuCVUjGbABr5KzjhGrrvV
 A+DksljLRWdresicG0nH2nTz7oxnRPghkXFAFNnTZOVybfqNs2T/J+sfuQ1h/a3S
 y0qD3VLqD5SXa0dRUZZFIG2xzSWiA==
X-ME-Sender: <xms:Hg9KXvQmllwMSyLuwpFxIJmebThEQMWUwqTA760mvQs7riW_ne2HAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgdeigecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
 lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
 epjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
 rghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:Hg9KXq0tKyZlPG-wIGjHU9MA_d4nvYBtZZWSFWK1g5UMxLt3BoxkyA>
 <xmx:Hg9KXks8wqCEfiqLS1kch0rJl7IDKRRbL7B4oXgxdjn64PGghVN8zA>
 <xmx:Hg9KXggJbCJfQPbIwYy8Zn1xdvzYoX0LGzyxv8BXRtPjepVI45Nw-A>
 <xmx:Hg9KXsNAMBogEcqN_kTsAULr6RtILbSgHZy5OsKdHO2TLIDmZ-klzA>
Received: from [192.168.50.169]
 (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
 by mail.messagingengine.com (Postfix) with ESMTPA id D2E223060BE4;
 Sun, 16 Feb 2020 22:57:17 -0500 (EST)
To: Chen-Yu Tsai <wens@csie.org>
References: <20200217021813.53266-1-samuel@sholland.org>
 <20200217021813.53266-5-samuel@sholland.org>
 <CAGb2v677p8u8_0jhcbN07QsyVc21dKJmeK6=rxLCbde+AOqreQ@mail.gmail.com>
From: Samuel Holland <samuel@sholland.org>
Message-ID: <de0a08a8-eb02-375f-4364-2935cf4c3d7c@sholland.org>
Date: Sun, 16 Feb 2020 21:57:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAGb2v677p8u8_0jhcbN07QsyVc21dKJmeK6=rxLCbde+AOqreQ@mail.gmail.com>
Content-Language: en-US
Cc: Luca Weiss <luca@z3ntu.xyz>, Linux-ALSA <alsa-devel@alsa-project.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Maxime Ripard <mripard@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Vasily Khoruzhick <anarsoul@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [alsa-devel] [PATCH 4/8] ASoC: sun50i-codec-analog: Make
 headphone routes stereo
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hello,

On 2/16/20 9:48 PM, Chen-Yu Tsai wrote:
> Hi,
> 
> On Mon, Feb 17, 2020 at 10:18 AM Samuel Holland <samuel@sholland.org> wrote:
>>
>> This matches the hardware more accurately, and is necessary for
>> including the (stereo) headphone mute switch in the DAPM graph.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>  sound/soc/sunxi/sun50i-codec-analog.c | 28 +++++++++++++++++++--------
>>  1 file changed, 20 insertions(+), 8 deletions(-)
>>
>> diff --git a/sound/soc/sunxi/sun50i-codec-analog.c b/sound/soc/sunxi/sun50i-codec-analog.c
>> index 17165f1ddb63..f98851067f97 100644
>> --- a/sound/soc/sunxi/sun50i-codec-analog.c
>> +++ b/sound/soc/sunxi/sun50i-codec-analog.c
>> @@ -311,9 +311,15 @@ static const struct snd_soc_dapm_widget sun50i_a64_codec_widgets[] = {
>>          */
>>
>>         SND_SOC_DAPM_REGULATOR_SUPPLY("cpvdd", 0, 0),
>> -       SND_SOC_DAPM_MUX("Headphone Source Playback Route",
>> +       SND_SOC_DAPM_MUX("Left Headphone Source",
>>                          SND_SOC_NOPM, 0, 0, sun50i_codec_hp_src),
>> -       SND_SOC_DAPM_OUT_DRV("Headphone Amp", SUN50I_ADDA_HP_CTRL,
>> +       SND_SOC_DAPM_MUX("Right Headphone Source",
> 
> Please don't remove the widget suffix. The suffix was chosen to work with
> alsa-lib's control parsing code. The term "Playback Route" is appropriate
> because it is playback only, and it is a routing switch, not a source or
> sink.

Removing the suffix here doesn't affect the control name as seen by userspace,
because the control is shared between multiple widgets (Left and Right).

> Also, what's wrong with just having a single "stereo" widget instead of
> two "mono" widgets? I added stereo (2-channel) support to DAPM quite
> some time ago. You just have to have two routes in and out.

If you have any completed path through a widget, the widget is turned on. A
stereo mute switch is logically two separate paths. So if I break one path by
muting one channel, that lets me turn off everything before and after in the
path (e.g. turning off the right side of the DAC lets DAPM turn off the right
mixer, the right side of the output amp, even the right side of the AIF or the
ADC if that was the only input. That only works if there are separate Left/Right
widgets.

> ChenYu

Samuel

>> +                        SND_SOC_NOPM, 0, 0, sun50i_codec_hp_src),
>> +       SND_SOC_DAPM_OUT_DRV("Left Headphone Amp",
>> +                            SND_SOC_NOPM, 0, 0, NULL, 0),
>> +       SND_SOC_DAPM_OUT_DRV("Right Headphone Amp",
>> +                            SND_SOC_NOPM, 0, 0, NULL, 0),
>> +       SND_SOC_DAPM_SUPPLY("Headphone Amp", SUN50I_ADDA_HP_CTRL,
>>                              SUN50I_ADDA_HP_CTRL_HPPA_EN, 0, NULL, 0),
>>         SND_SOC_DAPM_OUTPUT("HP"),
>>
>> @@ -405,13 +411,19 @@ static const struct snd_soc_dapm_route sun50i_a64_codec_routes[] = {
>>         { "Right ADC", NULL, "Right ADC Mixer" },
>>
>>         /* Headphone Routes */
>> -       { "Headphone Source Playback Route", "DAC", "Left DAC" },
>> -       { "Headphone Source Playback Route", "DAC", "Right DAC" },
>> -       { "Headphone Source Playback Route", "Mixer", "Left Mixer" },
>> -       { "Headphone Source Playback Route", "Mixer", "Right Mixer" },
>> -       { "Headphone Amp", NULL, "Headphone Source Playback Route" },
>> +       { "Left Headphone Source", "DAC", "Left DAC" },
>> +       { "Left Headphone Source", "Mixer", "Left Mixer" },
>> +       { "Left Headphone Amp", NULL, "Left Headphone Source" },
>> +       { "Left Headphone Amp", NULL, "Headphone Amp" },
>> +       { "HP", NULL, "Left Headphone Amp" },
>> +
>> +       { "Right Headphone Source", "DAC", "Right DAC" },
>> +       { "Right Headphone Source", "Mixer", "Right Mixer" },
>> +       { "Right Headphone Amp", NULL, "Right Headphone Source" },
>> +       { "Right Headphone Amp", NULL, "Headphone Amp" },
>> +       { "HP", NULL, "Right Headphone Amp" },
>> +
>>         { "Headphone Amp", NULL, "cpvdd" },
>> -       { "HP", NULL, "Headphone Amp" },
>>
>>         /* Microphone Routes */
>>         { "Mic1 Amplifier", NULL, "MIC1"},
>> --
>> 2.24.1
>>

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
