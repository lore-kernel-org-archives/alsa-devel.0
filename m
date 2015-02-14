From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: Add snd_soc_of_parse_audio_routing()
Date: Fri, 13 Feb 2015 21:02:46 -0800
Message-ID: <20150214050245.GA3305@Alpha>
References: <1423776602-28585-1-git-send-email-nicoleotsuka@gmail.com>
 <20150214043153.GC9110@finisterre.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150214043153.GC9110@finisterre.sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, Feb 14, 2015 at 01:31:53PM +0900, Mark Brown wrote:
> On Thu, Feb 12, 2015 at 01:30:02PM -0800, Nicolin Chen wrote:
> 
> > This patch adds snd_soc_of_parse_audio_routing() to get dapm routes
> > via Device Tree. Because snd_soc_of_parse_audio_routing() overrides
> > dpam_routes, we use snd_soc_dapm_add_routes() to append the original
> > build-in DPCM routes instead of linking them to dpam_routes directly.
> 
> It seems better to make the helper function play nicely with existing
> DAPM routes in the card rather than have to rearrange things like this.

Yes, that would be better.

> How about having it just record that it should parse the given property
> when the table in the card is being handleed rather than overwrite that?

You mean adding another pair of dapm_routes with num_dapm_routes for
Device Tree or something like that?

Thanks
Nicolin
