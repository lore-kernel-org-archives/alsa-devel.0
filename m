From: michael@cadilhac.name (=?iso-8859-1?Q?Micha=EBl?= Cadilhac)
Subject: Re: Getting pcm_usb_stream plugin to know its
	limits.	[Kind of SOLVED]
Date: Tue, 02 Feb 2010 00:24:22 -0500
Message-ID: <87636gw6pl.fsf@cadilhac.name>
References: <87ljgkuzdl.fsf@cadilhac.name> <87eimbvkxg.fsf@cadilhac.name>
	<87aawzviyd.fsf_-_@cadilhac.name> <87y6kdz0yo.fsf@cadilhac.name>
	<yvzgiqb8fq1k.fsf@cadilhac.name> <s5hockz646u.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f187.google.com (mail-qy0-f187.google.com
	[209.85.221.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D1E524415
	for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2010 06:24:35 +0100 (CET)
Received: by qyk17 with SMTP id 17so3046202qyk.2
	for <alsa-devel@alsa-project.org>; Mon, 01 Feb 2010 21:24:33 -0800 (PST)
In-Reply-To: <s5hockz646u.wl%tiwai@suse.de> (Takashi Iwai's message of "Tue,
	12 Jan 2010 10:52:09 +0100")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Takashi Iwai <tiwai@suse.de> writes:

> At Mon, 11 Jan 2010 13:35:19 -0500,
> Micha=EBl Cadilhac wrote:
>>=20
>> michael@cadilhac.name (Micha=EBl Cadilhac) writes:
>>=20
>> > michael@cadilhac.name (Micha=EBl Cadilhac) writes:
>> >
>> >> So, my final saying is the following patch.  It fixes the segfault =
on
>> >> stopping a non-started usb_stream, plus it adds the ability to set =
a
>> >> period size and sound rate.  The latter offers a workaround for the
>> >> second issue I came with (that the default values for period bytes,=
 and
>> >> hence period size, were too high for us122l to work).
>> >
>> > Any comment on that patch would be greatly appreciated.  I'm just
>> > wondering if it's safe for me to give it to some people.
>>=20
>> Anyone?  Note that this also fixes a real bug, so it might be of
>> interest to include it in the trunk.
>
> Through a quick glance, the patch looks OK to me.
> Could you give a proper subject and changelog to merge your patch
> to git tree?

Hi there Takashi, and sorry for the delay.  Here are the patch,
subdivised in two distinct logical changes.  I hope the format is what
you asked for.

	* usb_stream/pcm_usb_stream.c (snd_pcm_us_stop): Prevent
	dereferencing when structure is not initialized.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=00fix-deref.patch

--- usb_stream/pcm_usb_stream.c	2009-12-16 10:18:55.000000000 -0500
+++ usb_stream/pcm_usb_stream.c	2010-01-23 10:19:09.032559296 -0500
@@ -1,7 +1,7 @@
 /*
  *  PCM - USB_STREAM plugin
  *
- *  Copyright (c) 2008 by Karsten Wiese <fzu@wemgehoertderstaat.de>
+ *  Copyright (c) 2008, 2010 by Karsten Wiese <fzu@wemgehoertderstaat.de>
  *
  * This library is free software; you can redistribute it and/or modify
  * it under the terms of the GNU Lesser General Public License as
@@ -256,8 +256,11 @@
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


	* usb_stream/pcm_usb_stream.c: Allow user-set period-size and
	rate.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=01add-tweaking.patch

--- usb_stream/pcm_usb_stream.c	2010-01-23 10:19:09.032559296 -0500
+++ usb_stream/pcm_usb_stream.c	2010-01-23 10:20:36.006628021 -0500
@@ -48,6 +48,8 @@
 #define VDBG(f, ...)
 #endif
 
+#define FRAME_SIZE 6
+
 #define LCARD 32
 struct user_usb_stream {
 	char			card[LCARD];
@@ -70,6 +72,8 @@
 	unsigned		periods_done;
 
 	unsigned 		channels;
+	snd_pcm_uframes_t	period_size;
+	unsigned int		rate;
 } snd_pcm_us_t;
 
 static struct user_usb_stream *uus;
@@ -177,7 +181,7 @@
 	VDBG("");
 
 	us_cfg.version = USB_STREAM_INTERFACE_VERSION;
-	us_cfg.frame_size = 6;
+	us_cfg.frame_size = FRAME_SIZE;
 	us_cfg.sample_rate = io->rate;
 	us_cfg.period_frames = io->period_size;
 
@@ -373,6 +377,10 @@
 	};
 
 	int err;
+	unsigned int rate_min = us->rate ? us->rate : 44100,
+		rate_max = us->rate ? us->rate : 96000,
+		period_bytes_min = us->period_size ? FRAME_SIZE * us->period_size : 128,
+		period_bytes_max = us->period_size ? FRAME_SIZE * us->period_size : 64*4096;
 
 	if ((err = snd_pcm_ioplug_set_param_list(&us->io, SND_PCM_IOPLUG_HW_ACCESS,
 						 ARRAY_SIZE(access_list), access_list)) < 0 ||
@@ -381,9 +389,9 @@
 	    (err = snd_pcm_ioplug_set_param_minmax(&us->io, SND_PCM_IOPLUG_HW_CHANNELS,
 						   us->channels, us->channels)) < 0 ||
 	    (err = snd_pcm_ioplug_set_param_minmax(&us->io, SND_PCM_IOPLUG_HW_RATE,
-						   44100, 96000)) < 0 ||
+						   rate_min, rate_max)) < 0 ||
 	    (err = snd_pcm_ioplug_set_param_minmax(&us->io, SND_PCM_IOPLUG_HW_PERIOD_BYTES,
-						   128, 64*4096)) < 0 ||
+						   period_bytes_min, period_bytes_max)) < 0 ||
 	    (err = snd_pcm_ioplug_set_param_minmax(&us->io, SND_PCM_IOPLUG_HW_PERIODS,
 						   2, 2)) < 0)
 		return err;
@@ -393,7 +401,9 @@
 
 static int snd_pcm_us_open(snd_pcm_t **pcmp, const char *name,
 				   const char *card,
-				   snd_pcm_stream_t stream, int mode)
+				   snd_pcm_stream_t stream, int mode,
+				   snd_pcm_uframes_t period_size,
+				   unsigned int rate)
 {
 	snd_pcm_us_t *us;
 	int err;
@@ -424,6 +434,8 @@
 	snd_hwdep_poll_descriptors(us->hwdep, &us->pfd, 1);
 
 	us->channels = 2;
+	us->period_size = period_size;
+	us->rate = rate;
 
 	us->io.version = SND_PCM_IOPLUG_VERSION;
 	us->io.name = "ALSA <-> USB_STREAM PCM I/O Plugin";
@@ -458,6 +470,7 @@
 	snd_config_iterator_t i, next;
 	const char *card;
 	int err;
+	long period_size = 0, rate = 0;
 
 	snd_config_for_each(i, next, conf) {
 		snd_config_t *n = snd_config_iterator_entry(i);
@@ -475,11 +488,27 @@
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
+	err = snd_pcm_us_open(pcmp, name, card, stream, mode, period_size, rate);
 
 	return err;
 }

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable


  I can write the according documentation, if needed.

  Have a great day.

--=20
Micha=EBl `Micha' Cadilhac (LITQ, U. de Montr=E9al) -- http://michael.cad=
ilhac.name
	||   This .sig has been generated by Outlook Express 98
	||        $@(%@#%$*@(#)%$!%)(%$#(@#$%**!@#$+!#?%
	||  and triple-checked on Windows Mail Vista.

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
