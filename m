From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: wm8711: Add proper mask for wm8711_set_dai_fmt
Date: Mon, 31 Oct 2011 12:37:50 +0000
Message-ID: <20111031123749.GA10217@opensource.wolfsonmicro.com>
References: <1319771281.3944.1.camel@phoenix>
 <1319771527.3944.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1319771527.3944.4.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 28, 2011 at 11:12:07AM +0800, Axel Lin wrote:
> Add mask for BIT[3:2] (the Input Audio Data Bit Length Select)
> of WM8711_IFACE(07h) register.
> Otherwise, BIT[3:2] will be always set to 0b00 here.

Your changelog here isn't terribly clear and doesn't really correspond
to the change well.  Here you say you're masking something but...

> -	u16 iface = 0;
> +	u16 iface = snd_soc_read(codec, WM8711_IFACE) & 0x000c;

...what you're actually doing is preserving the existing values of some
register bits.  Nevertheless the change looks good so applied.
