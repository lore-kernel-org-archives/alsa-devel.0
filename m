From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [alsa-devel] [PATCH] ALSA: hda - initialize audio InfoFrame to
 be all zero
Date: Tue, 22 Jul 2014 17:08:52 -0700
Message-ID: <20140723000852.GA12621@kroah.com>
References: <f37b3349bd0a4f5989cf503f578e25ad0f7d160e.1394572173.git.mengdong.lin@intel.com>
 <53CE0A2F.3070204@canonical.com>
 <s5hsiltho68.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hsiltho68.wl%tiwai@suse.de>
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: David Henningsson <david.henningsson@canonical.com>, mengdong.lin@intel.com, alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 22, 2014 at 09:01:51AM +0200, Takashi Iwai wrote:
> At Tue, 22 Jul 2014 08:52:31 +0200,
> David Henningsson wrote:
> > 
> > Hi,
> > 
> > It looks like this patch should have been sent to stable, is there any 
> > reason why it wasn't?
> 
> Just forgotten, I suppose.  This should be included in stable, indeed.
> 
> Greg, could you cherry-pick this upstream commit
> caaf5ef9493f72390905f1e97b310b8906d32dac
>    ALSA: hda - initialize audio InfoFrame to be all zero
> 
> to stable kernels?

Only seemd to apply to 3.14-stable, so I put it there.

thanks,

greg k-h
