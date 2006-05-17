From: Giuliano Pochini <pochini@shiny.it>
Subject: RE: How is buffer size, periode size and periods de
Date: Wed, 17 May 2006 09:47:53 +0200 (CEST)
Message-ID: <XFMail.20060517094753.pochini@shiny.it>
References: <446493DA.407@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <446493DA.407@atmel.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Hans-Christian Egtvedt <hcegtvedt@atmel.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 12-May-2006 Hans-Christian Egtvedt wrote:

> I'm experiencing that my aplay/arecord (1.0.11) is setting up a bit
> weird values for buffer size, period size and periods.
>=20
> For example when trying to record S16_LE 44100 Hz Mono I get the
> following parameters:
> buffer size: 44100
> period size: 4094
> periods    : 10
>=20
> 10 * 4094 =3D 40940 !=3D 44100, the player asks for a bigger buffer tha=
n needed.

Someone should add this issue the the FAQs.

ALSA is not required to make the buffer size multiple than
the period size, unless the driver asks for it. If it doesn't,
then the driver must be able to manage the case when the IRQs
happen at different points of the ring buffer each round.
Anyway, n*persize <=3D bufsize < (n+1)*persize

ALSA middle layer is robust enough to cope with unevenly sizes
periods well (eg. buf=3D1000 per=3D400 -> 3 periods of 400, 400, 200).
I wouldn't be surprised if some drivers still use periods of
different sizes because ALSA doesn't complain (mine did it at the
beginning).


--
Giuliano.


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job ea=
sier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronim=
o
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D=
121642
