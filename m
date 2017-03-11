From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH for-4.11] ASoC: don't dereference NULL pcm_{new,free}
Date: Fri, 10 Mar 2017 16:24:07 -0800
Message-ID: <20170311002406.GA4586@google.com>
References: <20170308231854.50167-1-briannorris@chromium.org>
 <20170309110918.getjla6iawgjpfrq@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170309110918.getjla6iawgjpfrq@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 09, 2017 at 12:09:18PM +0100, Mark Brown wrote:
> On Wed, Mar 08, 2017 at 03:18:54PM -0800, Brian Norris wrote:
> > Not all platform drivers have pcm_{new,free} callbacks. Seen with a
> > "snd-soc-dummy" codec from sound/soc/rockchip/rk3399_gru_sound.c.
> > 
> > Resolves an OOPS seen on v4.11-rc1 with Google Kevin (Samsung Chromebook
> > Plus):
> > 
> > [    2.863304] rk3399-gru-sound sound: HiFi <-> ff880000.i2s mapping ok
> > [    2.886930] rk3399-gru-sound sound: rt5514-aif1 <-> ff880000.i2s mapping ok
> 
> Please think hard before including complete backtraces in upstream
> reports, they are very large and contain almost no useful information
> relative to their size so often obscure the relevant content in your
> message. If part of the backtrace is usefully illustrative then it's
> usually better to pull out the relevant sections.

I did think, and I did trim the trace significantly. I believe (or
believed; maybe incorrectly) that much of the remaining context *was*
useful, and that it could have answered some of Kuninori's questions, if
he chose to dig himself. As admitted in the commit message, I don't
really understand all of the relationships here, so it's hard to
highlight "only the relevant sections".

I'm sorry that my post did not meet your standards though. Next time
I'll just post a revert with little context and no attempt to understand
what actually went wrong.

Regards,
Brian
