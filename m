From: Carsten Koch <Carsten.Koch@icem.com>
Subject: Re: optical SPDIF output on Abit NF7 nforce2 main board.
Date: Tue, 02 Sep 2003 22:31:40 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F54FE2C.9020208@icem.com>
References: <3F532D5E.6040300@icem.com>	<s5hy8x8oefw.wl@alsa2.suse.de>	<3F534D6A.5030706@icem.com>	<s5hllt8oaye.wl@alsa2.suse.de>	<3F535A42.6020403@icem.com>	<s5hekz0o7wi.wl@alsa2.suse.de>	<3F536C97.5080008@icem.com>	<s5hbru4o444.wl@alsa2.suse.de>	<3F538893.1010801@icem.com>	<s5h7k4snyhl.wl@alsa2.suse.de>	<3F539A3E.3030508@icem.com> <s5hisobmile.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hisobmile.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
...
> looking at the nvidia's driver code, it seems that spdif on nforce
> supports only 48k in fact.
> i'll add the restriction on the driver side, then.
> could you try the attached patch?

Sorry for the delay, I was travelling all day.

I did apply your patch (to my old cvs version, still having
problems accessing sourceforge).

It made matters better for mpg321 and worse for alsaplayer.

"mpg321 -o alsa09 --audiodevice hw:0,1" still plays 44Khz sounds
too fast, as expected.

"mpg321 -o alsa09 --audiodevice plughw:0,1" now plays 44Khz sounds
correctly. Excellent!

"alsaplayer -d hw:0,1"  still plays 44Khz sounds too fast, as expected.

"alsaplayer -d plughw:0,1" now issues the following error messages:
error on set_period_size (512)
Unavailable hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: (166 341334)
PERIOD_SIZE: (7 15053)
PERIOD_BYTES: (28 60212)
PERIODS: (0 2151)
BUFFER_TIME: (158 341316)
BUFFER_SIZE: [7 15052]
BUFFER_BYTES: [28 60208]
TICK_TIME: 10000
error on set_period_size (1024)
Unavailable hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: (166 341334)
PERIOD_SIZE: (7 15053)
PERIOD_BYTES: (28 60212)
PERIODS: (0 2151)
BUFFER_TIME: (158 341316)
BUFFER_SIZE: [7 15052]
BUFFER_BYTES: [28 60208]
TICK_TIME: 10000
failed to configure output device...trying OSS

And plays the sound file via the analog output.

Carsten.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
