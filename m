From: Christian Kujau <evil@g-house.de>
Subject: Re: ALSA Oops (triggered by xmms)
Date: Fri, 15 Apr 2005 16:54:11 +0200
Message-ID: <425FD593.7080402@g-house.de>
References: <425EFB32.2010000@g-house.de>	<1113521720.19830.35.camel@mindpipe> <s5hbr8ge7yi.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261828AbVDOOy0@vger.kernel.org>
In-Reply-To: <s5hbr8ge7yi.wl@alsa2.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel@lists.sourceforge.net, juhl-lkml@dif.dk
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Takashi Iwai wrote:
> 
> Also, the latest CVS alsa-lib checks the timer protocol version to
> avoid this Oops with the older kenel.  1.0.9-rc3 is planned to be
> released soon, so wait for a moment...

um, i'll wait for the next release as i don't track alsa-cvs. but i do
track 2.6-BK (again) and the oops is gone ;-)


Jesper Juhl wrote:
>> yeah, but the oops doesn't wrap at 80 chars itsself and often oopses
>> are hardly readable inline.
>
> I would still suggest including the info inline and then if you think
> it's needed /also/ provide the link you did - then you've covered all
> bases :)

will do, next time 8-)


thanks to all involved for all your replies,
Christian.
- --
BOFH excuse #388:

Bad user karma.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCX9WT+A7rjkF8z0wRAlp2AJ0doKLm4OsK2i8nNx6uezrcfPF15QCeNkuO
eVCEuP0U5LrUOToHXEb6cBs=
=Feow
-----END PGP SIGNATURE-----
