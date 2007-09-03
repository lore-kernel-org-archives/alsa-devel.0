From: Markus Korber <korbse@gmx.at>
Subject: ALSA lib troubles with xine
Date: Mon, 03 Sep 2007 08:53:12 +0200
Message-ID: <6zk5r8fdev.fsf@odpc25.int.ondemand.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id B04C31038F1
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Sep 2007 08:53:14 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I've got problems using ALSA (hg) and xine-lib (1.1.7).  I'm trying to
use fbxine for playback but ALSA debug logging gives me:

,----
| audio_alsa_out: Audio Device name = default
| audio_alsa_out: Number of channels = 2
| Buffer size range from 4096 to 0            <- !!!
| Period size range from 0 to 0               <- !!!
| Buffer time size 44100
| To choose buffer_size = 4096
| To choose period_size = 512
| was set period_size = 0
| was set buffer_size = 4096
| audio_alsa_out:open pause_resume=1
| ACCESS:  RW_INTERLEAVED
| FORMAT:  S16_LE
| SUBFORMAT:  STD
| SAMPLE_BITS: 16
| FRAME_BITS: 32
| CHANNELS: 2
| RATE: 44100
| PERIOD_TIME: (46439 46440)
| PERIOD_SIZE: 2048
| PERIOD_BYTES: 8192
| PERIODS: 2
| BUFFER_TIME: (92879 92880)
| BUFFER_SIZE: 4096
| BUFFER_BYTES: 16384
| TICK_TIME: 10000
| audio_alsa_out: Unable to set swparams: Invalid argument
`----

So buffer and period sizes seem to be wrong and therefore I get no
sound.  (audio_alsa_out logging from [1].)  Next I've tried to run
speaker-test and the ouptut look good:

,----
| [root@(none) ~]# speaker-test 
| 
| speaker-test 1.0.15rc1
| 
| Playback device is default
| Stream parameters are 48000Hz, S16_LE, 1 channels
| Using 16 octaves of pink noise
| Rate set to 48000Hz (requested 48000Hz)
| Buffer size range from 4096 to 4096
| Period size range from 2048 to 2048
| Using max buffer size 4096
| Periods = 4
| was set period_size = 2048
| was set buffer_size = 4096
|  0 - Front Left
`----

Both applications are linked against the same ALSA library (dynamic or
static linkage doesn't make a difference - speaker-test always works and
xine always fails).  And both applications use the same instructions
(snd_pcm_hw_params_get_period_size_min/max()) AFAICS.

Any ideas what I could try next?  Thanks.

Toolchain: buildroot based arm gcc 4.2.1 with uclibc 0.9.29.  However,
other applications (mplayer, aplay, alsaplayer) work as well, so I guess
it's not toolchain related.

[1] http://xine.cvs.sourceforge.net/xine/xine-lib/src/audio_out/audio_alsa_out.c

Regards,
Markus Korber
