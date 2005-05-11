From: Greg KH <greg@kroah.com>
Subject: Re: snd-usb-audio driver
Date: Wed, 11 May 2005 00:41:19 -0700
Message-ID: <20050511074119.GB10647@kroah.com>
References: <20050510214300.GA4292@kroah.com> <Pine.HPX.4.33n.0505110932530.29117-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0505110932530.29117-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: linux-hotplug-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, May 11, 2005 at 09:37:37AM +0200, Clemens Ladisch wrote:
> Greg KH wrote:
> > On Mon, May 09, 2005 at 09:41:19AM +0200, Clemens Ladisch wrote:
> > > I'll make a temporary fix to bind to the first interface that is
> > > probed.
> >
> > That will not work a usb speaker device that has the first interface as
> > the usb keyboard :)
> >
> > Why not just point the struct device for ALSA at the struct
> > usb_interface that is passed to you?
> 
> This is exactly what I actually meant when I said "probed".
> 
> Fixed now.

Ah, ok, sorry for the confusion.

greg k-h


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
