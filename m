From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [Alsa-devel] snd-usb-audio driver
Date: Wed, 11 May 2005 09:37:37 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0505110932530.29117-100000@studcom.urz.uni-halle.de>
References: <20050510214300.GA4292@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-hotplug-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050510214300.GA4292@kroah.com>
Sender: linux-hotplug-devel-admin@lists.sourceforge.net
Errors-To: linux-hotplug-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-hotplug-devel>,
	<mailto:linux-hotplug-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-hotplug-devel@lists.sourceforge.net>
List-Help: <mailto:linux-hotplug-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-hotplug-devel>,
	<mailto:linux-hotplug-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-hotplug-devel>
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Greg KH wrote:
> On Mon, May 09, 2005 at 09:41:19AM +0200, Clemens Ladisch wrote:
> > I'll make a temporary fix to bind to the first interface that is
> > probed.
>
> That will not work a usb speaker device that has the first interface as
> the usb keyboard :)
>
> Why not just point the struct device for ALSA at the struct
> usb_interface that is passed to you?

This is exactly what I actually meant when I said "probed".

Fixed now.


Regards,
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
