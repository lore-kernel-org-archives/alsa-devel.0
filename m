From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: Two OOPSes in ALSA with kernel-2.6.17-rc1
Date: Mon, 10 Apr 2006 17:57:48 +0159
Message-ID: <443A8093.80505__11715.8100860708$1144684834$gmane$org@gmail.com>
References: <200604101823.54600.shlomif@iglu.org.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from nproxy.gmail.com (nproxy.gmail.com [64.233.182.191])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A3F6B17C
	for <alsa-devel@alsa-project.org>; Mon, 10 Apr 2006 17:58:59 +0200 (MEST)
Received: by nproxy.gmail.com with SMTP id a4so99146nfc
        for <alsa-devel@alsa-project.org>; Mon, 10 Apr 2006 08:58:58 -0700 (PDT)
In-Reply-To: <200604101823.54600.shlomif@iglu.org.il>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Shlomi Fish <shlomif@iglu.org.il>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Shlomi Fish napsal(a):
> Hi all!
> 
> (Please CC me on the replies)
> 
> I recently received these two OOPSes with kernel-2.6.17-rc1. They happened 
> while mpg123 was playing a WAV file and I invoked KDE (along with artsd).
> 
> My soundcard is snd_intel8x0.
> 
> Let me know if you need any other information.
Try to turn sound debug on and retest.
It seems like struct snd_pcm_runtime *runtime is NULL.

regards,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEOoCTMsxVwznUen4RAkbcAJ4lYUt9LK5t9ECKbcy453qYPlOahACfR5pz
zWEa8B9DzvmbKsdwyTVe49c=
=YvAt
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
