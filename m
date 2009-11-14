From: Reiner <reiner1210@googlemail.com>
Subject: no sound when using TV-OUT
Date: Sat, 14 Nov 2009 11:16:56 +0100
Message-ID: <4AFE8398.8050900@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f217.google.com (mail-bw0-f217.google.com
	[209.85.218.217])
	by alsa0.perex.cz (Postfix) with ESMTP id D9EB92440C
	for <alsa-devel@alsa-project.org>; Sat, 14 Nov 2009 11:17:00 +0100 (CET)
Received: by bwz9 with SMTP id 9so10590084bwz.32
	for <alsa-devel@alsa-project.org>; Sat, 14 Nov 2009 02:16:59 -0800 (PST)
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

here is the trace Mplayer gives me

Opening audio decoder: [mp3lib] MPEG layer-2, layer-3

AUDIO: 48000 Hz, 2 ch, s16le, 192.0 kbit/12.50% (ratio: 24000->192000)

Selected audio codec: [mp3] afm: mp3lib (mp3lib MPEG layer-2, layer-3)

==========================================================================

[AO OSS] audio_setup: Can't open audio device /dev/dsp: Permission
denied
[AO_ALSA] alsa-lib: confmisc.c:768:(parse_card) cannot find card '0'

[AO_ALSA] alsa-lib: conf.c:4154:(_snd_config_evaluate) function
snd_func_card_driver returned error: Permission denied
[AO_ALSA] alsa-lib: confmisc.c:392:(snd_func_concat) error evaluating
strings
[AO_ALSA] alsa-lib: conf.c:4154:(_snd_config_evaluate) function
snd_func_concat returned error: Permission denied
[AO_ALSA] alsa-lib: confmisc.c:1251:(snd_func_refer) error evaluating
name
[AO_ALSA] alsa-lib: conf.c:4154:(_snd_config_evaluate) function
snd_func_refer returned error: Permission denied
[AO_ALSA] alsa-lib: conf.c:4633:(snd_config_expand) Evaluate error:
Permission denied
[AO_ALSA] alsa-lib: pcm.c:2211:(snd_pcm_open_noupdate) Unknown PCM
default
[AO_ALSA] Playback open error: Permission denied
[AO ESD] esd_open_sound failed: Connection timed out

waitpid(): No child processes
AO: [pulse] Init failed: Internal error
[JACK] cannot open server
[AO SDL] Samplerate: 48000Hz Channels: Stereo Format s16le
[AO_ALSA] alsa-lib: confmisc.c:768:(parse_card) cannot find card '0'
[AO_ALSA] alsa-lib: conf.c:4154:(_snd_config_evaluate) function
snd_func_card_driver returned error: Permission denied
[AO_ALSA] alsa-lib: confmisc.c:392:(snd_func_concat) error evaluating
strings
[AO_ALSA] alsa-lib: conf.c:4154:(_snd_config_evaluate) function
snd_func_concat returned error: Permission denied
[AO_ALSA] alsa-lib: confmisc.c:1251:(snd_func_refer) error evaluating name
[AO_ALSA] alsa-lib: conf.c:4154:(_snd_config_evaluate) function
snd_func_refer returned error: Permission denied
[AO_ALSA] alsa-lib: conf.c:4633:(snd_config_expand) Evaluate error:
Permission denied
[AO_ALSA] alsa-lib: pcm.c:2211:(snd_pcm_open_noupdate) Unknown PCM default
waitpid(): No child processes
[AO SDL] Unable to open audio: No available audio device
DVB card number must be between 1 and 4
AO: [null] 48000Hz 2ch s16le (2 bytes per sample)
Starting playback...
