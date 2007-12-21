From: "Daniele (Mastro)" <daniele.bilug@gmail.com>
Subject: Re: Notebook Toshiba satellite x200-21g with realtek
 snd-hda-intel audio device still not supported (codec ALC268)
Date: Fri, 21 Dec 2007 01:04:44 +0100
Message-ID: <476B031C.1070304@gmail.com>
References: <47672BCB.9080608@gmail.com>	<476912F3.8090609@gmail.com>	<476A2BCC.4060109@gmail.com>
	<s5h1w9h4g5d.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by alsa0.perex.cz (Postfix) with ESMTP id 43ED32487D
	for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2007 01:04:49 +0100 (CET)
Received: by ug-out-1314.google.com with SMTP id q2so509972uge.50
	for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2007 16:04:48 -0800 (PST)
In-Reply-To: <s5h1w9h4g5d.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Takashi Iwai ha scritto:
> I recommend you to hack the driver code by yourself.

i take this as a "no we will not do it"

but i understand it.. keep reading

> The coding itself isn't too difficult.  The problem is the guess work,
> which PIN really corresponds to which I/O, and what control is missing
> (EAPD, GPIO, etc).

ok...
i know a bit of C programming, not much to be honest.. but i have no
idea on where/how to watch for "PIN" and things like that... I don't
know what EAPD, GPIO etc. are
i really would like to do it myself but i don't know where to start...
if you can give me a link that explain how it work and help me in the
process i'll do my best

but without any help i don't know what to do.. and i'm worried to damage
my audio card if i do something wrong...

> What I'm wondering is how to support 5.1 output.  The ALC268 codec is
> at most for 4 channels (2 + 2).  Are you sure that you can get 5.1
> distinct outputs?

hum.. you put a doubt in me..
i'm sure there's a subwoofer but i'm not sure it should be 6 channel...
i try to check in some way..
i never booted up Vista in this notebook... i guess i could try it to
check this or may be i found something googling... i let you know..

i'm a bit sad that you haven't time/men for my chipset (specially for
the headphone jack not working and the mic) but i understand it... i
hope you will help me to learn and fix my problem alone helping the
comunity and your project

i'll wait your reply
best regards :)
- --
Daniele
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHawMcgSF24OYDe4YRAgSsAKCw/UD/OIfZIN1uz54EYFaxR9VC3QCg466b
nDJ0hV9iaSWmAt3LzeqtrhM=
=ldxH
-----END PGP SIGNATURE-----
