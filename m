From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Problems with snd_pcm_status_get_delay()
Date: Wed, 9 Oct 2002 08:45:39 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210090844410.519-100000@pnote.perex-int.cz>
References: <s5h8z183mnq.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8z183mnq.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 8 Oct 2002, Takashi Iwai wrote:

> At Wed, 09 Oct 2002 02:25:40 +1000,
> James Courtier-Dutton wrote:
> > 
> > Hello
> > 
> > Can someone please explain to me the use of snd_pcm_status_get_delay()
> > 
> > If a buffer size is 16384, and avail=6384, should delay therefore equil 
> > 10000 ? In all cases ?
> 
> no, the current implementation is the state-sensitive, as you
> mentioned below :
> 
> > I have found that in  SND_PCM_STATE_RUNNING, delay = buffer_size - avail.
> > I have found that in  SND_PCM_STATE_PREPARED, delay = 0
> 
> delay=0 gets back at all states except RUNNING (and DRAINING on
> playback).

Delay functions should return error when the state is not correct. Fixed 
now.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
