From: Mark Knecht <markknecht@attbi.com>
Subject: Re: [linux-audio-user] Re: alsaplayer not working
	with	alsa?
Date: 27 Dec 2002 14:56:22 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1041029783.1285.18.camel@Godzilla>
References: <1040591946.24799.103.camel@Godzilla>
	<20021223133402.GC28223@ecs.soton.ac.uk>
	<1040651206.15371.0.camel@Godzilla>  <s5hznqwu8yj.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hznqwu8yj.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-List <linux-audio-user@music.columbia.edu>, Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

No, just standard Intel hardware...

On Mon, 2002-12-23 at 06:05, Takashi Iwai wrote:
> Hi,
> 
> if you're using a ppc snd-powermac driver, then it's likely a
> long-standing bug of alsa-lib (somehwere deep inside).  it appears
> only on ppc with alsaplayer.  the maintainer is me, but, sorry, atm i
> haven't had a hardware for debugging this...
> 
> have a merry christmas!
> 
> 
> Takashi
> 
> At 23 Dec 2002 05:46:45 -0800,
> Mark Knecht wrote:
> > 
> > Thanks Steve. Merry Xmas!
> > 
> > On Mon, 2002-12-23 at 05:34, Steve Harris wrote:
> > > On Sun, Dec 22, 2002 at 01:19:05 -0800, Mark Knecht wrote:
> > > > [mark@Godzilla mark]$ alsaplayer
> > > > alsaplayer: pcm.c:6293: snd_pcm_unlink_ptr: Assertion `0' failed.
> > > > AlsaPlayer interrupted by signal 6
> > > > [mark@Godzilla mark]$
> > > > 
> > > >    alsaplayer works very well when jack is running.
> > > > 
> > > >    Anyone else seeing this?
> > > 
> > > Yes.
> > > 
> > > I suspect that Fernando needs to update alsaplayer.
> > > 
> > > - Steve
> > 
> > 
> > 
> > 
> > -------------------------------------------------------
> > This sf.net email is sponsored by:ThinkGeek
> > Welcome to geek heaven.
> > http://thinkgeek.com/sf
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/alsa-devel
> > 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
