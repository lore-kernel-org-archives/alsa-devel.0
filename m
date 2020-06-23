Return-Path: <SRS0=wWF8=AF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B079C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Jun 2020 08:09:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DBF120B80
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Jun 2020 08:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RH6dNz3t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DBF120B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C52A16B4;
	Wed, 24 Jun 2020 10:08:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C52A16B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592986179;
	bh=WHOSJ+/vNeWNxlGSNkIX8BD+GxCblyNh1CuaoElS//k=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RH6dNz3tog32NPG2K21agmkv5l767hhCGhuxh9QCOzZE6V4tuv72N48iZW+shwGV0
	 9Cy5GYK1SYqz+nOQR86wvEnvdLDwvqtrQ2ofxxROVknr5ulsBjKC0Lh9FhpDzW126d
	 qDibk6SoHhNkacGkvvTqJBNwZNNO6p1jylYHDeto=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AEFA3F8044A;
	Wed, 24 Jun 2020 09:50:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E3507F80259; Tue, 23 Jun 2020 17:56:56 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 91BE4F8023E
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2020 17:56:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 91BE4F8023E
IronPort-SDR: djoC1ZTNzM0ISvwykB0Lc6QUGJ2RDnVBXoWH+AxBkZnIlnutETZl3jY2PFnyU8ot5ycqvzjfOh
 cdx4TEPczSJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="123791892"
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; d="scan'208";a="123791892"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2020 08:56:49 -0700
IronPort-SDR: bgB3ilcNPNXQyT5Ki0OLm5qgSkjC9l6GWTEQnuFagfsDao8YcahNQDkRFu8X9FneJOWqgMa/DV
 z+GjrfbJ7Emg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; d="scan'208";a="263367240"
Received: from meis-mobl1.amr.corp.intel.com (HELO [10.255.230.137])
 ([10.255.230.137])
 by fmsmga007.fm.intel.com with ESMTP; 23 Jun 2020 08:56:40 -0700
Subject: Re: [PATCH 01/19] ASoC: hdmi-codec: merge .digital_mute() into
 .mute_stream()
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Mark Brown <broonie@kernel.org>
References: <87ftam37ko.wl-kuninori.morimoto.gx@renesas.com>
 <87eeq637ff.wl-kuninori.morimoto.gx@renesas.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <3e596232-a22f-cd67-702e-59fb79c8aaec@linux.intel.com>
Date: Tue, 23 Jun 2020 10:18:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87eeq637ff.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 24 Jun 2020 09:49:30 +0200
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>,
 Linux-ALSA <alsa-devel@alsa-project.org>, Michael Walle <michael@walle.cc>,
 =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
 Neil Armstrong <narmstrong@baylibre.com>, David Airlie <airlied@linux.ie>,
 =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
 Jonghwan Choi <charlie.jh@kakaocorp.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Paul Cercueil <paul@crapouillou.net>, Andrzej Hajda <a.hajda@samsung.com>,
 Frank Shi <shifu0704@thundersoft.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Benjamin Gaignard <benjamin.gaignard@linaro.org>,
 "Andrew F. Davis" <afd@ti.com>, Fabio Estevam <festevam@gmail.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Joonyoung Shim <jy0922.shim@samsung.com>,
 Matthias Reichl <hias@horus.com>, Katsuhiro Suzuki <katsuhiro@katsuster.net>,
 Kevin Hilman <khilman@baylibre.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Takashi Iwai <tiwai@suse.com>, YueHaibing <yuehaibing@huawei.com>,
 Russell King <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk@kernel.org>,
 Daniel Drake <drake@endlessm.com>, Tzung-Bi Shih <tzungbi@google.com>,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Kukjin Kim <kgene@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Dinghao Liu <dinghao.liu@zju.edu.cn>,
 Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
 Cheng-Yi Chiang <cychiang@chromium.org>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Jonas Karlman <jonas@kwiboo.se>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Chuhong Yuan <hslester96@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 James Schulman <james.schulman@cirrus.com>, Inki Dae <inki.dae@samsung.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Dan Murphy <dmurphy@ti.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
 Vincent Abriou <vincent.abriou@st.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 Jernej Skrabec <jernej.skrabec@siol.net>,
 Support Opensource <support.opensource@diasemi.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Jason Yan <yanaijie@huawei.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
 David Rhodes <david.rhodes@cirrus.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Sandy Huang <hjc@rock-chips.com>, Pavel Dobias <dobias@2n.cz>,
 Philipp Puschmann <p.puschmann@pironex.de>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Vishwas A Deshpande <vishwas.a.deshpande@ti.com>,
 Daniel Vetter <daniel@ffwll.ch>, Colin Ian King <colin.king@canonical.com>,
 Kevin Cernekee <cernekee@chromium.org>, Lucas Stach <l.stach@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Peter Rosin <peda@axentia.se>,
 M R Swami Reddy <mr.swami.reddy@ti.com>
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


> -static int sii902x_audio_digital_mute(struct device *dev,
> -				      void *data, bool enable)
> +static int sii902x_audio_mute(struct device *dev, void *data,
> +			      bool enable, int direction)
>   {
>   	struct sii902x *sii902x = dev_get_drvdata(dev);
>   
> +	if (direction != SNDRV_PCM_STREAM_PLAYBACK)
> +		return 0;
> +

Thanks for this clean-up Morimoto-san.

One question: in all the codec changes the return is now 0.

But in the previous implementation based on digital_mute, when the wrong 
direction was used it would have been -ENOTSUPP.

int snd_soc_dai_digital_mute(struct snd_soc_dai *dai, int mute,
			     int direction)
{
	int ret = -ENOTSUPP;

	if (dai->driver->ops &&
	    dai->driver->ops->mute_stream)
		ret = dai->driver->ops->mute_stream(dai, mute, direction);
	else if (direction == SNDRV_PCM_STREAM_PLAYBACK &&
		 dai->driver->ops &&
		 dai->driver->ops->digital_mute)
		ret = dai->driver->ops->digital_mute(dai, mute);

<<< none of the branches taken for capture + digital_mute supported, so 
return -ENOTSUPP.

	return soc_dai_ret(dai, ret);
}

Was this change intentional?

We also want to check why this return value is only tested in 
soc-dapm.c, if this digital_mute can fail then we are missing tests left 
and right - maybe that's a follow-up change?

