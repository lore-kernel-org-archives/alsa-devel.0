From: "Pete Barnard" <petebarnard@tiscali.co.uk>
Subject: Re: Broken pipe mystery
Date: Thu, 13 Feb 2003 20:56:33 -0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000001c2d3a2$a450b2f0$0100a8c0@Pblaptop>
References: <Pine.LNX.4.21.0302081212550.32024-100000@mailserver.intern.bfad.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tomasz motylewski <T.Motylewski@bfad.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

:
>
> Does it always crash after the same time?

No. It didin't crash after the same time.  The problem is fixed now thanks
to Josh Green's tip.   (I wrote a function that caught the EPIPE error and
then did a snd_pcm_prepare). I left it for 2 nights with a system("date") in
the catch function and got an EPIPE once on one night and not at all on the
second night - so even though it is fixed I'm still slightly curious as to
why I got this problem/feature at all.

Regards,

Pete


>
> What sampling frequency do you use (kHz) ?
>
> Best regards,
> --
> Tomek
>



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
