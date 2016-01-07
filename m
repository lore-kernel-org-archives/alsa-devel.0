From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [alsa-devel] [PATCH 6/6] [ALSA] portman2x4 - use new parport
 device	model
Date: Thu, 7 Jan 2016 16:49:36 +0530
Message-ID: <20160107111936.GA13389@sudip-pc>
References: <1452150951-1571-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1452150951-1571-6-git-send-email-sudipm.mukherjee@gmail.com>
 <s5hwprlhehn.wl-tiwai@suse.de>
 <20160107104434.GA9809@sudip-pc>
 <s5hsi29hdeg.wl-tiwai@suse.de>
 <20160107110127.GA11477@sudip-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160107110127.GA11477@sudip-pc>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 07, 2016 at 04:31:27PM +0530, Sudip Mukherjee wrote:
> On Thu, Jan 07, 2016 at 11:50:15AM +0100, Takashi Iwai wrote:
> > On Thu, 07 Jan 2016 11:44:34 +0100,
> > Sudip Mukherjee wrote:
> > > 
> > > On Thu, Jan 07, 2016 at 11:26:44AM +0100, Takashi Iwai wrote:
> > > > On Thu, 07 Jan 2016 08:15:51 +0100,
> > > > Sudip Mukherjee wrote:
> > > > > 
<snip>
> > > > 
> > > > > +
> > > > > +	pardev = parport_register_dev_model(p,		   /* port */
> > > > > +					    DRIVER_NAME,   /* name */
> > > > > +					    &portman_cb,   /* callbacks */
> > > > > +					    device_count); /* device number */
> > > > 
> > > > Does device_count really work similarly for
> > > > parport_register_dev_model()?  I supposed the argument being the
> > > > device id number while you're passing the number of devices to
> > > > create.
> > > 
> > > This device_count is actually used for the device name in
> > > /sys/bus/parport/devices. Something like DRIVER_NAME.device_count.
> > 
> > Well, but device_count is incremented in snd_portman_attach().  The
> > management of device_count should be moved around the caller side, if
> > we use this as the id (and use the assigned id instead of device_count
> > in snd_portman_attach()).

did you mean something like this: (on top of my patch)

diff --git a/sound/drivers/portman2x4.c b/sound/drivers/portman2x4.c
index 88b25ca..d749786 100644
--- a/sound/drivers/portman2x4.c
+++ b/sound/drivers/portman2x4.c
@@ -688,14 +688,8 @@ static void snd_portman_attach(struct parport *p)
 
 	/* Since we dont get the return value of probe
 	 * We need to check if device probing succeeded or not */
-	if (!platform_get_drvdata(device)) {
+	if (!platform_get_drvdata(device))
 		platform_device_unregister(device);
-		return;
-	}
-
-	/* register device in global table */
-	platform_devices[device_count] = device;
-	device_count++;
 }
 
 static void snd_portman_detach(struct parport *p)
@@ -768,7 +762,7 @@ static int snd_portman_probe(struct platform_device *pdev)
 	pardev = parport_register_dev_model(p,		   /* port */
 					    DRIVER_NAME,   /* name */
 					    &portman_cb,   /* callbacks */
-					    device_count); /* device number */
+					    pdev->id);	   /* device number */
 	if (!pardev) {
 		snd_printd("Cannot register pardevice\n");
 		err = -EIO;
@@ -812,6 +806,10 @@ static int snd_portman_probe(struct platform_device *pdev)
 		goto __err;
 	}
 
+	/* register device in global table */
+	platform_devices[device_count] = device;
+	device_count++;
+
 	snd_printk(KERN_INFO "Portman 2x4 on 0x%lx\n", p->base);
 	return 0;
 

regards
sudip
