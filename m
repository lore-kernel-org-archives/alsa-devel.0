From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: jack plugin?
Date: Wed, 29 Oct 2003 00:37:39 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031029003739.6b69b361.mista.tapas@gmx.net>
References: <20031027175032.1d0760f3.mista.tapas@gmx.net>
	<s5h7k2p61f1.wl@alsa2.suse.de>
	<s5hekwx44ht.wl@alsa2.suse.de>
	<s5hbrs1443p.wl@alsa2.suse.de>
	<20031028210623.36867d0d.mista.tapas@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031028210623.36867d0d.mista.tapas@gmx.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: tiwai@suse.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 28 Oct 2003 21:06:23 +0100
Florian Schmidt <mista.tapas@gmx.net> wrote:

> What formats are alsa-plugins usually? [.so, .sa]
> What format is used by the jack plugin
> Which paths does libalsa look at when loading a plugin?
> How does the makefile of the jack plugin determine, where the plug
> goes?
> 

I found out that i had two alsa-versions installed [bad]. Ok, i still
get the same error with:

make install-jack

but i copied it manually to 

/usr/lib/alsa-lib

and i got aplay to play over it [using the jackplug as defined in the
example .asoundrc]. But here the sound is heavily distorted [sounds like
constant buffer underruns] and produces loads of text like this[1]:

I also could set the alsa outputplugin of xmms to jackplug, and it
seemed to play. at first it played silence and then after some tries it
played noise [a humming noise]..




[1]
tapas@mango:~$ aplay -D jackplug foo.wav
snd_pcm_jack_open
snd_pcm_jack_info
Playing WAVE 'foo.wav' : Signed 16 bit Little Endian, Rate 22050 Hz,
Stereo
snd_pcm_jack_hw_refine
snd_pcm_jack_hw_refine
snd_pcm_jack_hw_refine
snd_pcm_jack_hw_refine


...
[snipped some of these]
...


snd_pcm_jack_hw_refine
snd_pcm_jack_hw_refine
snd_pcm_jack_hw_refine
snd_pcm_jack_hw_refine
snd_pcm_jack_hw_refine
snd_pcm_jack_hw_refine
snd_pcm_jack_hw_refine
snd_pcm_jack_hw_refine
snd_pcm_jack_hw_refine
snd_pcm_jack_hw_refine
snd_pcm_jack_hw_params
snd_pcm_jack_sw_params
snd_pcm_jack_mmap
snd_pcm_jack_channel_info
snd_pcm_jack_channel_info
snd_pcm_jack_sw_params
snd_pcm_jack_sw_params
snd_pcm_jack_sw_params
snd_pcm_jack_prepare
snd_pcm_jack_sw_params
snd_pcm_jack_state
snd_pcm_jack_avail_update appl=0 hw=0 ret=24002
snd_pcm_jack_avail_update appl=0 hw=0 ret=24002
snd_pcm_jack_state
snd_pcm_jack_state
snd_pcm_jack_avail_update appl=5998 hw=0 ret=18004
snd_pcm_jack_avail_update appl=5998 hw=0 ret=18004
snd_pcm_jack_state
snd_pcm_jack_state
snd_pcm_jack_avail_update appl=11997 hw=0 ret=12005
snd_pcm_jack_avail_update appl=11997 hw=0 ret=12005
snd_pcm_jack_state
snd_pcm_jack_state
snd_pcm_jack_avail_update appl=17997 hw=0 ret=6005
snd_pcm_jack_avail_update appl=17997 hw=0 ret=6005
snd_pcm_jack_state
snd_pcm_jack_start
PROCESS 2! (256)
connected alsaP:out_000
 to alsa_pcm:playback_1
connected alsaP:out_001
 to alsa_pcm:playback_2
snd_pcm_jack_state
snd_pcm_jack_hwsync
snd_pcm_jack_avail_update appl=23996 hw=0 ret=6
PROCESS 3! (256)
snd_pcm_jack_process_cb hw=0=0 + nframes=256 / frames=256 /
bufsize=24002
jack_process = 256
snd_pcm_jack_poll_revents
snd_pcm_jack_hwsync
snd_pcm_jack_avail_update appl=23996 hw=256 ret=262
PROCESS 3! (256)
snd_pcm_jack_process_cb hw=256=256 + nframes=256 / frames=256 /
bufsize=24002
jack_process = 512
snd_pcm_jack_poll_revents
snd_pcm_jack_hwsync
snd_pcm_jack_avail_update appl=23996 hw=512 ret=518
PROCESS 3! (256)
snd_pcm_jack_process_cb hw=512=512 + nframes=256 / frames=256 /
bufsize=24002
jack_process = 768
snd_pcm_jack_poll_revents
snd_pcm_jack_hwsync
snd_pcm_jack_avail_update appl=23996 hw=768 ret=774
PROCESS 3! (256)
snd_pcm_jack_process_cb hw=768=768 + nframes=256 / frames=256 /
bufsize=24002
jack_process = 1024
snd_pcm_jack_poll_revents
snd_pcm_jack_hwsync
snd_pcm_jack_avail_update appl=23996 hw=1024 ret=1030
PROCESS 3! (256)
snd_pcm_jack_process_cb hw=1024=1024 + nframes=256 / frames=256 /
bufsize=24002
jack_process = 1280
snd_pcm_jack_poll_revents
snd_pcm_jack_hwsync
snd_pcm_jack_avail_update appl=23996 hw=1280 ret=1286
PROCESS 3! (256)
snd_pcm_jack_process_cb hw=1280=1280 + nframes=256 / frames=256 /
bufsize=24002
jack_process = 1536
snd_pcm_jack_poll_revents
snd_pcm_jack_hwsync
snd_pcm_jack_avail_update appl=23996 hw=1536 ret=1542
PROCESS 3! (256)
snd_pcm_jack_process_cb hw=1536=1536 + nframes=256 / frames=256 /
bufsize=24002
jack_process = 1792
snd_pcm_jack_poll_revents
snd_pcm_jack_hwsync
snd_pcm_jack_avail_update appl=23996 hw=1792 ret=1798
PROCESS 3! (256)
snd_pcm_jack_process_cb hw=1792=1792 + nframes=256 / frames=256 /
bufsize=24002
jack_process = 2048
snd_pcm_jack_poll_revents
snd_pcm_jack_hwsync
snd_pcm_jack_avail_update appl=23996 hw=2048 ret=2054
PROCESS 3! (256)
snd_pcm_jack_process_cb hw=2048=2048 + nframes=256 / frames=256 /
bufsize=24002
jack_process = 2304
snd_pcm_jack_poll_revents
snd_pcm_jack_hwsync
snd_pcm_jack_avail_update appl=23996 hw=2304 ret=2310
PROCESS 3! (256)
snd_pcm_jack_process_cb hw=2304=2304 + nframes=256 / frames=256 /
bufsize=24002
jack_process = 2560


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
