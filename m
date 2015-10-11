From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH v2] ALSA: bebob: constify snd_bebob_rate_spec
 structures
Date: Sun, 11 Oct 2015 08:08:37 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1510110807340.2057@localhost6.localdomain6>
References: <1444484390-22158-1-git-send-email-Julia.Lawall@lip6.fr> <5619308C.7000601@sakamocchi.jp> <alpine.DEB.2.02.1510102323080.2053@localhost6.localdomain6> <5619DA57.6010705@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <5619DA57.6010705@sakamocchi.jp>
Sender: kernel-janitors-owner@vger.kernel.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org



On Sun, 11 Oct 2015, Takashi Sakamoto wrote:

> Hi,
> 
> On Oct 11 2015 06:24, Julia Lawall wrote:
> > The structures of type snd_bebob_clock_spec, snd_bebob_rate_spec,
> > snd_bebob_meter_spec, and snd_bebob_spec are never modified after they are
> > initialized.  Make them all const.
> > 
> > Done with the help of Coccinelle.
> > 
> > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> > 
> > ---
> > 
> > v2: extend to snd_bebob_clock_spec, snd_bebob_meter_spec, and 
> > snd_bebob_spec structures.
> > 
> >  sound/firewire/bebob/bebob.c           |    2 +-
> >  sound/firewire/bebob/bebob.h           |   32 ++++++++++++++++----------------
> >  sound/firewire/bebob/bebob_focusrite.c |   26 +++++++++++++-------------
> >  sound/firewire/bebob/bebob_maudio.c    |   32 ++++++++++++++++----------------
> >  sound/firewire/bebob/bebob_pcm.c       |    2 +-
> >  sound/firewire/bebob/bebob_proc.c      |    6 +++---
> >  sound/firewire/bebob/bebob_stream.c    |    6 +++---
> >  sound/firewire/bebob/bebob_terratec.c  |   10 +++++-----
> >  sound/firewire/bebob/bebob_yamaha.c    |    6 +++---
> >  9 files changed, 61 insertions(+), 61 deletions(-)
> 
> Tested-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> 
> Thank you to include my extra request and spend more time for this patch ;)
> 
> But I prefer to change the title of this patch to 'ALSA: bebob: constify
> some structures because they are never modified' or something like it
> because this patch is not only for 'struct snd_bebob_rate_spec'.

Sorry not to have paid attention to that.  I will send it again.

julia
