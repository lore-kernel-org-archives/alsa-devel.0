From: Markus Korber <korbse@gmx.at>
Subject: period_size and relation to number of samples
Date: Thu, 06 Sep 2007 07:52:37 +0200
Message-ID: <6zps0wwday.fsf@odpc25.int.ondemand.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 93DE11038CE
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Sep 2007 07:52:39 +0200 (CEST)
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

Hello,

one question: If my driver announces the setting below[1], how many
samples must an application provide in a single snd_pcm_writei() or
snd_pcm_mmap_writei() call?

Shouldn't it always send 8192 bytes or 2048 left and right samples (4096
in total) or is it free to send more or less?

Logging data in my chip_playback_copy() function shows the following
(S16_LE, RW_INTERLEAVED):

,----[ mplayer, aplay: ]
| chip_playback_copy (0 -> src: 0xffce1000, #bytes: 0x4000)
| chip_playback_copy (1 -> src: 0xffce1000, #bytes: 0x2000)
| chip_playback_copy (1 -> src: 0xffce1000, #bytes: 0x2000)
`----

,----[ alsaplayer: ]
| chip_playback_copy (0 -> src: 0xffce1000, #bytes: 0x2000)
| chip_playback_copy (0 -> src: 0xffce3000, #bytes: 0x2000)
| chip_playback_copy (0 -> src: 0xffce3000, #bytes: 0x2000)
| [...]
`----

Thus mplayer and aplay provide 16384 bytes (4096 l/r samples) in the
first call and 8192 bytes (2048 l/r samples) for all subsequent calls.
However, alsaplayer provides 8192 bytes (2048 l/r samples) for all
calls.

Now, what is an application allowed to send and what not?  For example,
could an application only send 1024 l/r samples and is the driver
responsible for buffering the data?  Or must it obey the announced
period_size and *always* provide 2048 l/r samples?

Thanks.

,----[ 1 ]
| stream       : PLAYBACK
| access       : RW_INTERLEAVED
| format       : S16_LE
| subformat    : STD
| channels     : 2
| rate         : 44100
| exact rate   : 44100 (44100/1)
| msbits       : 16
| buffer_size  : 4096
| period_size  : 2048
| period_time  : 46439
| tick_time    : 10000
| tstamp_mode  : NONE
| period_step  : 1
| sleep_min    : 0
| avail_min    : 2048
| xfer_align   : 1
| start_threshold  : 2048
| stop_threshold   : 4096
| silence_threshold: 0
| silence_size : 0
| boundary     : 1073741824
| start_mode: DATA
| xrun_mode: STOP
| tstamp_mode: NONE
| period_step: 1
| sleep_min: 0
| avail_min: 2048
| xfer_align: 1
| silence_threshold: 0
| silence_size: 0
| boundary: 1073741824
`----

Regards,
Markus Korber
