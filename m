From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: period_size, periods, count parameters
Date: Tue, 24 Feb 2004 19:03:49 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0402241901210.28675-100000@studcom.urz.uni-halle.de>
References: <1077412606.403802fe862ce@www.imp.polymtl.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mlucom10.urz.uni-halle.de (mlucom10.urz.Uni-Halle.DE [141.48.3.4])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA04686
	for <alsa-devel@alsa-project.org>; Tue, 24 Feb 2004 19:03:58 +0100
In-reply-to: <1077412606.403802fe862ce@www.imp.polymtl.ca>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mathieu Rondonneau <mathieu.rondonneau@polymtl.ca>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mathieu Rondonneau wrote:
> =09.period_bytes_min =3D 1092,
> =09.period_bytes_max =3D 32768,
> =09.periods_min=09  =3D 8,
> =09.periods_max=09  =3D 512,
>
> When i start to send a file, I Don't know why:
> runtime->period_size =3D 8192
> runtime->periods: 8
> and the =A8count=A8 parameter in the copy operator is 1024

These values fit into the constraints defined above.

> I tryed to change
> .period_bytes_min =3D 8192,
> .periods_min=09  =3D 1,
>
> but the =A8count=A8 parameter, the =A8periode_size=A8 and =A8period=
s=A8 remain
> the same.

The same for these values.

> Is it possible to change the =A8count=A8 parameter in the copy
> operator?

Apparently, your copy operator is to copy one period.

Probably you have to force another period size.

What's wrong with these parameters?


Regards,
Clemens





-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
