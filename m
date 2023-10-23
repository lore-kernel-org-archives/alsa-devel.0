Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A17CC004C0
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Oct 2023 11:08:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4D09D852;
	Mon, 23 Oct 2023 13:07:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4D09D852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1698059322;
	bh=ZPYct6TKPhXnwWujFdM+whLqN4S0h84pY9ooYkcyhfU=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=sVruxkHfFRN5eJ7hp9HXNpu9liObQePPaPcTU9lA7iGvPr3wOGqiTK5lQ8sl1Phnq
	 hk63NGntJZX6aDYh/K6IuTeRFg8Ha9qYhMZM252lk0qCAKTthe6EBRyDpbyKiNMRJi
	 FpTPjP/ilRBYRrxKAdpEBLqjXa9cbbKnN1zCOmYU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CA714F80557; Mon, 23 Oct 2023 13:07:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 24897F804F3;
	Mon, 23 Oct 2023 13:07:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7D866F804F3; Mon, 23 Oct 2023 13:07:09 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [46.235.227.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 60A78F80027
	for <alsa-devel@alsa-project.org>; Mon, 23 Oct 2023 13:07:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 60A78F80027
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=ZmpjuItu
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 8195F66056D1;
	Mon, 23 Oct 2023 12:07:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1698059223;
	bh=ZPYct6TKPhXnwWujFdM+whLqN4S0h84pY9ooYkcyhfU=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=ZmpjuItuKqDzcvKhkTGQ3aOxdbFgtc9cKGZmWMS2Pl2MP66OX0vrBjUF2t9m5hpSW
	 8baH8ixIFNnK3661E9pO6zpI6M1wPVoo8txnxIPC2ZtGAl6jPTVIKEetRb5L+77Xmw
	 l1YjXzrrSNtubejjbOmTPVkzZltSqYNH65Xm8j+JUuua7tyYkfXYn7vg1A9dmwjatk
	 eb6PsUzZyKaxJp1Niy538gGG0ejv8ZU76Uux3lkR4r3HXreHsZcWs9H09iiluK6rUG
	 6fifRdjbUbyRuanhPkA3Vgo4jewDrPDUaIEZlbB2xxER9X4+frxPSBN6ThhKzV1j+c
	 aRscoCphKQPxg==
Message-ID: <d1c7833a-10d6-4188-a0e7-fab31a6bad43@collabora.com>
Date: Mon, 23 Oct 2023 13:07:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ASoC: mediatek: mt7986: add sample rate checker
Content-Language: en-US
To: Maso Huang <maso.huang@mediatek.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20231023095453.4860-1-maso.huang@mediatek.com>
 <20231023095453.4860-3-maso.huang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231023095453.4860-3-maso.huang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: WZRDMVFV6DSHQBCPXFEKULNBXWBFZRCH
X-Message-ID-Hash: WZRDMVFV6DSHQBCPXFEKULNBXWBFZRCH
X-MailFrom: angelogioacchino.delregno@collabora.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WZRDMVFV6DSHQBCPXFEKULNBXWBFZRCH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Il 23/10/23 11:54, Maso Huang ha scritto:
> mt7986 only supports 8/12/16/24/32/48/96/192 kHz
> 
> Signed-off-by: Maso Huang <maso.huang@mediatek.com>
> ---
>   sound/soc/mediatek/mt7986/mt7986-dai-etdm.c | 22 +++++++++++++++++----
>   1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/mediatek/mt7986/mt7986-dai-etdm.c b/sound/soc/mediatek/mt7986/mt7986-dai-etdm.c
> index e523d33846fe..270852ce3dd9 100644
> --- a/sound/soc/mediatek/mt7986/mt7986-dai-etdm.c
> +++ b/sound/soc/mediatek/mt7986/mt7986-dai-etdm.c
> @@ -237,12 +237,26 @@ static int mtk_dai_etdm_hw_params(struct snd_pcm_substream *substream,
>   				  struct snd_pcm_hw_params *params,
>   				  struct snd_soc_dai *dai)
>   {
> +	unsigned int rate = params_rate(params);
>   	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
>   
> -	mtk_dai_etdm_config(afe, params, dai, SNDRV_PCM_STREAM_PLAYBACK);
> -	mtk_dai_etdm_config(afe, params, dai, SNDRV_PCM_STREAM_CAPTURE);
> -
> -	return 0;
> +	switch (rate) {
> +	case 8000:
> +	case 12000:
> +	case 16000:
> +	case 24000:
> +	case 32000:
> +	case 48000:
> +	case 96000:
> +	case 192000:
> +		mtk_dai_etdm_config(afe, params, dai, SNDRV_PCM_STREAM_PLAYBACK);
> +		mtk_dai_etdm_config(afe, params, dai, SNDRV_PCM_STREAM_CAPTURE);
> +		return 0;
> +	default:
> +		dev_warn(afe->dev, "%s(), sample rate: %d is not supported\n", __func__, rate);
> +		dev_warn(afe->dev, "%s(), only support 8/12/16/24/32/48/96/192 kHz\n", __func__);

That's better:

dev_err(afe->dev,
	"Sample rate %d invalid. Supported rates: 8/12/16/24/32/48/96/192 kHz\n",
	rate, __func__);

after which,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Regards,
Angelo


