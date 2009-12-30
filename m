From: michael@cadilhac.name (=?iso-8859-1?Q?Micha=EBl?= Cadilhac)
Subject: Getting pcm_usb_stream plugin to know its limits.
Date: Wed, 30 Dec 2009 12:48:22 -0500
Message-ID: <87ljgkuzdl.fsf@cadilhac.name>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 323AC24551
	for <alsa-devel@alsa-project.org>; Wed, 30 Dec 2009 18:50:06 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.50) id 1NQ2gO-0006Hb-E0
	for alsa-devel@alsa-project.org; Wed, 30 Dec 2009 18:50:04 +0100
Received: from 70.35.166.123 ([70.35.166.123])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 30 Dec 2009 18:50:04 +0100
Received: from michael by 70.35.166.123 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 30 Dec 2009 18:50:04 +0100
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

Hi there everyone,

I've been fighting for a few hours with a USB sound device (namely,
Tascam US-144), to get it to work with Audacity (this not being the
relevant part).

At first, Audacity died in a painful segfault, without any explanation,
when associated with the usb_stream plugin[1].=20

Audacity uses PortAudio, which checks for a few possible parameters of
audio rate to find the list of accepted ones.  It tries to set a
parameter (snd_pcm_hw_params), and if it fails, closes the device, and
continues its way.

Suppose the `prepare` act of the usb_stream is aborted because of wrong
parameters.  Then, PortAudio tries to close the device, by calling
snd_pcm_close.  This in turn calls snd_pcm_drop, which calls the fast_op
drop (that of ioplug), which is snd_pcm_ioplug_drop, which then calls
the *stop* callback of the usb_stream (snd_pcm_us_stop).  The stream not
being properly initialized, us->uus->write_area is nil, and the memset
fails.

This is the modification I did for that purpose=A0:


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=memset.patch

--- pcm_usb_stream.c	2008-11-21 18:08:16.000000000 -0500
+++ pcm_usb_stream.c	2009-12-30 12:36:00.654452577 -0500
@@ -258,7 +258,7 @@
 	snd_pcm_us_t *us = io->private_data;
 	VDBG("%u", us->uus->s->periods_done);
 
-	if (io->stream == SND_PCM_STREAM_PLAYBACK)
+	if (io->stream == SND_PCM_STREAM_PLAYBACK && us->uus->s)
 		memset(us->uus->write_area, 0, us->uus->s->write_size);
 
 	return 0;

--=-=-=


Next, Audacity stopped segfaulting but still didn't work: it couldn't
manage to configure the plugin properly.  Here's how PortAudio searches
for an acceptable audio rate.  For each possible sample rate, it gets a
full hw_params for the device:
                snd_pcm_hw_params_any( pcm, hwParams );
then set the sample rate to the hwParams.  It then tries to set those
params to the device:
                  snd_pcm_hw_params( pcm, hwParams );

The period_size parameter is left untouched, and by default, the pcm
inherits of a high value (maybe the highest).  Now the problem is the
following.  pcm_usb_stream says that the maximum accepted period_size is
64*4096:
(err = snd_pcm_ioplug_set_param_minmax(&us->io, SND_PCM_IOPLUG_HW_PERIOD_BYTES,
                                       128, 64*4096)

BUT the us122l driver[2] (from 2.6.32) explicitly prohibits period_size
greater than 0x3000:

if ((cfg->sample_rate != 44100 && cfg->sample_rate != 48000  &&
	     (!high_speed ||
	      (cfg->sample_rate != 88200 && cfg->sample_rate != 96000))) ||
	    cfg->frame_size != 6 ||
	    cfg->period_frames > 0x3000)
		err = -EINVAL;

This is now what happens in PortAudio:  PortAudio tries each and every
sound rate with the "default" period_size, this being greater than
0x3000.  It follows that no sound rate will be accepted, because of the
period_size, and the device fails to initialize.


I'm not sure whose fault is this, and for the time being, I just did the
following:

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=period_size.patch

--- pcm_usb_stream.c	2008-11-21 18:08:16.000000000 -0500
+++ pcm_usb_stream.c	2009-12-30 12:36:00.654452577 -0500
@@ -380,7 +380,7 @@
 	    (err = snd_pcm_ioplug_set_param_minmax(&us->io, SND_PCM_IOPLUG_HW_RATE,
 						   44100, 96000)) < 0 ||
 	    (err = snd_pcm_ioplug_set_param_minmax(&us->io, SND_PCM_IOPLUG_HW_PERIOD_BYTES,
-						   128, 64*4096)) < 0 ||
+						   128, 2*4096)) < 0 ||
 	    (err = snd_pcm_ioplug_set_param_minmax(&us->io, SND_PCM_IOPLUG_HW_PERIODS,
 						   2, 2)) < 0)
 		return err;

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable



Well, that's all folks.  Happy new year to everyone.

Footnotes:=20
[1]  Configured as
pcm.!usb_stream {
	type usb_stream
	card "1"
}
which works with a fine-tuned aplay.


[2]  linux/sound/usb/usx2y/us122l.c

--=20
Micha=EBl `Micha' Cadilhac (LITQ, U. de Montr=E9al) -- http://michael.cad=
ilhac.name
	|| La culture, c'est comme l'amour.
	||  Faut y aller =E0 petits coups au d=E9but pour bien en jouir plus tar=
d.
	||         -- Pierre Desproges

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
