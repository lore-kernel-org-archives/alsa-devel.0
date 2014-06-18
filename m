From: Greg KH <greg@kroah.com>
Subject: Re: [v3.13.y][SRU][PATCH 0/1] ALSA: usb-audio: Prevent printk
 ratelimiting from spamming kernel log while DEBUG not defined
Date: Wed, 18 Jun 2014 10:43:28 -0700
Message-ID: <20140618174328.GB11977@kroah.com>
References: <cover.1400085278.git.joseph.salisbury@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1400085278.git.joseph.salisbury@canonical.com>
Sender: stable-owner@vger.kernel.org
To: Joseph Salisbury <joseph.salisbury@canonical.com>
Cc: kamal.mostafa@canonical.com, perex@perex.cz, tiwai@suse.de, eldad@fogrefinery.com, clemens@ladisch.de, tim.gardner@canonical.com, stern@rowland.harvard.edu, linux@eikelenboom.it, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 18, 2014 at 01:14:05PM -0400, Joseph Salisbury wrote:
> BugLink: http://bugs.launchpad.net/bugs/1319457
> 
> Hello,
> 
> Please consider including upstream commit b7a77235 in the next v3.13.y release.  It was included upstream as of v3.15-rc5.  It has been tested and confirmed to resolve http://bugs.launchpad.net/bugs/1319457 .

Please get a good email client and wrap your lines :(

> commit b7a7723513dc89f83d6df13206df55d4dc26e825
> Author: Sander Eikelenboom <linux@eikelenboom.it>
> Date:   Fri May 2 15:09:27 2014 +0200
> 
>     ALSA: usb-audio: Prevent printk ratelimiting from spamming kernel log while DEBUG not defined
> 
> 
> This commit does not apply cleanly to v3.13, so I performed a backport, which is in email 1/1. 

Any reason this shouldn't also be in 3.14-stable?

thanks,

greg k-h
