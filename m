From: Ed Wildgoose <Ed@Wildgooses.com>
Subject: Problem with simultaneous 16bit Rec/play with rme96/8
Date: Sat, 12 Jul 2003 19:35:09 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F1054DD.30301@Wildgooses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi,

I have an RME 96/8 PAD card and I have tried various versions of the 
alsa driver from 0.9 up to 0.94 and I'm seeing a consistent problem with 
simultaneous play and record at 16 bit sample levels with OSS

For example running:
sox -r 44100 -t ossdsp -w -s -c 2 /dev/dsp test.wav

is fine, but then in another window doing this:

gentoo root # aplay test.wav
Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
ALSA lib pcm_hw.c:324:(snd_pcm_hw_hw_params) SNDRV_PCM_IOCTL_HW_PARAMS 
failed: Device or resource busy
aplay: set_params:840: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: (46439 46440)
PERIOD_SIZE: 2048
PERIOD_BYTES: 8192
PERIODS: 8
BUFFER_TIME: (371519 371520)
BUFFER_SIZE: 16384
BUFFER_BYTES: 65536
TICK_TIME: 10000

However, everything is OK if I use only ALSA, for example:
arecord -r 44100 -t wav -c 2 -f S16_LE test.wav

...works fine when I then use "aplay test.wav"

Is this a known problem?

Also, I don't know if it is related, but under gentoo + KDE, when artsd 
starts I get the following error message:

Sound server informational message:
Error while initializing the sound driver:
SNDCTL_DSP_SPEED failed - Device or resource busy
The sound server will continue, using the null output device.


My /etc/asound.conf:

      pcm.rme96 {
          type hw
          card 0
        }

        ctl.rme96 {
          type hw
          card 0
        }

Thanks for any help

Ed W









-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
