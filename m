From: Andi Kleen <ak@suse.de>
Subject: Re: [discuss] Re: unregister_ioctl32_conversion and modules. ioctl32 revisited.
Date: Thu, 16 Dec 2004 06:03:56 +0100
Message-ID: <20041216050356.GH32718@wotan.suse.de>
References: <20041215065650.GM27225@wotan.suse.de> <20041215074635.GC11501@mellanox.co.il> <s5hbrcvqv7r.wl@alsa2.suse.de> <1103135460.18982.68.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1103135460.18982.68.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, pavel@suse.cz, discuss@x86-64.org, gordon.jin@intel.com, alsa-devel <alsa-devel@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 15, 2004 at 01:30:59PM -0500, Lee Revell wrote:
> On Wed, 2004-12-15 at 19:20 +0100, Takashi Iwai wrote:
> > At Wed, 15 Dec 2004 09:46:35 +0200,
> > Michael S. Tsirkin wrote:
> > > 
> > > There were two additional motivations for my patch:
> > > 1. Make it possible to avoid the BKL completely by writing
> > >    an ioctl with proper internal locking.
> > > 2. As noted by  Juergen Kreileder, the compat hash does not work
> > >    for ioctls that encode additional information in the command, like this:
> > > 
> > > #define EVIOCGBIT(ev,len)  _IOC(_IOC_READ, 'E', 0x20 + ev, len)
> > 
> > I like the idea very well.  Other benifits in addition:
> > 
> 
> How does this all relate to Ingo's ->unlocked_ioctl stuff which is "an
> official way to do BKL-less ioctls"?

This is another "official" way which is more powerful. I suppose it will
replace Ingo's patch.

-Andi


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
