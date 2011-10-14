From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: ad193x: Use snd_soc_update_bits
 for read-modify-write
Date: Fri, 14 Oct 2011 20:10:01 +0100
Message-ID: <20111014191000.GB2931@opensource.wolfsonmicro.com>
References: <1318582919.19976.1.camel@phoenix>
	<1318582987.19976.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 77AFF2443E
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Oct 2011 21:10:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1318582987.19976.2.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 14, 2011 at 05:03:07PM +0800, Axel Lin wrote:

>  	reg = snd_soc_read(codec, AD193X_DAC_CTRL2);
> -	reg = (mute > 0) ? reg | AD193X_DAC_MASTER_MUTE : reg &
> -		(~AD193X_DAC_MASTER_MUTE);
> +	if (mute)
> +		reg |= AD193X_DAC_MASTER_MUTE;
> +	else
> +		reg &= ~AD193X_DAC_MASTER_MUTE;
>  	snd_soc_write(codec, AD193X_DAC_CTRL2, reg);

This is still using snd_soc_read() and snd_soc_write() (though it is a
cleanup).
