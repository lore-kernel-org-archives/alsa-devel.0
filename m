From: Giuliano Pochini <pochini@shiny.it>
Subject: Click after draining
Date: Tue, 21 Sep 2004 22:13:18 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040921221318.4e0c7c7f.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


With both the powermac driver and my echoaudio driver, playback ends with a
"click". With properly choosen buffer/period/file sizes I can make the card
play almost a whole period of old data before the substream is actually
stopped. It seems that periods after the last one are not silenced, but I'm
not having luck at findind the cause. This is not a recent problem.

For example, I made a test sound that is a pure tone with a quick fade to
silence at the end:
-rw-rw-r--    1 Giu      Giu        606884 set 19 18:56 t2.wav

I played it with: "aplay -B1486077 -F600000 -v t2.wav" because it's slow
enough I can follow debug messages on the screen. I got this trace from the
irq handler (printed just before calling snd_pcm_period_elapsed()):

pcm_trigger start
irq per=1 state=3 bytes=105984, t=1095614506322223
irq per=2 state=3 bytes=211840, t=1095614506921131
irq per=0 state=3 bytes=262272, t=1095614507206088
irq per=1 state=3 bytes=368128, t=1095614507804997
irq per=2 state=3 bytes=473984, t=1095614508403906
irq per=0 state=5 bytes=524416, t=1095614508688863
irq per=1 state=5 bytes=630272, t=1095614509287772 ***
irq per=2 state=5 bytes=736128, t=1095614509886681
pcm_trigger stop

per is the period, state is the runtime state (3=running, 5=draining), bytes
are the number of bytes the DSP read from memory, t is the time_t in useconds.

The line marked with "***" is the period that should be silent (it's past
the end of the file) but still contains old data. Also I don't understand
why it didn't stop the card at that point.

I also looked for this problem on a PC with an intel8x0 chip, but it worked
fine. Any hint to debug this issue is VERY welcome because I'm stuck. 



--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
