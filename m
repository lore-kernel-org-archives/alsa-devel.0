From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v3 3/3] portman2x4 - use new parport device
	model
Date: Fri, 5 Feb 2016 11:47:06 +0530
Message-ID: <20160205061706.GA6374@sudip-pc>
References: <1454603903-15967-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1454603903-15967-3-git-send-email-sudipm.mukherjee@gmail.com>
 <s5hr3gse7wk.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C6BF2605C6
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2016 07:17:17 +0100 (CET)
Received: by mail-pa0-f46.google.com with SMTP id cy9so28915361pac.0
 for <alsa-devel@alsa-project.org>; Thu, 04 Feb 2016 22:17:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <s5hr3gse7wk.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 04, 2016 at 05:51:07PM +0100, Takashi Iwai wrote:
> On Thu, 04 Feb 2016 17:38:23 +0100,
> Sudip Mukherjee wrote:
> > 
> > Modify portman driver to use the new parallel port device model.
> > The advantage of using the device model is that the device gets binded
> > to the hardware, we get the feature of hotplug, we can bind/unbind
> > the driver at runtime.
> > The only change is in the way the driver gets registered with the
> > parallel port subsystem and so as a result there is no user visible
> > change or any chance of regression.
> > 
> > Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> > ---
> > 
> > v3: changed commit message
> > v2:
> >  1. pardev_cb is initialized while declaring, thus removing the use of
> > memset.
> >  2. used pdev->id.
> >  3. v1 did not have the parport probe callback, but
> > we will need the probe callback for binding as the name of the driver
> > and the name of the device is different.
> >  4. in v1 I missed modifying snd_portman_probe_port().
> > 
> >  sound/drivers/portman2x4.c | 53 ++++++++++++++++++++++++++++++++++------------
> >  1 file changed, 39 insertions(+), 14 deletions(-)
> > 
> > diff --git a/sound/drivers/portman2x4.c b/sound/drivers/portman2x4.c
> > index 172685d..a22f56c 100644
> > --- a/sound/drivers/portman2x4.c
> > +++ b/sound/drivers/portman2x4.c
> > @@ -650,10 +650,21 @@ static int snd_portman_probe_port(struct parport *p)
> >  {
> >  	struct pardevice *pardev;
> >  	int res;
> > -
> > -	pardev = parport_register_device(p, DRIVER_NAME,
> > -					 NULL, NULL, NULL,
> > -					 0, NULL);
> > +	struct pardev_cb pdev_cb = {
> > +		.preempt = NULL,
> > +		.wakeup = NULL,
> > +		.private = NULL,
> > +		.irq_func = NULL,
> > +		.flags = 0,
> > +	};
> > +
> > +	/*
> > +	 * Specify the device number as SNDRV_CARDS + 1 so that the
> > +	 * device id alloted to this temporary device will never clash
> > +	 * with an actual device already registered.
> > +	 */
> > +	pardev = parport_register_dev_model(p, DRIVER_NAME, &pdev_cb,
> > +					    SNDRV_CARDS + 1);
> 
> Hmm, doesn't this result in a device name like "xxx.33" ?

yes, it will. But this is a temoporary device just to check if the
sound card is connected to that particular parallel port or not. After
checking this device is immediately unregistered. My idea here was to
have a device number which will never clash with another device number.
And we can never have a device like "xxx.33", so no conflict. :)

> Also, what if multiple portman devices are registered?

Even if we have multiple device, this temporary device will be
unregistered immediately after checking for the soundcard. So we should
not have any problem.

> 
> I suppose rather it should be passing dev variable from
> snd_portman_probe()?

Yes, we can. Instead of dev we can just pass the pdev->id for the device
number. Then we can have the same device number for the temporary
device used for probing and also the same number will be used in the
actual device if probing succeeds. Whichever way you want. Shall I send
the patch to use the same device number or using 33 as the device number
will do?

regards
sudip
