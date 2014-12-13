From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch 1/2] ALSA: oxfw: some signedness bugs
Date: Sat, 13 Dec 2014 10:04:14 +0300
Message-ID: <20141213070414.GA4973@mwanda>
References: <20141212192703.GA22234@mwanda>
 <548BC973.3090004@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <548BC973.3090004@sakamocchi.jp>
Sender: kernel-janitors-owner@vger.kernel.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, Dec 13, 2014 at 02:06:59PM +0900, Takashi Sakamoto wrote:
> On Dec 13 2014 04:27, Dan Carpenter wrote:
> > This code tends to use unsigned variables by default and it causes
> > signedness bugs when we use negative variables for error handling.
> > The "i" and "j" variables are used to iterated over small positive
> > values and so they should be type "int".  The "len" variable doesn't
> > *need* to be signed but it should be signed to make the code easier to
> > read and audit.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Thanks, but I prefer to use 'unsigned int' for loop counter, like the
> other drivers.

Unthinking use of unsigned int every where is a kind of leprosy.  It
just makes the code hard to read and it causes bugs.

regards,
dan carpenter

