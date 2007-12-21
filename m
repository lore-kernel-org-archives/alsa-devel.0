From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Notebook Toshiba satellite x200-21g with
	realtek	snd-hda-intel audio device still not supported (codec
	ALC268)
Date: Thu, 20 Dec 2007 17:10:54 -0800
Message-ID: <1198199454.26685.109.camel@razman.gruemaster.com>
References: <47672BCB.9080608@gmail.com>	<476912F3.8090609@gmail.com>
	<476A2BCC.4060109@gmail.com> <s5h1w9h4g5d.wl%tiwai@suse.de>
	<476B031C.1070304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 6381024886
	for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2007 02:10:58 +0100 (CET)
In-Reply-To: <476B031C.1070304@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Daniele (Mastro)" <daniele.bilug@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Daniele, 

Normally I would have jumped in earlier to help, but I am swamped,
between my real job (non-alsa related), school (BS IT degree program),
and recent flooding activity in Oregon a couple of weeks ago.

What I can do, is ask you to download and run
http://bulletproof.servebeer.com/alsa/scripts/alsa-info.sh .

Also, rebuild the modules with "./configure --with-cards=snd-hda-intel
--with-debug=detect" and load them with "model=auto".  This will leave
output in dmesg as to what the driver finds in bios.  It's not always
reliable, but it helps.

As to 5.1 surround, the only way to get 6 channel output would be
through the SPDIF port, as it acts as a digial passthrough.  If your
system has a subwoofer, it is very likely tied into the main speaker
out, just like the 2.1 speakers you can get at most stores.

Tobin

On Fri, 2007-12-21 at 01:04 +0100, Daniele (Mastro) wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Takashi Iwai ha scritto:
> > I recommend you to hack the driver code by yourself.
> 
> i take this as a "no we will not do it"
> 
> but i understand it.. keep reading
> 
> > The coding itself isn't too difficult.  The problem is the guess work,
> > which PIN really corresponds to which I/O, and what control is missing
> > (EAPD, GPIO, etc).
> 
> ok...
> i know a bit of C programming, not much to be honest.. but i have no
> idea on where/how to watch for "PIN" and things like that... I don't
> know what EAPD, GPIO etc. are
> i really would like to do it myself but i don't know where to start...
> if you can give me a link that explain how it work and help me in the
> process i'll do my best
> 
> but without any help i don't know what to do.. and i'm worried to damage
> my audio card if i do something wrong...
> 
> > What I'm wondering is how to support 5.1 output.  The ALC268 codec is
> > at most for 4 channels (2 + 2).  Are you sure that you can get 5.1
> > distinct outputs?
> 
> hum.. you put a doubt in me..
> i'm sure there's a subwoofer but i'm not sure it should be 6 channel...
> i try to check in some way..
> i never booted up Vista in this notebook... i guess i could try it to
> check this or may be i found something googling... i let you know..
> 
> i'm a bit sad that you haven't time/men for my chipset (specially for
> the headphone jack not working and the mic) but i understand it... i
> hope you will help me to learn and fix my problem alone helping the
> comunity and your project
> 
> i'll wait your reply
> best regards :)
> - --
> Daniele
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.6 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org
> 
> iD8DBQFHawMcgSF24OYDe4YRAgSsAKCw/UD/OIfZIN1uz54EYFaxR9VC3QCg466b
> nDJ0hV9iaSWmAt3LzeqtrhM=
> =ldxH
> -----END PGP SIGNATURE-----
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Tobin Davis  


In theory, there is no difference between theory and practice.  In practice,
there is.
