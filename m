From: Michael Jochum <e9725005@stud3.tuwien.ac.at>
Subject: Re: rtcw,quake3 hang on exit
Date: 08 Apr 2002 22:01:49 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1018296113.12764.0.camel@mjo>
References: <1016654302.933.2.camel@mjo>  <s5hadsemds5.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <s5hadsemds5.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2002-04-08 at 17:05, Takashi Iwai wrote:
> i got the point.
> snd_pcm_playback_drain() (which is called at closing the pcm) never
> returns when OSS is running on mmap mode. 
> now fixed on cvs.  please give a try.

i tried cvs - quake3 and rtcw don`t hang on exit now - BUT there is no
sound at all during the game. there is sound during the intro and when
moving the mouse over the buttons in the main menu but no sound during
the game. maybe the intro does not use the mmap mode?

i applied your patch to 0.9.0beta12 and get the same result as with cvs.
the sound works with the original 0.9.0beta12 there is only that exit
bug.

i can not say how much i appreciate your help with this problem! i
already gave up on that matter.


ciao,
michael

btw what kind of information would help you with solving the problem?
strace? 
