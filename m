From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: wm8711: Add proper mask for wm8711_set_dai_fmt
Date: Fri, 28 Oct 2011 15:15:56 +0800
Message-ID: <CAF+7xWn+cEPCcxTwH=69WAyzkq=EZFhii7D3nQoB=OeKj=SV0A@mail.gmail.com>
References: <1319771281.3944.1.camel@phoenix> <1319771527.3944.4.camel@phoenix>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1319771527.3944.4.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2011/10/28 Axel Lin <axel.lin@gmail.com>:
> Add mask for BIT[3:2] (the Input Audio Data Bit Length Select)
> of WM8711_IFACE(07h) register.
> Otherwise, BIT[3:2] will be always set to 0b00 here.
>
I think the subject line is not good.
I'll resend a patch with below subject line:
ASoC: Leave input audio data bit length settings untouched in wm8711_set_dai_fmt

Regards,
Axel
