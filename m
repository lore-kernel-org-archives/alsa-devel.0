From: "Ronny V. Vindenes" <s864@lstud.ii.uib.no>
Subject: Re: SPDIF and cs46xx ?
Date: Fri, 14 Mar 2003 11:55:00 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303141133550.32326-100000@snylter.ii.uib.no>
References: <20030313132536.GB11388@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030313132536.GB11388@ulima.unil.ch>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 13 Mar 2003, Gregoire Favre wrote:

> On Thu, Mar 13, 2003 at 01:56:27PM +0100, Ronny V. Vindenes wrote:
>=20
> > I don't have mplayer here, but as far as I can remember:
> > "mplayer -dvd 1 -ac hwac3 -ao alsa9" should play a dts/dolby digital 5.=
1=20
>=20
> I'll try this tonight, I haven't tested without the alsa9:spdif, and
> without the -abs [1234] I had problems...
>=20
> > dvd track using spdif out. If you can I would recommend using xine inst=
ead=20
> > of mplayer for playing 5.1 streams as it has much cleaner and flexible=
=20
> > settings, atleast untill you find out if the problem lies with the driv=
er,=20
> > alsa-lib or elsewhere.
>=20
> I have also xine installed, but I didn't get any 5.1 with it also, but I
> will try some harder ;-)
>=20
> > I'll test the 0.9.1 driver when I get home tonight and see if it works =
for=20
> > me.
>=20

I have now tested 0.9.1 driver & lib with mplayer 0.90rc4 and=20
xine-lib-1-beta8/xine-ui-0.9.19. Both worked very well. xine works more or=
=20
less out of the box=B9 (just tick the a52_pass-thru under sound options),=
=20
while mplayer needed to be started like this;=20
mplayer -ao alsa9:mmap -ac hwac3 video_with_ac3.mpeg

Finally I can retire my rotten sb live! for good :)

[=B9] xine did have some odd behaviour when it came to navigating dvd menus=
=20
that didn't have sound on all pages. It would make some highpitched noise=
=20
when entering a silent page. Don't know if the problem is with xine or the=
=20
driver, but it sounds like the spdif loops the last few samples instead of=
=20
going silent.

--=20
Ronny V. Vindenes <sublett@dc-s.com>



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
