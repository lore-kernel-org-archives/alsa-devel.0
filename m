From: =?ISO-8859-1?B?SmFha2tvIFBy5HR05Gzk?= <Jaakko.Prattala@Helsinki.FI>
Subject: Re: NEW hdsp 9652 problems - {WAS: alsaconf -L - where's Waldo?)
Date: Sat, 22 Mar 2003 13:59:46 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1048334386.3e7c503222f73@www2.helsinki.fi>
References: <E18wRlw-0002ZE-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E18wRlw-0002ZE-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Mark Knecht <markknecht@attbi.com>, Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Lainaus Paul Davis <paul@linuxaudiosystems.com>:

> mark - i'm not trying to apportion blame, but i would note that if you
> had not updated the firmware, this would not have happened. also, i
> had hoped that takashi or jaroslav would have applied the patches
> already mailed to the mailing list to CVS, but they chose not for
> various reasons.
>=20
> i use my H-DSP almost every day, and it works without problems for
> most things (you know most of the issues).
[...]
> i believe that my work and now thomas's will be available very soon,
> and will make the hdsp a truly phenomenal card under linux.

How about if you send a diff of the driver you're using with
your hdsp with firmware rev 11 against current cvs?
I've never done it but I could try and build an
first-aid rpm for Mark and others who want it.
Unless of course cvs will be up to date very soon.

I tried to patch the driver with your patch version II I found
in the archives but it was very difficult because of the extra
linefeeds the mail archive had added to the patch. I don't think
it went right. At least the first hunk I had to edit in by hand
afterwards. Whatever the reason, my multiface doesn't get
recognized. It might be my pcmcia setup or (hopefully not)
the laptop or the card itself. It would be great to have
less places to look for faults.

If you don't see making and sending a patch like this
as a good idea, could you or Thomas give a rough estimate of the
time it will take Thomas to finish his work? I'm asking
these things _not_ to hurry you up but because
I have to make plans and draw a map of the
setup I'm going to use in a theater production we start
building in a week from now. If my card doesn't work at that point,
it's ok by me, I'll just use something else.
I'd love to use the multiface of course :-)

> thomas
> also has written an almost-finished version of totalmix for linux
> (with bitmaps from RME), and that is really impressive to see
> running.

You guys simply *rule*! :-)

--
Jaakko Pr=E4tt=E4l=E4
Jaakko.Prattala@Helsinki.FI
http://www.cs.Helsinki.FI/Jaakko.Prattala


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
