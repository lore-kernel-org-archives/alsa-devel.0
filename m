From: "Jeremy Hall" <jhall+alsa-devel@UU.NET>
Subject: Re: two RME9652 cards used as a pcm_multi
Date: Fri, 27 Sep 2002 23:39:13 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <QQnife03307.200209280339@neserve0.corp.us.uu.net>
References: <Pine.LNX.4.33.0209271407440.503-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0209271407440.503-100000@pnote.perex-int.cz> from
 Jaroslav Kysela at "Sep 27, 2002 02:16:21 pm"
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Jeremy Hall <jhall+alsa-devel@UU.NET>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, Jeremy Hall <jhall@UU.NET>
List-Id: alsa-devel@alsa-project.org

I specified nosmp and the lockup still occurred.  That leaves memory
debugging, irq storm, and pci misconfiguration...right?

Which is most likely?

_J

In the new year, Jaroslav Kysela wrote:
> On Fri, 27 Sep 2002, Jeremy Hall wrote:
> 
> > Hello all,
> > 
> > I am using two RME9652 cards together as a single pcm_multi device so that
> > I can get 24 channels both at 48 and 96khz without a cable reconfig.  I
> > have an SMP machine and have noticed that when using the pcm_multi device,
> > all the channels are mapped correctly and seem to work correctly until I
> > use jack and ardour.  If I use a single card with jack and ardour the
> > sessions can start nicely, but if I use the bonded (YICK) pcm_multi
> > setting, the machine will lock up and the card will endlessly replay some
> > material at a rapid rate causing the famous hammerfall hum that is higher
> > in pitch the smaller the frames_per_cycle.
> > 
> > After consulting Paul Davis, the conclusion is that jack exercizes the
> > alsa drivers in unique and interesting ways, exposing subtlties.  I have
> > never been able to get 96khz to work at any frames_per_cycle setting,
> > although I can get 48khz to work if I use 1024 or greater
> > frames_per_cycle.  This is unacceptable to me as I require smaller latency
> > and would expect at least 512 or 256 to work given that I can get a single
> > card to work reliably at 64 frames_per_cycle.
> >
> > The problem seems to occur when XRUNS are detected rapidly such as session
> > initialization or if the CPU can't keep up with some real-time CPU
> > constraints.  I haven't tried this with a UP kernel because I don't know
> > what would happen if I tried to boot a SMP box on a UP kernel--I recall
> > texts saying this was impossible, although this was years ago in the
> > beginning of SMP development.
> 
> Try specify 'nosmp' with SMP kernel at lilo prompt.
> 
> Anyway, the lock up should be avoided. Perhaps, you may try to enable 
> spinlock debugging in your kernel (CONFIG_DEBUG_SPINLOCK in kernel 
> debugging menu) and memory allocation (CONFIG_DEBUG_SLAB) for sure.
> 
> If it does not help to identify the problem, other reasons might be 
> possible:
> 
> - wrong PCI configuration (PCI bus will cause dead-lock)
> - IRQ storm
> 
> 
> 						Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project  http://www.alsa-project.org
> SuSE Linux    http://www.suse.com
> 


-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
