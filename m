From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: smart and automatic use of dmix and dsnoop - feature
 suggestion.
Date: Mon, 17 Nov 2003 19:50:14 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0311171944280.16992@pnote.perex-int.cz>
References: <200311141221.hAECLqlT003018@oud.linuxaudiosystems.com>
 <s5hfzgnjc88.wl@alsa2.suse.de> <200311171716.35418.mark@egghead.free-online.co.uk>
 <200311171924.40388.pwk.linuxfan@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200311171924.40388.pwk.linuxfan@gmx.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Kirk <pwk.linuxfan@gmx.de>
Cc: Mark Hubbard <mark@egghead.free-online.co.uk>, Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 17 Nov 2003, Peter Kirk wrote:

> WARNING: Unsanitized content follows.
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Am Montag, 17. November 2003 18:16 schrieb Mark Hubbard:
> > Peter Kirk has an important point. Default dmix ("smart" could be a
> > misnomer) will only work as the default pcm, therefore if one application
> > is set-up to use surround51 and another set-up to use default, then nothing
> > is going to be mixed. It would be better, for the sake of simplicity and
> > ALSA's target user, to abandon the various pcm definitions and only use
> > default which would work with all set-ups....I believe this is what Peter
> > means by "smart".
> Well,
>
> no smart dmix is no "misnomer". What I mean with it is: a implementation of
> dmix that only starts to mix if there is a need to do it - as long as the
> soundcard can handle streams without mixing the smart dmix will not do
> anything, except pass untouched streams to the hardware...when the first
> stream that would exceed hardware limitation is sent to the sound device,
> smart dmix would start mixing this stream into one of the existing ones.

The problem is that it's not possible. If you have one application which
settled parameters with alsa-lib (and alsa driver) we cannot reroute this
stream to dmix. The dmix plugin works with some assumptions (predefined
parameters applied at start of first application) and all clients
(applications) must share same parameters, of course.

> You name a device I didnt know... "surround51". But, since this is what I call
> a "consumer app device", smart dmix would lure behind that too, and apply
> mixing magic if necessary.

It's not too easy.

I think that we should go in another direction. In my eyes, the best thing
would be to create a very user friendly (graphical) configuration tool for
alsa-lib which offers with a few clicks to choose dmix, plug or raw access
to devices. Many users want to do also some "additional" things like
stereo stream expansion to rear speakers and so on.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
