From: =?UTF-8?B?UGF2ZWwgxZhlem7DrcSNZWs=?= <pavel.reznicek@evangnet.cz>
Subject: Bug message caught in syslog
Date: Wed, 24 Jan 2018 11:50:20 +0100
Message-ID: <5eca8ce6-1c01-85e9-5ff2-e341f64550f6@evangnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.evangnet.cz (mx1.evangnet.cz [88.86.123.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 54276266A74
 for <alsa-devel@alsa-project.org>; Wed, 24 Jan 2018 11:50:23 +0100 (CET)
Received: from [192.168.0.104] (5.188.broadband4.iol.cz [85.71.188.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: pavel.reznicek@evangnet.cz)
 by mx2.evangnet.cz (Postfix) with ESMTPSA id 15CB0367A0
 for <alsa-devel@alsa-project.org>; Wed, 24 Jan 2018 11:50:21 +0100 (CET)
Content-Language: cs-CZ
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear developers,

I'm sorry if I write to the wrong list but I just catched several log =

messages that I was advised to report as a bug to you, the ALSA developers.

I'm not experiencing any sound problems by ear, just found these =

messages in the syslog (via logcheck).

Ran the alsa-info_alsa-info.sh shell script and its output can be found =

here:

http://www.alsa-project.org/db/?f=3Dd9b579a048b94cdc71e619c4deac60e4c8228dbb

The log messages in question read as follows:

Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c: snd_pcm_avail() navr=E1til hodnotu, kter=E1 je nezvykle vysok=
=E1: 570108 bajt=F9 (3231 ms).
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c: S nejv=ECt=B9=ED pravd=ECpodobnost=ED se jedn=E1 o chybu v ovl=
ada=E8i ALSA "snd_hda_intel". Nahlaste pros=EDm tento probl=E9m v=FDvoj=E1=
=F8=F9m ALSA.
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c: snd_pcm_dump():
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c: Soft volume PCM
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c: Control: PCM Playback Volume
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c: min_dB: -51
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c: max_dB: 0
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c: resolution: 256
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c: Its setup is:
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   stream       : PLAYBACK
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   access       : MMAP_INTERLEAVED
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   format       : S16_LE
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   subformat    : STD
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   channels     : 2
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   rate         : 44100
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   exact rate   : 44100 (44100/1)
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   msbits       : 16
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   buffer_size  : 16384
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   period_size  : 8192
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   period_time  : 185759
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   tstamp_mode  : ENABLE
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   tstamp_type  : MONOTONIC
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   period_step  : 1
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   avail_min    : 15802
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   period_event : 0
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   start_threshold  : -1
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   stop_threshold   : 4611686018427387904
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   silence_threshold: 0
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   silence_size : 0
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   boundary     : 4611686018427387904
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c: Slave: Hardware PCM card 0 'HDA Intel PCH' device 0 subdevice 0
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c: Its setup is:
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   stream       : PLAYBACK
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   access       : MMAP_INTERLEAVED
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   format       : S16_LE
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   subformat    : STD
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   channels     : 2
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   rate         : 44100
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   exact rate   : 44100 (44100/1)
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   msbits       : 16
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   buffer_size  : 16384
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   period_size  : 8192
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   period_time  : 185759
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   tstamp_mode  : ENABLE
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   tstamp_type  : MONOTONIC
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   period_step  : 1
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   avail_min    : 15802
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   period_event : 0
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   start_threshold  : -1
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   stop_threshold   : 4611686018427387904
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   silence_threshold: 0
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   silence_size : 0
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   boundary     : 4611686018427387904
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   appl_ptr     : 95068169
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   hw_ptr       : 95194312
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c: snd_pcm_delay() navr=E1til hodnotu, kter=E1 je nezvykle vysok=
=E1: -454064 bajt=F9 (-2574 ms).
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c: S nejv=ECt=B9=ED pravd=ECpodobnost=ED se jedn=E1 o chybu v ovl=
ada=E8i ALSA "snd_hda_intel". Nahlaste pros=EDm tento probl=E9m v=FDvoj=E1=
=F8=F9m ALSA.
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c: snd_pcm_dump():
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c: Soft volume PCM
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c: Control: PCM Playback Volume
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c: min_dB: -51
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c: max_dB: 0
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c: resolution: 256
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c: Its setup is:
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   stream       : PLAYBACK
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   access       : MMAP_INTERLEAVED
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   format       : S16_LE
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   subformat    : STD
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   channels     : 2
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   rate         : 44100
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   exact rate   : 44100 (44100/1)
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   msbits       : 16
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   buffer_size  : 16384
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   period_size  : 8192
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   period_time  : 185759
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   tstamp_mode  : ENABLE
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   tstamp_type  : MONOTONIC
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   period_step  : 1
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   avail_min    : 15802
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   period_event : 0
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   start_threshold  : -1
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   stop_threshold   : 4611686018427387904
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   silence_threshold: 0
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   silence_size : 0
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   boundary     : 4611686018427387904
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c: Slave: Hardware PCM card 0 'HDA Intel PCH' device 0 subdevice 0
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c: Its setup is:
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   stream       : PLAYBACK
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   access       : MMAP_INTERLEAVED
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   format       : S16_LE
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   subformat    : STD
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   channels     : 2
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   rate         : 44100
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   exact rate   : 44100 (44100/1)
Jan 24 07:01:25 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   msbits       : 16
Jan 24 07:01:26 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   buffer_size  : 16384
Jan 24 07:01:26 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   period_size  : 8192
Jan 24 07:01:26 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   period_time  : 185759
Jan 24 07:01:26 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   tstamp_mode  : ENABLE
Jan 24 07:01:26 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   tstamp_type  : MONOTONIC
Jan 24 07:01:26 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   period_step  : 1
Jan 24 07:01:26 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   avail_min    : 15802
Jan 24 07:01:26 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   period_event : 0
Jan 24 07:01:26 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   start_threshold  : -1
Jan 24 07:01:26 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   stop_threshold   : 4611686018427387904
Jan 24 07:01:26 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   silence_threshold: 0
Jan 24 07:01:26 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   silence_size : 0
Jan 24 07:01:26 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   boundary     : 4611686018427387904
Jan 24 07:01:26 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   appl_ptr     : 95099921
Jan 24 07:01:26 ideapad-310 pulseaudio[2724]: [alsa-sink-CX20751/2 Analog] =
alsa-util.c:   hw_ptr       : 95213480

I'd be happy to help you solving this issue if not known already. Please =

feel free to ask for whatever information you'd need.

Pavel =D8ezn=ED=E8ek A. K. A. Cigydd
