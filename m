From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm - Refactor widget IO functions
	in	preparation for platform widgets.
Date: Thu, 9 Jun 2011 20:21:47 +0100
Message-ID: <20110609192147.GA9916@opensource.wolfsonmicro.com>
References: <1307643049-3819-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CA56F2439E
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jul 2011 14:18:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1307643049-3819-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 09, 2011 at 07:10:49PM +0100, Liam Girdwood wrote:

> +static int soc_widget_read(struct snd_soc_dapm_widget *w, int reg)
> +{
> +	if (w->codec)
> +		return snd_soc_read(w->codec, reg);
> +	return 0;
> +}

I guess this and write() should return an error if they can't find
something to interact with.  And realistically to also complain in the
logs given how usefully we can actualy handle errors.

I'm tempted to say let me post my regmap API that I've had sitting in my
-next queue over the weekend then we can just unconditionally use a
regmap here.  I'd not been too happy with how it was handling mutli-word
I/O but there's only one user of that in ASoC so far.  We still need the
_widget and so on versions wrapping them in ASoC of course so that we
can pass sensible objects in.

> +int soc_widget_update_bits(struct snd_soc_dapm_widget *w, unsigned short reg,
> +				unsigned int mask, unsigned int value)
> +{
> +	int change;
> +	unsigned int old, new;
> +
> +	old = soc_widget_read(w, reg);
> +	new = (old & ~mask) | value;

Should do the & mask on value that I added to the vanilla one last week
- that would've avoided a genuine bug.
