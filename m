From: michael@cadilhac.name (=?iso-8859-1?Q?Micha=EBl?= Cadilhac)
Subject: Re: Getting pcm_usb_stream plugin to know its limits.
Date: Wed, 30 Dec 2009 23:15:07 -0500
Message-ID: <87eimbvkxg.fsf@cadilhac.name>
References: <87ljgkuzdl.fsf@cadilhac.name>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 8CF2E1037F8
	for <alsa-devel@alsa-project.org>; Thu, 31 Dec 2009 05:15:38 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.50) id 1NQCRj-0004Y1-5I
	for alsa-devel@alsa-project.org; Thu, 31 Dec 2009 05:15:35 +0100
Received: from 70.35.166.123 ([70.35.166.123])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 31 Dec 2009 05:15:35 +0100
Received: from michael by 70.35.166.123 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 31 Dec 2009 05:15:35 +0100
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

> Next, Audacity stopped segfaulting but still didn't work: it couldn't
> manage to configure the plugin properly.

My second idea was to allow usb_stream to fix its own rate and
period_size, as in:

pcm.!usb_stream {
	type usb_stream
	period_size 128
	rate 44100
	card "1"
}

This would be great because it would prevent PortAudio from doing lots
of test (which are pretty slow).  This is what I thought would work:


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=allow.patch

--- pcm_usb_stream.c	2008-11-21 18:08:16.000000000 -0500
+++ /tmp/alsa-plugins-1.0.21/usb_stream/pcm_usb_stream.c	2009-12-30 22:59:45.884129907 -0500
@@ -1,7 +1,7 @@
 /*
  *  PCM - USB_STREAM plugin
  *
- *  Copyright (c) 2008 by Karsten Wiese <fzu@wemgehoertderstaat.de>
+ *  Copyright (c) 2008, 2009 by Karsten Wiese <fzu@wemgehoertderstaat.de>
  *
  * This library is free software; you can redistribute it and/or modify
  * it under the terms of the GNU Lesser General Public License as
@@ -70,6 +70,8 @@
 	unsigned		periods_done;
 
 	unsigned 		channels;
+	snd_pcm_uframes_t	period_size;
+	unsigned int		rate;
 } snd_pcm_us_t;
 
 static struct user_usb_stream *uus;
@@ -256,8 +258,11 @@
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
 
@@ -370,6 +375,10 @@
 	};
 
 	int err;
+	unsigned rate_min = us->rate ? us->rate : 44100,
+		rate_max = us->rate ? us->rate : 96000,
+		period_size_min = us->period_size ? us->period_size : 128,
+		period_size_max = us->period_size ? us->period_size : 64*4096;
 
 	if ((err = snd_pcm_ioplug_set_param_list(&us->io, SND_PCM_IOPLUG_HW_ACCESS,
 						 ARRAY_SIZE(access_list), access_list)) < 0 ||
@@ -378,19 +387,20 @@
 	    (err = snd_pcm_ioplug_set_param_minmax(&us->io, SND_PCM_IOPLUG_HW_CHANNELS,
 						   us->channels, us->channels)) < 0 ||
 	    (err = snd_pcm_ioplug_set_param_minmax(&us->io, SND_PCM_IOPLUG_HW_RATE,
-						   44100, 96000)) < 0 ||
+						   rate_min, rate_max)) < 0 ||
 	    (err = snd_pcm_ioplug_set_param_minmax(&us->io, SND_PCM_IOPLUG_HW_PERIOD_BYTES,
-						   128, 64*4096)) < 0 ||
+						   period_size_min, period_size_max)) < 0 ||
 	    (err = snd_pcm_ioplug_set_param_minmax(&us->io, SND_PCM_IOPLUG_HW_PERIODS,
 						   2, 2)) < 0)
 		return err;
-
 	return 0;
 }
 
 static int snd_pcm_us_open(snd_pcm_t **pcmp, const char *name,
 				   const char *card,
-				   snd_pcm_stream_t stream, int mode)
+			   snd_pcm_stream_t stream, int mode,
+			   snd_pcm_uframes_t period_size,
+			   unsigned int rate)
 {
 	snd_pcm_us_t *us;
 	int err;
@@ -421,6 +431,8 @@
 	snd_hwdep_poll_descriptors(us->hwdep, &us->pfd, 1);
 
 	us->channels = 2;
+	us->period_size = period_size;
+	us->rate = rate;
 
 	us->io.version = SND_PCM_IOPLUG_VERSION;
 	us->io.name = "ALSA <-> USB_STREAM PCM I/O Plugin";
@@ -455,6 +467,7 @@
 	snd_config_iterator_t i, next;
 	const char *card;
 	int err;
+	long period_size = 0, rate = 0;
 	
 	snd_config_for_each(i, next, conf) {
 		snd_config_t *n = snd_config_iterator_entry(i);
@@ -472,12 +485,27 @@
 			snd_config_get_string(n, &card);
 			continue;
 		}
+		if (strcmp(id, "period_size") == 0) {
+			if (snd_config_get_type(n) != SND_CONFIG_TYPE_INTEGER) {
+				SNDERR("Invalid type for %s", id);
+				return -EINVAL;
+			}
+			snd_config_get_integer(n, &period_size);
+			continue;
+		}
+		if (strcmp(id, "rate") == 0) {
+			if (snd_config_get_type(n) != SND_CONFIG_TYPE_INTEGER) {
+				SNDERR("Invalid type for %s", id);
+				return -EINVAL;
+			}
+			snd_config_get_integer(n, &rate);
+			continue;
+		}
 		SNDERR("Unknown field %s", id);
 		return -EINVAL;
 	}
 
-	err = snd_pcm_us_open(pcmp, name, card, stream, mode);
-
+	err = snd_pcm_us_open(pcmp, name, card, stream, mode, period_size, rate);
 	return err;
 }
 

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable


Basically, I tweaked the argument parsing to accept "rate" and
"period_size", stored them in the snd_pcm_us_t, and used them in
us_set_hw_constraint.  It looks to work great with the rate, but when I
set the period_size, aplay can't find a valid configuration (indeed,
snd_pcm_hw_params_any(handle, params); returns an error).

Any help appreciated again!

--=20
Micha=EBl `Micha' Cadilhac (LITQ, U. de Montr=E9al) -- http://michael.cad=
ilhac.name
	||   Free jazz is the Vegemite of the the musical world.
	||   It's an aquired taste.
	||        -- Marten, QC

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
