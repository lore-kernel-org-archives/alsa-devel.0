From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Audio and Video sync. Getting Timestamps
Date: Wed, 5 May 2004 11:39:06 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0405051137240.3593@pnote.perex-int.cz>
References: <1083748400.4098b030eeb58@www.telecable.es> <s5hn04n1aer.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hn04n1aer.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: granda@telecable.es, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 5 May 2004, Takashi Iwai wrote:

> > I set SND_TSTAMP_MMAP like you told me. What function may i use? I've tried
> > snd_pcm_status_get_trigger_tstamp and snd_pcm_status_get_tstamp, and the first
> > always return the same timestamp or it changes every 4 or 6 seconds. And the
> > second returns the "now" timestamp. What am i doing wrong?
> 
> no, you're not wrong, i overlooked that the SND_PCM_STATUS ioctl calls
> the update of timestamp.  so, apparently there is no this timestamp
> mode for the period-updates.
> 
> but, anyway, you can get the sound frame position and the timestamp at
> the same time.  it should suffice to calculate the sync, i believe.

That's right. The semantics is - mark timestamp when the stream pointer
is updated - not at period boundary (which can be shifted with interrupt 
latency issues).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
