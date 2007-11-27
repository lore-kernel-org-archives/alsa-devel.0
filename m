From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: rme hdsp pcmcia (and probably pci) broken
Date: Tue, 27 Nov 2007 11:18:30 -0800
Message-ID: <1196191110.22601.15.camel@cmn3.stanford.edu>
References: <1196127903.15009.34.camel@cmn3.stanford.edu>
	<s5hejebkd2g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.stanford.edu (smtp3.Stanford.EDU [171.67.20.26])
	by alsa0.perex.cz (Postfix) with ESMTP id CF75224A79
	for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2007 20:18:36 +0100 (CET)
In-Reply-To: <s5hejebkd2g.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, planetccrma@ccrma.Stanford.EDU
List-Id: alsa-devel@alsa-project.org

On Tue, 2007-11-27 at 14:55 +0100, Takashi Iwai wrote:
> At Mon, 26 Nov 2007 17:45:03 -0800,
> Fernando Lopez-Lezcano wrote:
> > 
> > Hi, anyone has a pcmcia rme card running? And working? With a reasonably
> > recent alsa? (this probably applies also for the regular pci rme cards,
> > I've had reports on the Planet CCRMA list about problems that sound
> > similar to this one). 
> > 
> > My test setup is on fc7 running:
> > 
> >   alsa-lib 1.0.15
> >   alsa-tools 1.0.15
> >   alsa-firmware 1.0.15
> > [MUNCH]
> > 2.6.22.10-1.rt9.1 + alsa driver modules from
> > hg20071012
> > --> BROKEN
> 
> The only significant change in hdsp.c during this is the patch below.
> Could you try to revert?

Reverting the patch makes the card play sound as before, so the patch is
definitely broken. Regretfully hdspmixer seems to no longer display the
vu meters and changing the presets does not seem to have an effect, it
probably needs something to be reverted as well to match?

-- Fernando


> # HG changeset patch
> # User tiwai
> # Date 1188556434 -7200
> # Node ID d2e58f75d204bc01677c7f97e08ec067f8026dbc
> # Parent  56d4c7f294f63f63b93d9d1fbfda5570149500f8
> hdsp - Add support for latset RME9632 revisions
> 
> added support for the latest revision of the 9632 (and hopefully a few
> following ones). The DSP matrix was not working because of wrong
> identification of the card in this part of the code.
> 
> Signed-off-by: Remy Bruno <remy.bruno@trinnov.com>
> 
> diff -r 56d4c7f294f6 -r d2e58f75d204 pci/rme9652/hdsp.c
> --- a/pci/rme9652/hdsp.c	Fri Aug 31 12:21:08 2007 +0200
> +++ b/pci/rme9652/hdsp.c	Fri Aug 31 12:33:54 2007 +0200
> @@ -606,28 +606,28 @@ static void snd_hdsp_9652_enable_mixer (
>  
>  static int hdsp_playback_to_output_key (struct hdsp *hdsp, int in, int out)
>  {
> -	switch (hdsp->firmware_rev) {
> -	case 0xa:
> +	switch (hdsp->io_type) {
> +	case Multiface:
> +	case Digiface:
> +	default:
>  		return (64 * out) + (32 + (in));
> -	case 0x96:
> -	case 0x97:
> -	case 0x98:
> +	case H9632:
>  		return (32 * out) + (16 + (in));
> -	default:
> +	case H9652:
>  		return (52 * out) + (26 + (in));
>  	}
>  }
>  
>  static int hdsp_input_to_output_key (struct hdsp *hdsp, int in, int out)
>  {
> -	switch (hdsp->firmware_rev) {
> -	case 0xa:
> +	switch (hdsp->io_type) {
> +	case Multiface:
> +	case Digiface:
> +	default:
>  		return (64 * out) + in;
> -	case 0x96:
> -	case 0x97:
> -	case 0x98:
> +	case H9632:
>  		return (32 * out) + in;
> -	default:
> +	case H9652:
>  		return (52 * out) + in;
>  	}
>  }
