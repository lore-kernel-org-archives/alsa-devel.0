From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: [PATCH] cs46xx update SMP fixes
Date: Thu, 22 Aug 2002 16:13:07 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D64F173.509@cucumelo.org>
References: <3D64B60D.5070907@cucumelo.org>	<s5hit23t65p.wl@alsa2.suse.de>	<3D64E811.30005@cucumelo.org> <s5h65y3t3j8.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>
>how about to do pcm_link/unlink in open/close or prepare callback?
>they are definitely not called from interrupts.
>
The idea of calling  pcm_unlink in trigger (PLAYBACK_STOP) function is 
to stop the DMA tranfers,
and so on stop the  DSP from requesting interrupts, and still have the 
channel prepared
to be quickly started again on trigger (PLAYBACK_START/RESUME).

Another idea  that I have in mind is to use in_interrupt() && 
schedule_task() functions, then if _trigger
function is called from interrupt context, mute/unmute pcm channel,  use 
schedule_task() to
indirectly invoke pcm_link/unlink. Otherwise if not in interrupt context 
call pcm_link/unlnk
directly using mutexes.
What do you think ?

/Benny




-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
