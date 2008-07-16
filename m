From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [Alsa-user] is this card supported by ALSA?
Date: Wed, 16 Jul 2008 20:50:21 +0200
Message-ID: <487E42ED.7050000@keyaccess.nl>
References: <BLU137-W51E7DF3E0152023F07FC0C958F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id AADDA2436E
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jul 2008 20:48:27 +0200 (CEST)
In-Reply-To: <BLU137-W51E7DF3E0152023F07FC0C958F0@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Landis McGauhey <b3zdomny@hotmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-user@lists.sourceforge.net, devel <alsa-devel@alsa-project.org>, alsa@sc8-sf-spam2.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 16-07-08 20:00, Landis McGauhey wrote:

> OK, this is interesting:
> 
> # patch -p1 -r < ens1371-ac97_reset_hack.diff=
> bash:ens1371-ac97_reset_hack.diff: No such file or directory
> 
> # patch -p1 -r < ens1371-ac97.diff
> bash: ens1371-ac97.diff: No such file or directory
> 
> Go figure.

Of course. You've done this a number of times now, so I took for granted 
that by now you'd understand to put in the path yourself. You saved 
these diff's from earlier mssages.

> Attached are two high-res pix of the card. The smallest chips were
> just too darned small for me to read the printing; maybe you can
> magnify the pix and make something of them.

A CT4730. You have an onboard amp (and it's disabled -- setting both the 
jumpers to the SPK position enables it but keeping it disabled is better 
if you don't really need it; these opamps suck).

Moreover, the AC97 codec seems integrated in the EV1938. Just found a 
patch for FreeBSD following up a similar report for your card. Will look 
at it tomorrow.

Rene.
