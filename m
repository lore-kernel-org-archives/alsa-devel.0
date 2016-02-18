From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v5] portman2x4 - use new parport device model
Date: Thu, 18 Feb 2016 16:07:59 +0530
Message-ID: <20160218103747.GA12223@sudip-pc>
References: <1455713787-13382-1-git-send-email-sudipm.mukherjee@gmail.com>
 <s5hvb5muxoz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hvb5muxoz.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 18, 2016 at 11:20:28AM +0100, Takashi Iwai wrote:
> On Wed, 17 Feb 2016 13:56:27 +0100,
> Sudip Mukherjee wrote:
> > 
> > Modify portman driver to use the new parallel port device model.
> > The advantage of using the device model is that the device gets binded
> > to the hardware, we get the feature of hotplug, we can bind/unbind
> > the driver at runtime.
> > The changes are in the way the driver gets registered with the
> > parallel port subsystem and the temporary device to probe portman card
> > is removed and portman_probe() is used in the probe callback.
> > 
> > Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> > ---
> > 
> > v5: claimed flag and one call to parport_claim() removed.
> > v4: temporary device to probe is removed.
> > v3: changed commit message
> > v2:
> >  1. pardev_cb is initialized while declaring, thus removing the use of
> >  memset.
> >  2. used pdev->id.
> >  3. v1 did not have the parport probe callback, but we will need the
> >  probe callback for binding as the name of the driver and the name of
> >  the device is different.
> >  4. in v1 I missed modifying snd_portman_probe_port().
> 
> OK, I merged this one to for-next branch now.  Let's cross fingers :)

Thanks.
Its simple change, nothing should happen.
I will send you the other one in few days time if 0day does not report
anything on this patch.

regards
sudip
