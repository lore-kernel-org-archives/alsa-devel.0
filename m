From: Damien Sandras <dsandras@seconix.com>
Subject: Re: SND_PCM_OPEN_PLAYBACK & SND_PCM_OPEN_CAPTURE
Date: 13 Aug 2003 13:50:11 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1060775410.23597.5.camel@linuxzone>
References: <1060769104.18854.2.camel@linuxzone>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1060769104.18854.2.camel@linuxzone>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I just noticed I was looking at the old API :)

With the new API, I think it always work to open the same device twice
(once for PLAYBACK STREAM and once for CAPTURE STREAM) at least for
full-duplex soundcards. If I'm wrong, can somebody correct me?

Thanks,

Le mer 13/08/2003 =E0 12:05, Damien Sandras a =E9crit :
> Hello,
>=20
> I would like to know if it is always possible to open the same device
> twice at the same time : once with SND_PCM_OPEN_PLAYBACK and once with
> SND_PCM_OPEN_CAPTURE.
>=20
> I know it is not possible with OSS, but I wanted to know if ALSA makes
> it possible or if the device has to be opened only once with
> SND_PCM_OPEN_DUPLEX in that case.
>=20
> Thanks a lot!
--=20
Damien Sandras <dsandras@seconix.com>



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
