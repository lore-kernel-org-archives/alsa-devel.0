From: Antonio Willy Malara <behappy@maialone.com>
Subject: .asoundrc plugin setup
Date: Sat, 4 Oct 2003 12:22:24 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031004102224.GA21682@Zeryn>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

i have some troubles with an usb-audio device (an imic) on linux ppc 
(an ibook2), i think becouse of endianness related troubles..

my big trouble is that jack says:

willy@Zeryn:~$ jackd -d alsa -d hw:1
jackd 0.80.0
[...]
JACK compiled with System V SHM support
loading driver ..
creating alsa driver ... hw:1|hw:1|1024|2|48000|nomon|swmeter|rt
open
Sorry. The audio interface "hw:1"doesn't support either of the two 
hardware sample formats that jack can use.
ALSA: cannot configure capture channel
starting engine
engine driver not set; cannot start
[...]

i've setupped an .asounrc like that:

pcm.imic {
         type hw
         card 1
}
  ctl.imic2 {
         type hw
         card 1
}
  pcm_slave.sl3 {
         pcm imic
         format S16_LE
}
  pcm.imic2 {
         type plug
         slave sl3
}

and jack at least start, but it dont playback anything:

willy@Zeryn:~$ jackd -d alsa -d imic2
jackd 0.80.0
[...]
creating alsa driver ... imic2|imic2|1024|2|48000|nomon|swmeter|rt
open
You appear to be using the ALSA software "plug" layer, probably
[...]

You appear to be using the ALSA software "plug" layer, probably
[...] starting engine
ALSA lib pcm_hw.c:494:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed: 
Broken pipe
could not start playback (Broken pipe)
jackd: signal 2 received
jack main caught signal 2
received signal 15 during shutdown (ignored)
willy@Zeryn:~$

its a mine fault or alsa fault?? i think that with that .asoundrc this 
things should work...

tanks for attention
wil


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
