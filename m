From: michael@cadilhac.name (=?iso-8859-1?Q?Micha=EBl?= Cadilhac)
Subject: Re: Getting pcm_usb_stream plugin to know its limits.
Date: Wed, 30 Dec 2009 12:58:15 -0500
Message-ID: <87d41wuyx4.fsf@cadilhac.name>
References: <87ljgkuzdl.fsf@cadilhac.name>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 8165224558
	for <alsa-devel@alsa-project.org>; Wed, 30 Dec 2009 18:58:40 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.50) id 1NQ2oh-0001lr-Ds
	for alsa-devel@alsa-project.org; Wed, 30 Dec 2009 18:58:39 +0100
Received: from 70.35.166.123 ([70.35.166.123])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 30 Dec 2009 18:58:39 +0100
Received: from michael by 70.35.166.123 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 30 Dec 2009 18:58:39 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

michael@cadilhac.name (Micha=EBl Cadilhac) writes:

> --- pcm_usb_stream.c	2008-11-21 18:08:16.000000000 -0500
> +++ pcm_usb_stream.c	2009-12-30 12:36:00.654452577 -0500
> @@ -258,7 +258,7 @@
>  	snd_pcm_us_t *us =3D io->private_data;
>  	VDBG("%u", us->uus->s->periods_done);
> =20
> -	if (io->stream =3D=3D SND_PCM_STREAM_PLAYBACK)
> +	if (io->stream =3D=3D SND_PCM_STREAM_PLAYBACK && us->uus->s)
>  		memset(us->uus->write_area, 0, us->uus->s->write_size);
> =20
>  	return 0;

Just noticed that it would be better phrased as:

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=memset.patch

--- /dd/alsa-plugins/usb_stream/pcm_usb_stream.c	2008-11-21 18:08:16.000000000 -0500
+++ pcm_usb_stream.c	2009-12-30 12:57:13.779349630 -0500
@@ -256,7 +256,10 @@
 static int snd_pcm_us_stop(snd_pcm_ioplug_t *io)
 {
 	snd_pcm_us_t *us = io->private_data;
-	VDBG("%u", us->uus->s->periods_done);
 
+	if (!us->uus->s)
+	  return 0;
+
+	VDBG("%u", us->uus->s->periods_done);
 	if (io->stream == SND_PCM_STREAM_PLAYBACK)
 		memset(us->uus->write_area, 0, us->uus->s->write_size);

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable


--=20
Micha=EBl `Micha' Cadilhac (LITQ, U. de Montr=E9al) -- http://michael.cad=
ilhac.name
	|| Un certain Blaise Pascal
	||   etc... etc...
	|| -- Pr=E9vert (Les paris stupides)

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-=-=--
