From: Florian Meier <florian.meier@koalo.de>
Subject: Re: [PATCHv4] ASoC: Add support for BCM2835
Date: Fri, 22 Nov 2013 14:32:19 +0100
Message-ID: <528F5CE3.30105@koalo.de>
References: <528E4E4A.20403@koalo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f49.google.com (mail-bk0-f49.google.com
 [209.85.214.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 5829A261AC1
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2013 14:32:24 +0100 (CET)
Received: by mail-bk0-f49.google.com with SMTP id my13so791309bkb.22
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2013 05:32:22 -0800 (PST)
In-Reply-To: <528E4E4A.20403@koalo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: devicetree <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>, dmaengine <dmaengine@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

> +	dev = devm_kzalloc(&pdev->dev, sizeof(*dev),
> +			   GFP_KERNEL);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);

Found a typo here, should be IS_ERR(dev) and PTR_ERR(dev).

Is the patch acceptable apart from that now?

Greetings,
Florian
