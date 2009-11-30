From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/2] ALSA: AACI: fix recording bug
Date: Mon, 30 Nov 2009 10:22:28 +0000
Message-ID: <20091130102228.GD1638@n2100.arm.linux.org.uk>
References: <E1NEmoZ-0001dQ-St@rmk-PC.arm.linux.org.uk>
	<s5hr5rg9w7o.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 2EC8C103804
	for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2009 11:22:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hr5rg9w7o.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 30, 2009 at 10:51:39AM +0100, Takashi Iwai wrote:
> At Sun, 29 Nov 2009 16:39:59 +0000,
> Russell King - ARM Linux wrote:
> > 
> > pcm->r[1].slots is the double rate slot information, not the
> > capture information.  For capture, 'pcm' will already be the
> > capture ac97 pcm structure.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  sound/arm/aaci.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
> > index 1456fc7..eb715e7 100644
> > --- a/sound/arm/aaci.c
> > +++ b/sound/arm/aaci.c
> > @@ -518,7 +518,7 @@ static int aaci_pcm_hw_params(struct snd_pcm_substream *substream,
> >  	else
> >  		err = snd_ac97_pcm_open(aacirun->pcm, params_rate(params),
> >  					params_channels(params),
> > -					aacirun->pcm->r[1].slots);
> > +					aacirun->pcm->r[0].slots);
> 
> Then we can get rid of the whole if check and the else block here.
> The arguments to be passed are identical for both playback and capture
> directions.

Yes.  That's a cleanup patch (and as such a separate patch).  Since
we're this late in the -rc cycle, I'd prefer to do just minimal
changes.
