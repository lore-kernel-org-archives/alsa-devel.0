From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] cs4236: cs4232 and cs4236 driver merge to
 solve PnP BIOS detection
Date: Mon, 16 Feb 2009 18:44:21 +0100
Message-ID: <20090216184421.31fe21da.krzysztof.h1@poczta.fm>
References: <20090216074351.0316c9ab.krzysztof.h1@poczta.fm>
	<s5hd4diiuix.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id E9EE5243EB
	for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2009 18:39:50 +0100 (CET)
In-Reply-To: <s5hd4diiuix.wl%tiwai@suse.de>
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
Cc: Alsa-devel <alsa-devel@alsa-project.org>, Stanley Pinchak <stanley.pinchak@gmail.com>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 16 Feb 2009 10:46:30 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Mon, 16 Feb 2009 07:43:51 +0100,
> Krzysztof Helt wrote:
> > 
> > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > 
> > Also, the patch adds recognition if the chip is cs4236b+
> > or earlier part. This unifies drivers for both cs4232
> > and cs4236+ chips. It allows to use the PnP BIOS
> > detection for the cs4236+ chips. Previously, only
> > the snd-cs4232 could be detected by the PnP BIOS.
> > 
> > The cs4232+ cards reports two separate PnP BIOS ids.
> > 
> > The patch adds search for the second id to find out
> > resources assigned to a control port.
> > 
> > Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> Thanks for the patch.
> Unfortunately the patch can't be applied to the latest sound git tree.
> Could you rebase?
> 

I based it at on the latest linux-next tree. The cs4236.c file is the
same as the latest cs4236.c on the web interface to alsa-kernel tree.

Could you report me error messages about applying the patch?

> >  # Toplevel Module Dependency
> >  obj-$(CONFIG_SND_CS4231) += snd-cs4231.o
> > -obj-$(CONFIG_SND_CS4232) += snd-cs4232.o
> > +obj-$(CONFIG_SND_CS4232) += snd-cs4232.o snd-cs4236-lib.o
> >  obj-$(CONFIG_SND_CS4236) += snd-cs4236.o snd-cs4236-lib.o
> 
> Let's remove cs4232 completely, then.  Otherwise this will give the
> duplicated symbols errors.  It's fine to rename to cs423x, for
> example, if you'd like.  (And don't forget to change Kconfig entries.)
> 

I would like to leave the snd-cs4236 name as it at the moment. If you
want to rename it please do it with the separate patch so git system
can detect renaming (only file name change, no internal changes).

> In anyway, we can provide module aliases for old module names.
> 

I am adding alias for the snd_cs4232.

> 
> > +	if (chip->hardware & WSS_HW_CS4236B_MASK) {
> > +		snd_wss_free(chip);
> 
> It's not so nice, but acceptable as a first step for integration.
> 

I could not find anything better that works.

Regards,
Krzysztof

----------------------------------------------------------------------
Zobacz najlepsze oferty nieruchomosci!
Sprawdz >>> http://link.interia.pl/f205d
