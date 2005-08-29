From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: No sound on ATI IXP with Realtek ALC655 rev0 (MSI
	Megabook S270)
Date: Mon, 29 Aug 2005 10:33:19 -0400
Message-ID: <1125326000.4598.24.camel@mindpipe>
References: <200508291419.34270.rene@exactcode.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200508291419.34270.rene@exactcode.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?ISO-8859-1?Q?Ren=E9?= Rebe <rene@exactcode.de>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2005-08-29 at 14:19 +0200, Ren=E9 Rebe wrote:
> Hi all,
>=20
> despite enabling all mixel elements and increasing all sliders to the m=
aximum=20
> (or to other reasonable values) there is no sound from the internal spe=
akers=20
> on an AMD Turion based MSI Megabook with ATI chip and ALC655 rev0.
>=20
> There is a very low output on the headphone jack, but it is really far =
too low=20
> and barely hearable when the Master and PCM slider are set to the maxim=
um.
>=20
> I tried both 2.6.12 and 2.6.13 as well as building 1.0.10rc1 seperatly.
>=20
> Any idea? What kind of debug output would be helpful?

You aren't using the Gnome or KDE mixer are you?

Make sure you try it with alsamixer, and especially check the "External
Amplifier" control (if you have it).

Lee



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
