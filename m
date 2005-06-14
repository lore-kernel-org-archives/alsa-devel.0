From: "Tehn-Yit Chin" <Tehn-Yit.Chin@greyinnovation.com>
Subject: RE: about the alsa i2c interface
Date: Tue, 14 Jun 2005 10:33:10 +1000
Message-ID: <9AEDBAA573BBD346BCF9637D80097D9119E83F@greysvr02.GreyInnovation.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from greyinnovation.com (246.063.dsl.mel.iprimus.net.au [211.27.107.246])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 834491A4
	for <alsa-devel@alsa-project.org>; Tue, 14 Jun 2005 02:35:46 +0200 (MEST)
Content-class: urn:content-classes:message
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

=20

> -----Original Message-----
> From: Lee Revell [mailto:rlrevell@joe-job.com]=20
> Sent: Thursday, 9 June 2005 4:48 PM
> To: Tehn-Yit Chin
> Cc: alsa-devel@alsa-project.org
> Subject: Re: [Alsa-devel] about the alsa i2c interface
>=20
> On Thu, 2005-06-09 at 13:09 +1000, Tehn-Yit Chin wrote:
> > Hi,
> >=20
> > We are trying to provide support for the CS43L43 device=20
> under the ALSA=20
> > architecture on an embedded platform.
> >=20
> > During my early investigation, I noticed that ALSA has its=20
> own i2c code.
> > What is this required, and why doesn't it use the mainline=20
> i2c support?
> > On our platform, there are one other devices on the i2c bus, so I=20
> > would like to use the mainline i2c code.
>=20
> This is explained in "Writing an ALSA Driver"  (you did read=20
> it, right?).  Basically the kernel's i2c layer is overly=20
> complex, and ALSA only needs a small subset of it, so ALSA=20
> implements its own minimal i2c layer.
>=20
> Lee
>=20
>=20

Many thanks for all the answers and comments.

Yep, I did read "Writing an ALSA Driver" and I also read the bit where
it said that the kernel's I2C is too complex for ALSA. My concern is
that we will have several devices on the I2C bus and acces to it will
need to be controlled, so for our project, it will need to use the
kernel's I2C code.

cheers,

Tehn Yit Chin=20
Software Engineer, Grey Innovation Pty. Ltd.


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
