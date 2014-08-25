From: Jurgen Kramer <gtmkramer@xs4all.nl>
Subject: Re: [PATCH] pcm/kernel: Add DSD formats silence
 patterns
Date: Mon, 25 Aug 2014 10:18:10 +0200
Message-ID: <1408954690.3063.1.camel@xs4all.nl>
References: <1408867448-13373-1-git-send-email-gtmkramer@xs4all.nl>
 <s5hlhqdt4m4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-vbr7.xs4all.nl (smtp-vbr7.xs4all.nl [194.109.24.27])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BDED2625FE
 for <alsa-devel@alsa-project.org>; Mon, 25 Aug 2014 10:18:12 +0200 (CEST)
In-Reply-To: <s5hlhqdt4m4.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2014-08-25 at 09:23 +0200, Takashi Iwai wrote:
> At Sun, 24 Aug 2014 10:04:08 +0200,
> Jurgen Kramer wrote:
> > 
> > This patch adds the silence patterns for the DSD sample formats, kernel side.
> > 
> > Signed-off-by: Jurgen Kramer <gtmkramer@xs4all.nl>
> 
> A similar patch has been already submitted and merged :)
> 
OK thanks, must have missed it.

BTW I could not find it in your git repo or current kernel git, where is
is hiding? :-)

Jurgen

> thanks,
> 
> Takashi
> 
> > ---
> >  sound/core/pcm_misc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/sound/core/pcm_misc.c b/sound/core/pcm_misc.c
> > index 4560ca0..2c6fd80 100644
> > --- a/sound/core/pcm_misc.c
> > +++ b/sound/core/pcm_misc.c
> > @@ -142,11 +142,11 @@ static struct pcm_format_data pcm_formats[(INT)SNDRV_PCM_FORMAT_LAST+1] = {
> >  	},
> >  	[SNDRV_PCM_FORMAT_DSD_U8] = {
> >  		.width = 8, .phys = 8, .le = 1, .signd = 0,
> > -		.silence = {},
> > +		.silence = { 0x69 },
> >  	},
> >  	[SNDRV_PCM_FORMAT_DSD_U16_LE] = {
> >  		.width = 16, .phys = 16, .le = 1, .signd = 0,
> > -		.silence = {},
> > +		.silence = { 0x69, 0x69 },
> >  	},
> >  	/* FIXME: the following three formats are not defined properly yet */
> >  	[SNDRV_PCM_FORMAT_MPEG] = {
> > -- 
> > 1.9.3
> > 
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
