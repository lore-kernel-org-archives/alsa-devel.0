From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: pcm_multi poll timeout error
Date: Mon, 31 Jul 2006 22:04:26 -0400
Message-ID: <1154397867.14540.5.camel@mindpipe>
References: <20051209171605.GA4132@localhost.localdomain>
	<200512091755.jB9HtR5i008279@sith.maoz.com>
	<20051209201502.GA3751@localhost.localdomain>
	<s5h4q5ezh4e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h4q5ezh4e.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: John Rigg <ad@carbon-black.co.uk>, alsa-devel@lists.sourceforge.net, Paul Davis <paul@linuxaudiosystems.com>, Jeremy Hall <jhall@maoz.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2005-12-12 at 12:31 +0100, Takashi Iwai wrote:
> At Fri, 9 Dec 2005 20:15:02 +0000,
> John Rigg wrote:
> > 
> > On Fri, Dec 09, 2005 at 12:55:27PM -0500, Jeremy Hall wrote:
> > > In the new year, John Rigg wrote:
> > > > On Fri, Dec 09, 2005 at 12:40:05PM +0100, Takashi Iwai wrote:
> > > > > The link_fd returns the file descriptor for linking multiple PCM
> > > > > streams.  If you comment it out, it means that no link is possible.
> > > > > It means that snd_pcm_link() didn't do anything in fact after your
> > > > > patch.
> > > > 
> > > > I can't understand why this works after my patch broke snd_pcm_link .
> > >
> > > It probably works because the rme cards are synced by an external means 
> > > such as word clock or the entity they are connected to has master sync
> > 
> > Makes sense. So, the situation appears to be:
> > 1 - The link code is unnecessary for duplex operation of multiple
> > clock-synchronised sound cards with jackd.
> > 2 - It breaks the above when present.
> 
> Hm, the question is what the cable-sync really does.  Basically the
> linked PCM streams in ALSA are just for trigger actions,
> i.e. start/stop streams.  The others are not really related.
> 
> However, the recent changes of multi pcm tries to use only one pollfd
> as a master, and this seems broken in your case.  Or, it's really the
> matter of linked streams.
> 
> Will come back to this issue later...
> 

Takashi-san,

I'm not sure I fully understand - are you saying JACK is broken or that
it's an ALSA bug?

Lee


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
