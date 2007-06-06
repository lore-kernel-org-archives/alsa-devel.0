From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Re: Power management state flow in ALSA
Date: Wed, 6 Jun 2007 13:37:00 +0530
Message-ID: <8d6898730706060107r2952c8d2i843ba68b0b8c6b40@mail.gmail.com>
References: <8d6898730705292322w2dbf2a2fu4761370c4cc7ea16@mail.gmail.com>
	<s5h8xb6hbzd.wl%tiwai@suse.de>
	<8d6898730705300306g3f32f5e8yad6770a4eee1851a@mail.gmail.com>
	<s5h4pluhajo.wl%tiwai@suse.de>
	<8d6898730705300336l4db252e6pa4b7b257de4ed6eb@mail.gmail.com>
	<s5hy7j6fuhd.wl%tiwai@suse.de>
	<1180700301.26032.50.camel@localhost.localdomain>
	<8d6898730706032158i341b70d3j32c9566532395d18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 417DA243D0
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Jun 2007 10:07:03 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id j2so73410nzf
	for <alsa-devel@alsa-project.org>; Wed, 06 Jun 2007 01:07:01 -0700 (PDT)
In-Reply-To: <8d6898730706032158i341b70d3j32c9566532395d18@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Liam,

In soc_resume()
 we should do this
          snd_power_change_state(codec->card, SNDRV_CTL_POWER_D0);
instead of
        snd_power_change_state(codec->card, SNDRV_CTL_POWER_D3hot);

Because snd_pcm_resume in pcm_native.c expects the card to be in
SNDRV_CTL_POWER_D0 state. Other ioctl will wait forever.

static int snd_pcm_resume(struct snd_pcm_substream *substream)
{
	struct snd_card *card = substream->pcm->card;
	int res;

	snd_power_lock(card);
	if ((res = snd_power_wait(card, SNDRV_CTL_POWER_D0)) >= 0)
		res = snd_pcm_action_lock_irq(&snd_pcm_action_resume, substream, 0);
	snd_power_unlock(card);
	return res;
}


One more thing why we are using
	snd_power_change_state(codec->card, SNDRV_CTL_POWER_D3cold);
every other driver is doing
snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);

SNDRV_CTL_POWER_D3cold is true for deep sleep where power to the
controller is switched off .

In sleep, only clock to the controller is switched off.

Nobin Mathew









On 6/4/07, Nobin Mathew <nobin.mathew@gmail.com> wrote:
> Liam
>
> I will get back, i need to set up the board
>
> On 6/1/07, Liam Girdwood <lg@opensource.wolfsonmicro.com> wrote:
> > Nobin,
> >
> > Can you try the following patch :-
> >
> > http://opensource.wolfsonmicro.com/cgi-bin/gitweb/gitweb.cgi?p=linux-2.6-asoc;a=commit;h=6c868238a5e083dca4d74439a7fd467b5c7726b0
> >
> > This will notify pcm's of their suspend state.
> >
> > Liam
> >
> > On Wed, 2007-05-30 at 12:58 +0200, Takashi Iwai wrote:
> > > At Wed, 30 May 2007 16:06:54 +0530,
> > > Nobin Mathew wrote:
> > > >
> > > > I am writing an ASoC driver, where i can place these calls
> > > >
> > > > snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
> > > > snd_pcm_suspend_all(chip->pcm[i]);
> > > >
> > > > and snd_power_change_state(card, SNDRV_CTL_POWER_D0);
> > > >
> > > >
> > > > In soc-core.c ?
> > >
> > > I suppose so.
> > > In soc_suspend() and soc_resume(), you can get the card instance from
> > > codec->card, at least.
> > >
> > > But currently SoC doesn't keep the PCM instances, so it cannot be
> > > implemented as it is...  Liam, any plan or known issue regarding this?
> > >
> > >
> > > Takashi
> >
> >
>
