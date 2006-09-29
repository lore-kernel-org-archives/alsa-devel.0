From: Jochen Voss <voss@seehuhn.de>
Subject: M-Audio Revolution 5.1 - new hardware information
Date: Fri, 29 Sep 2006 23:32:17 +0100
Message-ID: <20060929223217.GA5624@tarte.seehuhn.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0369341362=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: ALSA development list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--===============0369341362==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

today is my birthday and I got a shiny new multimeter as a present.
Using this new toy, I was able to squeeze a bit more information out
of my M-Audio revolution 5.1 board.

1. Input channels:

  The AK5365 ADC allows to select its input from 5 different channels.
  Using the multimeter I can see that at least channels 1 and 2 are
  used.  I think 1 is the microphone and 2 is line-in, but this is
  hard to say because the lines vanish under some bulky capacitors
  where it is hard to follow them.

  The input select lines SEL0, SEL1, SEL2 are all pulled to ground,
  which means that the input channel can be selected via register
  0x01.

  It would be nice if the ALSA driver would get a control to select
  the input channel (it just needs to allow to set the lower three
  bits of register 0x01).  This should be easy.

2. PT2258 Volume Controller:

  The board contains a PT2258 Volume Controller chip, which is
  currently, I think, not accessible using the ALSA driver.
  Originally I hoped that this chip could be used to enable the
  headphone output, but it does not seem to be the case.  From
  following the connections I think that this chip is used to enable
  analog loopback of the input lines to some output channel.  At least
  input 1 leads very close to the CD-input line.

  All six channels are connected to something.

  I could find the following direct connections:

        PT2258, pin 6 (SCL) <-> VT1722, pin 59 (GPIO 7)
        PT2258, pin 7 (SDA) <-> VT1722, pin 58 (GPIO 6)

  The address select lines CODE1 and CODE2 seem to be pulled to GND.

  So we can control this volume controller by playing with GPIO 6 and
  7.  This project will be a bit more challenging.  One has to shift
  the data to the chip bit by bit, we have to use pin 6 as the clock
  (max 100kbit/s), pin 7 is only allowed to change while 6 is low and
  the chip read the data while 6 is high.  After every byte the chips
  sends back one acknoledge bit.  And the chip wants a 200ms delay
  after power up.  The data sheet is at

        http://www.princeton.com.tw/webSite/downloadprocess/downloadfile.as=
p?mydownload=3DPT2258_2.pdf

  It would be nice if the ALSA driver would allow access to these
  volume controls.

All things I found out about the card, including the information
above, is collected on my web page at

    http://seehuhn.de/comp/hardware/revolution

Comments are very welcome.

I hope this helps,
Jochen
--=20
http://seehuhn.de/

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFHZ7xf+iD8yEbECURAt1nAKCgPJTowdgzgUcPHFhynKaDl/wPlgCfWC4s
dCDJsxZInJqDkQWSL0BWTMw=
=QSqN
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--


--===============0369341362==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0369341362==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0369341362==--
