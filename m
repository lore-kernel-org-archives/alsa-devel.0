From: Manuel Jander <manuel.jander@mat.utfsm.cl>
Subject: Re: ALSA lib application compatibility [was] Re: [Alsa-devel]
 mixer	device
Date: Tue, 18 May 2004 10:23:45 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1084890225.1835.23.camel@localhost>
References: <1084218706.31496.72.camel@shrek.bitfreak.net>
	 <Pine.HPX.4.33n.0405121735410.26780-100000@studcom.urz.uni-halle.de>
	 <20040513153457.GE6913@sunrise.pg.gda.pl>
	 <Pine.LNX.4.58.0405181545510.13943@spring>
	 <1084887054.1835.14.camel@localhost>  <s5had053hn2.wl@alsa2.suse.de>
Reply-To: mjander@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5had053hn2.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

On Tue, 2004-05-18 at 17:00 +0200, Takashi Iwai wrote:
> At Tue, 18 May 2004 09:30:54 -0400,
> Manuel Jander wrote:
> > 
> > Hi,
> > 
> > On Tue, 2004-05-18 at 15:46 +0200, barat@medien.uni-weimar.de wrote:
> > > On Thu, 13 May 2004, Adam Tla/lka wrote:
> > > 
> > > > On Wed, May 12, 2004 at 05:40:55PM +0200, Clemens Ladisch wrote:
> > > > 
> > > > ALSA is complicated and we have no good manual describing proper use
> > > > of its api. You can easily prove this: many programs have ALSA output
> > > > modules but they are working worse then when using OSS.
> > > > For example mplayer with OSS synchronizes video and sound much faster
> > > > in case of network streaming. XMMS is broken too.
> > > ?? mplayer isn't broken in any way with alsa. it supports alsa since the 
> > > early days and also current versions very well. please don't talk 
> > > bullshit.
> > > it probably does av-sync faster at some particular streams (what ever you 
> > > mean with that) with oss, but i never ever saw some significant 
> > > performance differences compared to oss.
> > > at least it supports real mmaped-io for up to 2 channels.
> > > 
> > 
> > Unfortunately i have to agree with Clemens. In my opinion the ALSA API
> > is giving the applications too much freedom in choosing parameters and
> > does not enforce any restrictions on hardware that can't support them.
> 
> basically, such a restriction is up to the driver.  in the ideal
> world, hw_constraints should be able to handle these cases
> properly...

Yeah, right, but many application just fail. Even aplay is very picky
about impossible period sizes sometimes.

> > As the main author of the Aureal Vortex driver, its very stupid having
> > to handle arbitrary period sizes, introducing a lot of overhead and
> > complexity in the driver, while the hardware just is not designed to
> > handle period sizes that are not powers of two, due to page boundary
> > overlapping trouble. Obviously as a result, OSS works much better, since
> > it almost ever chooses the biggest buffer possible, resulting in a sane
> > period size. Period sizes of 314.15.14 bytes are just silly, plain
> > stupid. The user won't notice any difference if its 256 instead, but
> > since the app insist in such period sizes it just fails, and the user
> > gets no sound all. The behaviour of the user application in the end
> > depends too much on the hardware it is running on.
> 
> first, the power of two is not a golden rule for every sound chip.
> for some chips, it's difficult to handle such period/buffer sizes.

Yes, it just a particular case in the chip took as example...

> in theory, we can set the hw_constraint for the buffer/period sizes in
> power of two.  yes, i tried it, but it failed.  this is because ALSA
> handles the buffer/period sizes in two different units, frames and
> time in msec.  IMO, it was a wrong decision to use different units for
> the single purpose.  maybe we need a workaround not to mix up these
> units in the configurator.

Yes, i think that the hardware constraint scheme of ALSA is very
powerful, but the problem is that it fails. It would be great if it
could be mopified to be failproof, that is, allow the application to
work somehow regardless of what restrictions must be taken.

> > AFAIK, the ICE1712 has exactly the same hardware restriction. I know
> > that the via driver does cope with this, but that particular hardware
> > has special hardware resources for such a thing, where other hardware
> > don't.
> 
> ICE1712 has no problem regarding this.  its problem is that the
> max. buffer size is 64k even though it always uses 32bit x 10
> channels.
> 
> > The cost of allowing any parameter value is not worth it in my opinion.
> > Its actually causing a lot of trouble.
> 
> not all parameters are accepted.  it depends on the driver
> implementation.

That right, but applications should be able to cope with that, and use
alternative fallback values.

> please don't misunderstand:  i don't mean that the current ALSA design
> is perfect.  it's not at all, as you know :)
> however, the basic design of ALSA is that it leaves such a
> reststriction purely to the driver implementation.  if your driver
> allows everyhing, it's the driver's responsibility to support
> everyhing.

Thats why i'm trying to contribute some feedback :D

> unfortunately, the power-of-two restriction doesn't work well because
> of the failure of configurator.  it's an exceptional case.

Thats bad luck :(

Best Regards

Manuel Jander





-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
