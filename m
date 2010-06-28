From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/4] dump_audiostreaming_interface(): fix
	ac-3 decoder
Date: Mon, 28 Jun 2010 13:40:13 -0700
Message-ID: <20100628204013.GD18443@kroah.com>
References: <1275403951-16253-1-git-send-email-daniel@caiaq.de>
	<1275403951-16253-2-git-send-email-daniel@caiaq.de>
	<20100601165211.GR2695@buzzloop.caiaq.de>
	<20100601170658.GA24055@kroah.com>
	<20100608081019.GE2695@buzzloop.caiaq.de>
	<20100616214023.GB312@kroah.com>
	<20100628184320.GE17530@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E1542447D
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Jun 2010 22:41:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100628184320.GE17530@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: dbrownell@users.sourceforge.net, alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, gregkh@suse.de, t.sailer@alumni.ethz.ch
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 28, 2010 at 08:43:20PM +0200, Daniel Mack wrote:
> On Wed, Jun 16, 2010 at 02:40:23PM -0700, Greg KH wrote:
> > On Tue, Jun 08, 2010 at 10:10:19AM +0200, Daniel Mack wrote:
> > > On Tue, Jun 01, 2010 at 10:06:58AM -0700, Greg KH wrote:
> > > > On Tue, Jun 01, 2010 at 06:52:12PM +0200, Daniel Mack wrote:
> > > > > Greg,
> > > > > 
> > > > > I believe you're maintaining usb-utils now, right? At least it was
> > > > > you posting an announcement for a new release the other day.
> > > > 
> > > > Yes I am.
> > > > 
> > > > > Let me know if I should do anything else to get these patches merged :)
> > > > 
> > > > Let me wake up and get a chance to get around to these patches?  :)
> > > > 
> > > > I'll get to them in a day or so, they look great to me.
> > > 
> > > Just a reminder - could you have a look at them already?
> > > For easier access, the six patches I sent can now also be pulled from
> > > 
> > >   git://github.com/zonque/usbutils.git
> > 
> > I've pulled from this branch now and pushed it all out.  I'll go pick up
> > some other pending patches and cut a new release.
> 
> Just curious - I can't find these patches in the official usbutils.git
> at git.kernel.org. Forgot to push?

Sorry about that, yes, I only had updated the github.com tree.  I now
pushed it out.

greg k-h
