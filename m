From: barat@medien.uni-weimar.de
Subject: Re: mixer device
Date: Tue, 18 May 2004 15:46:19 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0405181545510.13943@spring>
References: <1084218706.31496.72.camel@shrek.bitfreak.net>
 <Pine.HPX.4.33n.0405121735410.26780-100000@studcom.urz.uni-halle.de>
 <20040513153457.GE6913@sunrise.pg.gda.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040513153457.GE6913@sunrise.pg.gda.pl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adam Tla/lka <atlka@pg.gda.pl>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 13 May 2004, Adam Tla/lka wrote:

> On Wed, May 12, 2004 at 05:40:55PM +0200, Clemens Ladisch wrote:
> > Ronald S. Bultje wrote:
> > > for a given alsa device ("default", "dmix", "plughw:N", "hw:N,M",
> > > "dspN", etc.), how do I automatically obtain the right device to use as
> > > a audio mixer with that device?
> > 
> > Depends on your definition of "right device".  In the general case
> > this isn't possible because many cards don't have any mixer controls,
> > or don't have the controls you want to use.  Or the pcm device uses
> > several cards, or none.
> > 
> > What do you want to do with the mixer?
> Hmm - typically people just want to control PCM volume.
> When using OSS you can just do mixer ioctl's on the opened PCM fd.
> Simple and clear. With many virtual PCM streams it is working
> too (non-free version).
> If we haven't hardware volume control this function is emulated.
> It is not working with ALSA OSS emulation nor aoss.
> So how a program could in a simple way obtain information which control to
> use to set the volume level of particular stream?
> 
> ALSA is complicated and we have no good manual describing proper use
> of its api. You can easily prove this: many programs have ALSA output
> modules but they are working worse then when using OSS.
> For example mplayer with OSS synchronizes video and sound much faster
> in case of network streaming. XMMS is broken too.
?? mplayer isn't broken in any way with alsa. it supports alsa since the 
early days and also current versions very well. please don't talk 
bullshit.
it probably does av-sync faster at some particular streams (what ever you 
mean with that) with oss, but i never ever saw some significant 
performance differences compared to oss.
at least it supports real mmaped-io for up to 2 channels.

best regards / mit freundlichen gruessen

Zsolt Barat



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
