From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: 2.6.30-rc8 skipping regression also affects cmipci
Date: Sun, 7 Mar 2010 12:41:14 +0800
Message-ID: <4f3252891003062041p69979f08o4bed1ee13ee27027@mail.gmail.com>
References: <hgbiph$4kr$1@ger.gmane.org> <hmhs3e$g7g$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0667B1037EA
	for <alsa-devel@alsa-project.org>; Sun,  7 Mar 2010 05:41:15 +0100 (CET)
Received: by pwj10 with SMTP id 10so2876704pwj.38
	for <alsa-devel@alsa-project.org>; Sat, 06 Mar 2010 20:41:14 -0800 (PST)
In-Reply-To: <hmhs3e$g7g$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/3/2 Fr=E9d=E9ric Bri=E8re <fbriere@fbriere.net>

> Fr=E9d=E9ric Bri=E8re <fbriere@fbriere.net> wrote:
> > In so doing, I noticed infrequent occurrences of audio skipping, which I
> > managed to bisect down to c87d973.  It would appear that this commit
> > also affects cmipci (CMI8738), albeit not as badly as it did for
>
> Apparently, this is also causing crashes for PulseAudio users:
> <https://bugzilla.redhat.com/show_bug.cgi?id=3D524385>.  (My thanks to
> Masanari Iida for this pointer.)
>
> Again, if there's anything I can do to help, please let me know.  And
> thanks for your hard work!
>
>
> -


Why  PA sometime use snd_pcm_avail() and sometime use snd_pcm_delay() ?

pulseaudio[2114]: alsa-util.c: snd_pcm_avail() returned a value that is
exceptionally large: 18446744073709549460 bytes (418293516398 ms).
pulseaudio[2114]: alsa-util.c: Most likely this is a bug in the ALSA driver
'snd_cmipci'. Please report this issue to the ALSA developers.
pulseaudio[2114]: alsa-util.c: snd_pcm_dump():
pulseaudio[2114]: alsa-util.c: Hardware PCM card 0 'C-Media CMI8738' device=
 0
subdevice 0
pulseaudio[2114]: alsa-util.c: Its setup is:
pulseaudio[2114]: alsa-util.c:   stream       : PLAYBACK
pulseaudio[2114]: alsa-util.c:   access       : MMAP_INTERLEAVED
pulseaudio[2114]: alsa-util.c:   format       : S16_LE
pulseaudio[2114]: alsa-util.c:   subformat    : STD
pulseaudio[2114]: alsa-util.c:   channels     : 2
pulseaudio[2114]: alsa-util.c:   rate         : 44100
pulseaudio[2114]: alsa-util.c:   exact rate   : 44100 (44100/1)
pulseaudio[2114]: alsa-util.c:   msbits       : 16
pulseaudio[2114]: alsa-util.c:   buffer_size  : 16384
pulseaudio[2114]: alsa-util.c:   period_size  : 8192
pulseaudio[2114]: alsa-util.c:   period_time  : 185759
pulseaudio[2114]: alsa-util.c:   tstamp_mode  : ENABLE
pulseaudio[2114]: alsa-util.c:   period_step  : 1
pulseaudio[2114]: alsa-util.c:   avail_min    : 15886
pulseaudio[2114]: alsa-util.c:   period_event : 0
pulseaudio[2114]: alsa-util.c:   start_threshold  : -1
pulseaudio[2114]: alsa-util.c:   stop_threshold   : 4611686018427387904
pulseaudio[2114]: alsa-util.c:   silence_threshold: 0
pulseaudio[2114]: alsa-util.c:   silence_size : 0
pulseaudio[2114]: alsa-util.c:   boundary     : 4611686018427387904
pulseaudio[2114]: alsa-util.c:   appl_ptr     : 4227619
pulseaudio[2114]: alsa-util.c:   hw_ptr       : 4210696
pulseaudio[2114]: alsa-util.c: snd_pcm_delay() returned a value that is
exceptionally large: 329472 bytes (1867 ms).
