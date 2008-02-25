From: "Alexandre BOUIN" <a.bouin@kerlink.fr>
Subject: Re: ASoC - Output widgets
Date: Mon, 25 Feb 2008 10:39:15 +0100
Message-ID: <49814.7063110538$1203932419@news.gmane.org>
References: <20080223155758.GA7454@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from scanner-relay-corvus2.pulsation.fr
	(scanner-relay-corvus2.pulsation.fr [80.74.64.70])
	by alsa0.perex.cz (Postfix) with SMTP id 9BF611038A0
	for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2008 10:39:26 +0100 (CET)
In-Reply-To: <20080223155758.GA7454@sirena.org.uk>
Content-Language: fr
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> 
> On Fri, Feb 22, 2008 at 05:39:54PM +0100, Alexandre BOUIN wrote:
> 
> > Using ASoC layer, I'd like to perform this example behaviour with my
> widgets
> > :
> >  - 1 output mixer MIXOUT is connected to 2 outputs OUT1 and OUT2
> >  - OUT1 and OUT2 can be powered independently
> > This seems easy, but atm while one is powered, the other is powered
> too.
> 
> I may be misunderstanding what you're doing here but I suspect that
> you need to use snd_soc_dapm_set_endpoint() to mark the outputs that
> are
> not in use as disconnected.  If you do that then then DAPM will not
> power up the relevant output path.
> 
> You can do this at any point at run time - see sound/soc/pxa/tosa.c for
> an example of this.

I've used tosa board as an example. 
Maybe I've done something wrong but when I play sound files, both amplifier
are powered together.
After playing this track, both amplifier are shutdown together.

As it should be an audio path problem, I detail you my audio path here : 
 - 1 SND_SOC_DAPM_MIXER is connected to 2 SND_SOC_DAPM_PGA with power
control.
 - each PGA is connected to an SND_SOC_DAPM_OUTPUT
 - according to tosa example : 
    - first OUTPUT is connected to a SND_SOC_DAPM_HP defined as endpoint
    - second OUTPUT is connected to a SND_SOC_DAPM_SPK defined as endpoint
this SPK is set disconnected in my tosa_ac97_init -like function

Using DPAM debug traces, I've notice that both PGAs are powered regardless
of their ON/OFF status.
 
Regards,
Alex.
