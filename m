From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: Power management state flow in ALSA
Date: Fri, 01 Jun 2007 13:18:21 +0100
Message-ID: <1180700301.26032.50.camel@localhost.localdomain>
References: <8d6898730705292322w2dbf2a2fu4761370c4cc7ea16@mail.gmail.com>
	<s5h8xb6hbzd.wl%tiwai@suse.de>
	<8d6898730705300306g3f32f5e8yad6770a4eee1851a@mail.gmail.com>
	<s5h4pluhajo.wl%tiwai@suse.de>
	<8d6898730705300336l4db252e6pa4b7b257de4ed6eb@mail.gmail.com>
	<s5hy7j6fuhd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 22E252462C
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Jun 2007 14:18:26 +0200 (CEST)
In-Reply-To: <s5hy7j6fuhd.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nobin Mathew <nobin.mathew@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Nobin,

Can you try the following patch :-

http://opensource.wolfsonmicro.com/cgi-bin/gitweb/gitweb.cgi?p=linux-2.6-asoc;a=commit;h=6c868238a5e083dca4d74439a7fd467b5c7726b0

This will notify pcm's of their suspend state.

Liam

On Wed, 2007-05-30 at 12:58 +0200, Takashi Iwai wrote:
> At Wed, 30 May 2007 16:06:54 +0530,
> Nobin Mathew wrote:
> > 
> > I am writing an ASoC driver, where i can place these calls
> > 
> > snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
> > snd_pcm_suspend_all(chip->pcm[i]);
> > 
> > and snd_power_change_state(card, SNDRV_CTL_POWER_D0);
> > 
> > 
> > In soc-core.c ?
> 
> I suppose so.
> In soc_suspend() and soc_resume(), you can get the card instance from
> codec->card, at least.
> 
> But currently SoC doesn't keep the PCM instances, so it cannot be
> implemented as it is...  Liam, any plan or known issue regarding this?
> 
> 
> Takashi
