From: Lee Revell <rlrevell@joe-job.com>
Subject: Weird XRUN trace
Date: Tue, 13 Jul 2004 16:44:00 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1089751439.22175.6.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jul 13 15:36:18 mindpipe kernel:
Jul 13 15:36:18 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:199: Unexpected hw_pointer value [1] (stream = 0, delta: -30, max jitter = 32): wrong interrupt acknowledge?
Jul 13 15:36:18 mindpipe kernel:  [__crc_totalram_pages+1386981/5353478] snd_pcm_period_elapsed+0x1af/0x410 [snd_pcm]
Jul 13 15:36:18 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 13 15:36:18 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 13 15:36:18 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 13 15:36:18 mindpipe kernel:  [__crc_totalram_pages+1386981/5353478] snd_pcm_period_elapsed+0x1af/0x410 [snd_pcm]
Jul 13 15:36:18 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 15:36:18 mindpipe kernel:  [__end_that_request_first+0/528] __end_that_request_first+0x0/0x210
Jul 13 15:36:18 mindpipe kernel:  [__crc_totalram_pages+1386981/5353478] snd_pcm_period_elapsed+0x1af/0x410 [snd_pcm]
Jul 13 15:36:18 mindpipe kernel:

Why is snd_pcm_period_elapsed on the stack three times?

Lee 



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
