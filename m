From: "Daniele (Mastro)" <daniele.bilug@gmail.com>
Subject: Re: Notebook Toshiba satellite x200-21g with realtek
 snd-hda-intel audio device still not supported (codec ALC268)
Date: Fri, 21 Dec 2007 11:14:31 +0100
Message-ID: <476B9207.3010007@gmail.com>
References: <47672BCB.9080608@gmail.com>	<476912F3.8090609@gmail.com>	
	<476A2BCC.4060109@gmail.com> <s5h1w9h4g5d.wl%tiwai@suse.de>	
	<476B031C.1070304@gmail.com>
	<1198199454.26685.109.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.189])
	by alsa0.perex.cz (Postfix) with ESMTP id E9A0C2446A
	for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2007 11:14:36 +0100 (CET)
Received: by fk-out-0910.google.com with SMTP id f40so367640fka.0
	for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2007 02:14:36 -0800 (PST)
In-Reply-To: <1198199454.26685.109.camel@razman.gruemaster.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tobin Davis <tdavis@dsl-only.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Tobin Davis ha scritto:
> Daniele, 
> 
> Normally I would have jumped in earlier to help, but I am swamped,
> between my real job (non-alsa related), school (BS IT degree program),
> and recent flooding activity in Oregon a couple of weeks ago.

i'm swamped too for many reason and haven't much time...
anyway i don't have hurry.. i just would like my audio card to work one
day :)

> What I can do, is ask you to download and run
> http://bulletproof.servebeer.com/alsa/scripts/alsa-info.sh .
> 
> Also, rebuild the modules with "./configure --with-cards=snd-hda-intel
> --with-debug=detect" and load them with "model=auto".  This will leave
> output in dmesg as to what the driver finds in bios.  It's not always
> reliable, but it helps.

i'll do this and keep you informed, thanks for the advice (i forgot to
mention my card has a build in MIDI support... should i compile it with
the option sequencer? and why don't you put inside the "oss" too?

> As to 5.1 surround, the only way to get 6 channel output would be
> through the SPDIF port, as it acts as a digial passthrough.  If your
> system has a subwoofer, it is very likely tied into the main speaker
> out, just like the 2.1 speakers you can get at most stores.

i still didn't search for this.. i'll do!
i can tell you i've 4 speaker on the front of my notebook (may be they
are only 2 channel)
and a subwoofer on the bottom of it

i'll bring here as much info i can find on my audio system and will
start to try what you said... but i'll do this in spare time so may be
it will take some time

thank you again!

- --
Daniele
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHa5IHgSF24OYDe4YRAh0OAJ91OvLARvQpFfA9ecpNsImDIumX9wCcDkAR
bpqKYeVyNf3k+O5kYUkyd3w=
=Bi0E
-----END PGP SIGNATURE-----
