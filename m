From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: looping S/PDIF data
Date: Thu, 19 Jun 2008 14:39:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0806191435270.1798@tm8103-a.perex-int.cz>
References: <20080531112606.5884a1c9@mjolnir.drzeus.cx>
	<20080617215504.3203a5ed@mjolnir.drzeus.cx>
	<4858B84B.4030800@keyaccess.nl> <s5hej6t91u1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 71E9910381F
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Jun 2008 14:39:08 +0200 (CEST)
In-Reply-To: <s5hej6t91u1.wl%tiwai@suse.de>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Rene Herman <rene.herman@keyaccess.nl>, Pierre Ossman <drzeus@drzeus.cx>, ALSA devel <alsa-devel@alsa-project.org>, mulix@mulix.org
List-Id: alsa-devel@alsa-project.org

On Thu, 19 Jun 2008, Takashi Iwai wrote:

> At Wed, 18 Jun 2008 09:24:59 +0200,
> Rene Herman wrote:
> > 
> > On 17-06-08 21:55, Pierre Ossman wrote:
> > 
> > > Ping
> > > 
> > > On Sat, 31 May 2008 11:26:06 +0200
> > > Pierre Ossman <drzeus-list@drzeus.cx> wrote:
> > > 
> > >> I have a minor annoyance with the snd_trident driver that I was hoping
> > >> you might have a fix for:
> > >>
> > >> Pausing the output does not seem to take on the S/PDIF output. Analog
> > >> outputs properly stop in their tracks, but the S/PDIF port keeps
> > >> looping the current data buffer, which gives a rather unpleasant end
> > >> result. :)
> > 
> > Try the alsa-devel list...
> 
> Does the patch below help?
> 
> 
> Takashi
> 
> diff --git a/sound/pci/trident/trident_main.c b/sound/pci/trident/trident_main.c
> index bbcee2c..916d4b8 100644
> --- a/sound/pci/trident/trident_main.c
> +++ b/sound/pci/trident/trident_main.c
> @@ -1593,7 +1593,11 @@ static int snd_trident_trigger(struct snd_pcm_substream *substream,
>  			outb(trident->spdif_pcm_ctrl, TRID_REG(trident, NX_SPCTRL_SPCSO + 3));
>  		} else {
>  			outl(trident->spdif_pcm_bits, TRID_REG(trident, SI_SPDIF_CS));
> -			val = inl(TRID_REG(trident, SI_SERIAL_INTF_CTRL)) | SPDIF_EN;
> +			val = inl(TRID_REG(trident, SI_SERIAL_INTF_CTRL));
> +			if (go)
> +				val |= SPDIF_EN;
> +			else
> +				val &= ~SPDIF_EN;
>  			outl(val, TRID_REG(trident, SI_SERIAL_INTF_CTRL));
>  		}
>  	}

I don't think that this patch is correct. DMA transfers should be disabled 
by:

outl(what, TRID_REG(trident, T4D_STOP_B));
outl(val, TRID_REG(trident, T4D_AINTEN_B));

lines. Adding &= ~SPDIF_EN can disable output from AC97 to S/PDIF as well.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
