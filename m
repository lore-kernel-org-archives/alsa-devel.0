From: Mathieu Rondonneau <mathieu.rondonneau@polymtl.ca>
Subject: Re: period_size, periods, count parameters
Date: Tue, 24 Feb 2004 20:10:57 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1077671457.403bf62159178@www.imp.polymtl.ca>
References: <Pine.HPX.4.33n.0402241901210.28675-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp.polymtl.ca (IDENT:0@smtp.polymtl.ca [132.207.4.11])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id CAA13589
	for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2004 02:11:02 +0100
In-Reply-To: <Pine.HPX.4.33n.0402241901210.28675-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Selon Clemens Ladisch <clemens@ladisch.de>:

> Mathieu Rondonneau wrote:
> > 	.period_bytes_min =3D 1024,
> > 	.period_bytes_max =3D 32768,
> > 	.periods_min	  =3D 8,
> > 	.periods_max	  =3D 512,
> >
> > When i start to send a file, I Don't know why:
> > runtime->period_size =3D 8192
> > runtime->periods: 8
> > and the =A8count=A8 parameter in the copy operator is 1024
>=20
> These values fit into the constraints defined above.

Thank you for your help Clemens.
Now, I understand a part of my problem.
According to the constraints values, I totaly agree with you.=20
But i miss something about the count parameter. =20
Why the count parameter is not equal to the size of the period in the run=
time
pointer (i.e. in my example above: 8192) in the copy operator?

I tried with new parameter:

	.period_bytes_min =3D 16*1024,
	.period_bytes_max =3D 64*1024,
	.periods_min	  =3D 2,
	.periods_max	  =3D 4,

and the result were:
runtime->period_size: 16*1024
runtime->periods: 4

I agree that values fit into constraints but the count parameter is alway=
s 1024.
I don't understand why count is 1024 ?=20
why count is not equal to runtime->period_size (i.e. 16*1024)?

I'm shure i miss something.
Maybe you can help me.
I thank you very much for your help.

regards,
Mathieu


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
