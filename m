From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Problem with multiopen on SB Audigy 2
Date: Tue, 7 Oct 2003 20:02:39 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0310071959320.1357@pnote.perex-int.cz>
References: <3F82F126.4000800@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F82F126.4000800@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 7 Oct 2003, James Courtier-Dutton wrote:

> I have 2 sound cards, card 0 is the motherboard intel/alc650 one, and
> card 1 is a SB Audigy2
>
> Playing two streams at once on device "front:1" works: -
> aplay -D front:1 filename.wav
> aplay -D front:1 filename.wav
> So, this is playing two files to the SB Audigy2 front speakers.
> I can hear the two files being mixed together and output together to a
> single set of speakers.
>
> Playing two streams at once on device "rear:1" fails: -
> aplay -D rear:1 filename.wav
> aplay -D rear:1 filename.wav
> So, this is trying to play two files to the SB Audigy2 rear speakers.
>
> The first files comes out of the rear speakers, but the output from the
> second aplay command fails with: -
>
> bash-2.05b# aplay -D rear:1 filename.wav
> Playing WAVE 'filename.wav' : Signed 16 bit Little Endian, Rate 44100
> Hz, Stereo
> ALSA lib setup.c:94:(snd_sctl_install) Cannot lock ctl elem
> aplay: set_params:876: Unable to install hw params:
> ACCESS:  RW_INTERLEAVED
> FORMAT:  S16_LE
> SUBFORMAT:  STD
> SAMPLE_BITS: 16
> FRAME_BITS: 32
> CHANNELS: 2
> RATE: 44100
> PERIOD_TIME: (125011 125012)
> PERIOD_SIZE: 5513
> PERIOD_BYTES: 22052
> PERIODS: 2
> BUFFER_TIME: (250022 250023)
> BUFFER_SIZE: 11026
> BUFFER_BYTES: 44104
> TICK_TIME: 1000
>
> Can you explain why this might be happening?

See "Wave Surround Playback Volume" control in rear definition in
alsa-lib/src/conf/cards/Audigy2.conf. This control is locked thus
the second instance is not able to get lock. I'm not sure about
the right fix now.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
