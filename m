From: Mathieu Rondonneau <mathieu.rondonneau@polymtl.ca>
Subject: period_size, periods, count parameters
Date: Sat, 21 Feb 2004 20:16:46 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1077412606.403802fe862ce@www.imp.polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp.polymtl.ca (IDENT:0@smtp.polymtl.ca [132.207.4.11])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id CAA27749
	for <alsa-devel@alsa-project.org>; Sun, 22 Feb 2004 02:16:50 +0100
Received: from localhost (c4.si.polymtl.ca [132.207.4.29])
	by smtp.polymtl.ca (8.12.11/8.12.11) with ESMTP id i1M1Gkp8021954
	for <alsa-devel@alsa-project.org>; Sat, 21 Feb 2004 20:16:47 -0500
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Hi,

I've a question according to the =A8period_size=A8 and the =A8periods=A8 =
parameters in
the =A8runtime=A8 structure.

my wav file is 34184 bytes long, and my hardware parameter are:

	.rate_min	  =3D 8000,
	.rate_max	  =3D 48000,
	.channels_min	  =3D 1,
	.channels_max	  =3D 2,
	.buffer_bytes_max =3D 64*1024,
	.period_bytes_min =3D 1092,
	.period_bytes_max =3D 32768,
	.periods_min	  =3D 8,=20
	.periods_max	  =3D 512,

When i start to send a file, I Don't know why:
runtime->period_size =3D 8192
runtime->periods: 8
and the =A8count=A8 parameter in the copy operator is 1024=20

I tryed to change
.period_bytes_min =3D 8192,
.periods_min	  =3D 1,=20

but the =A8count=A8 parameter, the =A8periode_size=A8 and =A8periods=A8 r=
emain the same.

Is it possible to change the =A8count=A8 parameter in the copy operator?

Thank you very much for your help.
Mathieu Rondonneau



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
