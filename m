From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 19/19] ALSA: SoC Audio support for OMAP4
 boards with Yamaha YMU831 codec
Date: Wed, 16 Jan 2013 13:48:25 +0000
Message-ID: <20130116134825.GG16235@sirena.org.uk>
References: <20130116172530.857b627ef3303fb6fe43f603@linux-mips.org>
 <20130116174601.1427658dd0091efa61fc7f74@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20130116174601.1427658dd0091efa61fc7f74@linux-mips.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yoichi Yuasa <yuasa@linux-mips.org>
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 16, 2013 at 05:46:01PM +0900, Yoichi Yuasa wrote:

> +	base = ioremap(0x4a004108, 16);
> +	if (base) {
> +		if (params_rate(params) < 16000) {
> +			internal_freq /= 4;
> +			iowrite32(ioread32(base) | 0x02, base);
> +		} else
> +			iowrite32(ioread32(base) & ~0x02, base);
> +		iounmap(base);
> +	}

You can't be seriously trying to include this code in mainline...
you're poking at random magic numbers in the CPU address space.

> +static int omap_ymu831_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +	rtd->pmdown_time = 500;
> +
> +	return 0;
> +}

Why?
