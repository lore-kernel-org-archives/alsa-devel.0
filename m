From: Dan Aloni <da-x@colinux.org>
Subject: Re: Re: ALC658 rev 0 - a problem with Rear Right
Date: Mon, 7 Mar 2005 20:55:14 +0200
Message-ID: <20050307185514.GA5738@localdomain>
References: <20050307122800.GA27123@localdomain> <Pine.HPX.4.33n.0503071406300.27740-100000@studcom.urz.uni-halle.de> <20050307153921.GA14807@localdomain> <s5h8y4zwh3f.wl@alsa2.suse.de> <20050307165653.GA22454@localdomain> <s5hvf83v0on.wl@alsa2.suse.de> <20050307182414.GA29156@localdomain> <s5hsm37ux83.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hsm37ux83.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 07, 2005 at 07:28:28PM +0100, Takashi Iwai wrote:
> At Mon, 7 Mar 2005 20:24:14 +0200,
> Dan Aloni wrote:
> > 
> > On Mon, Mar 07, 2005 at 06:13:44PM +0100, Takashi Iwai wrote:
> > > At Mon, 7 Mar 2005 18:57:02 +0200,
> > > Dan Aloni wrote:
> > > > 
> > > > On Mon, Mar 07, 2005 at 05:33:56PM +0100, Takashi Iwai wrote:
> > > > > At Mon, 7 Mar 2005 17:39:21 +0200,
> > > > > Dan Aloni wrote:
> > > > > > 
> > > > > > On Mon, Mar 07, 2005 at 02:10:14PM +0100, Clemens Ladisch wrote:
> > > > > > > Dan Aloni wrote:
> > > > > > > > The problem was introduced in the following changeset, which
> > > > > > > > was supposed to cleanup things but accidently broke something.
> > > > > > > >
> > > > > > > > "[ALSA] Clean up and fix stereo mutes" :
> > > > > > > 
> > > > > > > Most AC'97 codecs have one mute bit for both channels, but some can
> > > > > > > have one for each channel (that's called "stereo mute").
> > > > > > > 
> > > > > > > It seems the new driver enables the stereo mute bits, but then forgets
> > > > > > > to unmute the second channel.
> > > > > > > 
> > > > > > > Does anything happen if you toggle both mute bits in alsamixer?
> > > > > > 
> > > > > > Using alsamixer I am unable to mute any channel by itself - it 
> > > > > > always mutes or unmutes boths channels at the same time (I tried
> > > > > > any possible combination of m M, < or >). However if I revert the
> > > > > > changeset I am able to control each channel alone using < or > and
> > > > > > there's no problem.
> > > > > 
> > > > > Hmm, are you sure that it's ALC658?  AFAIK, the codec doesn't  support
> > > > > the stereo mutes (at least ALSA code doesn't enable it).
> > > > 
> > > > Unless the driver misidentifies the chipset, this is ALC658.
> > > 
> > > Oh yes, indeed.  It's strange that the older version did have the
> > > stereo mute controls.
> > > 
> > > Could you compare the contents of
> > > /proc/asound/card0/codec97#0/ac97#0-0+regs file between the older
> > > ("working") and the latest versions?
> > 
> > I compared and saw no changes in the registers between the latest version 
> > and my version with the reverted changeset.
> 
> Hmm, interesting.
> 
> Just to be sure (I'm back from the travel shortly ago, so might be
> missing something):  the problem persists only on the surround right
> channel?

Yes, only that channel.
 
> And you could mute on/off of "Surround" left/right channels via
> alsamixer independently in the older version?

I can only mute both at the same time with the latest version, but I 
can mute each channel alone with the working version.

-- 
Dan Aloni
da-x@colinux.org


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
