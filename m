From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] dapm_new_mixer and 32 bytes limitation
Date: Mon, 21 Jan 2008 12:05:55 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0801211204200.12394@tm8103.perex-int.cz>
References: <87r6geevtb.fsf@polgara.paysbobval> <s5h4pd7fnz8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 831DE243D6
	for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2008 12:05:56 +0100 (CET)
In-Reply-To: <s5h4pd7fnz8.wl%tiwai@suse.de>
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
Cc: Robert Jarzmik <rjarzmik@free.fr>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 21 Jan 2008, Takashi Iwai wrote:

> At 18 Jan 2008 21:13:36 +0100,
> Robert Jarzmik wrote:
> > 
> > diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> > index ea20138..f22a1bb 100644
> > --- a/sound/soc/soc-dapm.c
> > +++ b/sound/soc/soc-dapm.c
> > @@ -281,7 +281,7 @@ static int dapm_new_mixer(struct snd_soc_codec *codec,
> >  	struct snd_soc_dapm_widget *w)
> >  {
> >  	int i, ret = 0;
> > -	char name[32];
> > +	char name[44];
> 
> Let's add a global const in asound.h instead of using a magic number
> everywhere.

What about this:

	int namelen = sizeof(w->kcontrols[0].name);

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
