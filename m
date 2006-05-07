From: "Sam Morris" <sam@robots.org.uk>
Subject: Re: [ALSA-lib] Device Enumeration in Human-Readable Form
Date: Sun, 7 May 2006 00:37:49 +0000 (UTC)
Message-ID: <e3jfgt$1d2$1@sea.gmane.org>
References: <20060414015001.9C53A888D2@sc8-sf-spam1.sourceforge.net>
	<200605042250.k44MoAHV015522@dsci-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 04 May 2006 18:50:11 -0400, Jason Champion wrote:
> I am currently working on a multiplatform audio project that uses wxWid=
gets
> + DirectSound on Windows and wxGTK + ALSA on Linux.  I need to be able =
to
> enumerate the soundcards on the system in Human-readable form, like so:
>=20
> http://www.bloodlessmushroom/enumeration.gif
>=20
> Is there a standard way to get this enumeration using ALSA?  I haven't =
been
> able to find any good documentation describing how to do so.  Essential=
ly I
> am looking for how to do something more or less equivalent to
> DirectSoundEnumerate() in order to grab a list of PCM capture and PCM
> playback devices.

According to
<http://sourceforge.net/mailarchive/forum.php?thread_id=3D7452725&forum_i=
d=3D1752>
you can use the snd_names_list function; however this relies on libasound
1.0.9, and the user must have a valied /etc/asound.names file. Some newer
distributions maintain this file by default.

--=20
Sam Morris
http://robots.org.uk/

PGP key id 5EA01078
3412 EA18 1277 354B 991B  C869 B219 7FDB 5EA0 1078



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job ea=
sier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronim=
o
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D=
121642
