From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 2/2] ASoC: omap-mcpdm: Replace legacy
	driver
Date: Sat, 20 Aug 2011 08:01:14 +0100
Message-ID: <20110820070113.GB5011@opensource.wolfsonmicro.com>
References: <1313739679-8975-1-git-send-email-peter.ujfalusi@ti.com>
	<1313739679-8975-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7685A2476C
	for <alsa-devel@alsa-project.org>;
	Sat, 20 Aug 2011 09:01:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1313739679-8975-3-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 19, 2011 at 10:41:19AM +0300, Peter Ujfalusi wrote:

> +/*
> + * DAPM event function to ensure, that the host side McPDM interface is turned
> + * off after the codec's DAC.
> + */
> +static int omap_mcpdm_interface_event(struct snd_soc_dapm_widget *w,
> +		struct snd_kcontrol *kcontrol, int event)

So, the issue here is that the CODEC you're using on your system lacks
DAC mute support and doesn't handle the end of the input stream
gracefully?  This doesn't sound like a McPDM specific issue at all, and
I'm slightly surprised we don't run into it more often.

Currently the sequence we use on stream teardown is:

  1. Mute.
  2. Stop stream.
  3. Wait for the DAPM teardown time.
  4. Power down.

but it seems like what your CODEC actually wants is:

  1. Power down.
  2. Stop stream.

which isn't at all unresonable and if the CODEC is actually able to
support that mode of operation well then it'll be lower power.  This
seems like something we should be supporting in the core as I would
expect other devices will find it useful, PDM class D speaker drivers
being the most obvious example.

I do think it'd be helpful to split this code out as a separate patch
as it's the controversial bit...
