From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH 2/8] ASoC: cs35l32: Constify struct
 regmap_config and snd_soc_codec_driver
Date: Mon, 5 Jan 2015 09:05:27 -0600
Message-ID: <alpine.DEB.2.10.1501050904500.13892@heelrod>
References: <1420449508-10701-1-git-send-email-k.kozlowski@samsung.com>
 <1420449508-10701-2-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m0077474.ppops.net (mx0b-001ae601.pphosted.com [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E0A62603A5
 for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2015 16:02:45 +0100 (CET)
In-Reply-To: <1420449508-10701-2-git-send-email-k.kozlowski@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

> The regmap_config struct may be const because it is not modified by the
> driver and regmap_init() accepts pointer to const. Make struct
> snd_soc_codec_driver const as well (snd_soc_register_codec() accepts
> pointer to const).
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Brian Austin <brian.austin@cirrus.com>
> Cc: Paul Handrigan <Paul.Handrigan@cirrus.com>
For the Cirrus Codecs

Acked-by: Brian Austin <brian.austin@cirrus.com>

Thanks 
