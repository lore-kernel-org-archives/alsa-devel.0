From: "Jack O'Quin" <joq@io.com>
Subject: Re: CVS commit [0.99.11] ALSA playback latency patch
Date: 17 Nov 2004 23:09:24 -0600
Message-ID: <874qjnvj3v.fsf@sulphur.joq.us>
References: <878y8zvjbs.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <878y8zvjbs.fsf@sulphur.joq.us>
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


I should have made it clear that this is a JACK update, not ALSA.  :-)

"Jack O'Quin" <joq@io.com> writes:

>   * applied Takashi's ALSA driver patch (thanks!)
>=20
>   * --nperiods now sets playback latency, not buffer size
>=20
>   * man page update...
>=20
>        -n, --nperiods int
>               Specify  the number of periods of playback latency.
>               In seconds, this corresponds  to  --nperiods  times
>               --period  divided by --rate.  The default is 2, the
>               minimum allowable.  For most devices, there  is  no
>               need  for  any  other  value  with  the  --realtime
>               option.  Without realtime privileges or with boards
>               providing  unreliable  interrupts  (like ymfpci), a
>               larger value may yield fewer xruns.  This can  also
>               help  if the system is not tuned for reliable real=AD
>               time scheduling.
>=20
>               For most ALSA  devices,  the  hardware  buffer  has
>               exactly  --period  times  --nperiods  frames.  Some
>               devices demand a larger buffer.  If so,  JACK  will
>               use  the  smallest  possible  buffer  containing at
>               least --nperiods, but the playback latency does not
>               increase.
>=20
> Would someone with an RME32/96 card please test this version and
> report your results.  You should now be able to run with --nperiods=3D2,
> which did not work before due to the card's fixed buffer size (IIUC).
> --=20
>   joq
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: InterSystems CACHE
> FREE OODBMS DOWNLOAD - A multidimensional database that combines
> robust object and relational technologies, making it a perfect match
> for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>=20

--=20
  joq


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
