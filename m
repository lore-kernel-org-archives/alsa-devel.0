From: Damien Sandras <dsandras@seconix.com>
Subject: Re: Re: SND_PCM_OPEN_PLAYBACK & SND_PCM_OPEN_CAPTURE
Date: 13 Aug 2003 16:56:23 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1060786583.30084.1.camel@linuxzone>
References: <200308131359.h7DDwjGM000761@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200308131359.h7DDwjGM000761@localhost.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Le mer 13/08/2003 =E0 15:58, Paul Davis a =E9crit :

> yes, if the h/w can do full-duplex, then this will always work (and as
> you noticed, there is no "DUPLEX" mode anymore - you always get one
> handle for playback and a different one for capture).
>=20

That is a good news for me.

> note that some cards (the early SB series come to mind) will not
> support the same parameters for playback and capture when opened for
> duplex usage, so it can a bit more complex than you'd really like.
>=20

How can I determine that and solve that problem? Is there a source code
example that I could look at?

Many thanks for your support.

I'm currently porting GnomeMeeting to be able to use native ALSA.
--=20
Damien Sandras <dsandras@seconix.com>



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
