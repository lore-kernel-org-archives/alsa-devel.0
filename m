From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: New PCM API extension
Date: Thu, 27 Feb 2003 15:22:11 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302271508510.2325-100000@pnote.perex-int.cz>
References: <Pine.LNX.4.44.0302271408580.24556-100000@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0302271408580.24556-100000@ecabase.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, Abramo Bagnara <abramo@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 27 Feb 2003, Kai Vehmanen wrote:

> Hi,
> 
> sorry for the late response.
> 
> On Sat, 22 Feb 2003, Jaroslav Kysela wrote:
> 
> > 	I've added the snd_pcm_forward() function. This function is
> > function with opposite meaning to snd_pcm_rewind() - it skips given count
> > of frames (note that in the ring buffer are unchanged, only the r/w
> > pointer is increased). The application has full control on the r/w pointer
> > now. It's useful mainly in the no-xrun mode where the stream runs forever.
> 
> I think this is a good addition, especially considering we already have
> the rewind function. I actually have some existing no-xrun code, where I
> need to do dummy write/reads if the app side is late. pcm_forward() is 
> just the thing for handling these scenerios.

Note that we had and have the snd_pcm_reset() function which sync the r/w 
ptr with the h/w ptr already (thus avail == ring_buffer for playback and 
avail == 0 for capture).

The new function is intended for these applications:

1) real-time networking (UDP) - there is no guarantee the order of 
   received packets; application might do the stream composing directly
   inside the ring buffer (thus avoid one copy) now
2) writing ahead when xrun condition happens (in no xrun mode); the 
   forward function allows to write data ahead of current hw_ptr to 
   decrease possibility of next - very close - xrun
3) accurate stream position, the snd_pcm_reset() function doesn't tell us
   how many frames were skipped; using snd_pcm_forward(), we don't lose
   this information

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
