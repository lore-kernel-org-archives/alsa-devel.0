From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm9713: add gpio chip
Date: Thu, 5 Nov 2015 09:48:56 +0000
Message-ID: <20151105094856.GE2549@ck-lbox>
References: <1446657164-25012-1-git-send-email-robert.jarzmik@free.fr>
 <20151104183322.GD2549@ck-lbox>
 <87oaf9bls9.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87oaf9bls9.fsf@belgarion.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 04, 2015 at 08:35:18PM +0100, Robert Jarzmik wrote:
> Charles Keepax <ckeepax@opensource.wolfsonmicro.com> writes:
> 
> > On Wed, Nov 04, 2015 at 06:12:44PM +0100, Robert Jarzmik wrote:
> >> The Wolfson WM9713 provides 8 GPIOs. If the gpiolib is compiled in the
> >> kernel, declare a gpio chip.
> >> 
> >> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> >> ---
> >
> > You should probably make a seperate driver within GPIO for this
> > and then tie the two together, using an MFD. I appreciate that is
> > more work but it is likely a nicer solution overall.
> 
> I'd like to first have a confirmation from :
>  - Mark (Brown)
>  - and Lee (Jones)

That seems like a good idea to me as well :-)

Thanks,
Charles
