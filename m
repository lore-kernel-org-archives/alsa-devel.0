From: nick phillips <np@f-matic.net>
Subject: ALSA and broken pipes?
Date: Thu, 04 Sep 2003 10:41:15 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1062690075.18181.17.camel@debian>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hello list,

Wondering if someone here could point me to a solution for getting sound
working out of an EMI 2|6 usb soundcard. I'm using debian sid, 2.4.19,
alsa 0.9.6, and have my internal soundcard configured as soundcard0, my
usb card as soundcard1. Internal sound works great, but when I try to
play anything through the soundcard with 'aplay -plughw:1 sound.wav", I
get the following error message:

Alsa lib pcm_hw.c:494:(snd_pcm_hw_start) - SNDDRV_PCM_IOCTL_START Failed
- Broken pipe.

Any idea what the problem could be? I can't seem to get alsa working at
all without the plughw option since it complains of invalid formats
(according to /proc/asound/card1/stream0 the card accepts S16_LE and
S24_LE).

Any help would be much appreciated!

best,
Nick



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
