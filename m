From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: hdspmixer broken for 96khz
Date: Sun, 3 Apr 2011 12:25:16 +0200
Message-ID: <20110403102516.GJ28811@ltw.loris.tv>
References: <in74oi$qce$1@dough.gmane.org>
	<20110403081606.GG28811@ltw.loris.tv>
	<201104031139.41395.tim@klingt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id DDCA5243E9
	for <alsa-devel@alsa-project.org>;
	Sun,  3 Apr 2011 12:25:43 +0200 (CEST)
Received: from localhost (ltw.loris.tv [127.0.0.1])
	by ltw.loris.tv (Postfix) with ESMTP id C6FA61AC6F8
	for <alsa-devel@alsa-project.org>;
	Sun,  3 Apr 2011 12:25:34 +0200 (CEST)
Received: from ltw.loris.tv ([127.0.0.1])
	by localhost (ltw.loris.tv [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id PeSpPHkY2+Yn for <alsa-devel@alsa-project.org>;
	Sun,  3 Apr 2011 12:25:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201104031139.41395.tim@klingt.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 03, 2011 at 11:39:41AM +0200, Tim Blechmann wrote:

> > > the updated hdspmixer doesn't work for 96khz any more. the 44.1/48 khz
> > > versions are drawn correctly, the 88.2/96 khz version hides all
> > > controls, so just the menu is visible.
> > 
> > I've seen "both", a *working* hdspmixer at 96k and all hidden controls.
> > The latter could be caused by wrongly initialized or restored presets.
> > 
> > Can you try to activate the controls in the View menu again? Maybe even
> > the shortcuts work: I for Input section, P for Playback and O for
> 
> ok, after removing my old hdspmixer configuration file, it seems to
> work. would be good to have a more robust behavior, since the current
> behavior is quite confusing and people may have rather complex mixer
> setups, which they would need to regenerate.

I thought I have paid attention to migrate the settings from the old
file format to the new one:

   http://git.alsa-project.org/?p=alsa-tools.git;a=commit;h=287bc091e9dba539399ba4540c60623dee1a3bc3

I wonder what went wrong. If you like, feel free to further dig into
this.

However, the current on-disk format is utterly stupid, it has no
meta-information at all, it will break if the order of cards change.

The whole hdspmixer is a dead-end, even supporting more than one card in
a single app complicates things like hell (I have an upcoming patch
series. Took me 6hrs or so just to get switching back/forth between two
cards right).

So the next thing I'd like to implement is to limit hdspmixer to a
single card and then run a new instance on the second, third, 4th a.s.o.
card. Like alsamixer -c 1: hdspmixer -c 1, maybe -c reflecting the ALSA
card number as found in /proc/asound/cards.

Anyway, the whole codebase is subtle broken, and the best approach would
be a rewrite from scratch. Maybe it makes sense to merge hdsp and hdspm,
first. Comments welcome. ;)


Cheers

-- 
mail: adi@thur.de  	http://adi.thur.de	PGP/GPG: key via keyserver
