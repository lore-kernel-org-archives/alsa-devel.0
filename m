From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: [Alsa-user] [ANN] ALSA 1.0.0pre1 is released
Date: Wed, 26 Nov 2003 19:31:39 +0200 (EET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0311261909370.1446-100000@ecabase.localdomain>
References: <s5hn0as1hvn.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hn0as1hvn.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 19 Nov 2003, Takashi Iwai wrote:

> Especially, if you have a card or a mobo with ICH (or compatible)
> chip and *multiple* AC97 codecs, testing this version is appreciated.

Some of my apps have stopped working after 1.0.0pre1 on a T23 Thinkpad=20
(intel8x0, 82801).

Simple things like "arecord -f cd -=A0|aplay -f cd -" work, but apps whic=
h=20
relay on select/poll before doing any i/o do not work. I didn't have=20
time to test, but I suspect jackd would not have worked. :)

On the same machine, alsa-driver-0.9.8 works fine, but not with 1.0.0pre1=
=20
and 1.0.0pre3.

PS The same intel8x0 ac97-chip can be found on many other=20
   thinkpad models: at least T24, X30, X31 and T40.

--=20
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
