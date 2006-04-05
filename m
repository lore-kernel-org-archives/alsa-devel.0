From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: patch bus_add_device-losing-an-error-return-from-the-probe-method.patch
 added to gregkh-2.6 tree
Date: Wed, 05 Apr 2006 15:50:44 +0200
Message-ID: <4433CB34.6010707__3020.00911110571$1144245104$gmane$org@keyaccess.nl>
References: <44238489.8090402@keyaccess.nl> <20060404210048.GA5694@suse.de> <4432EF58.1060502@keyaccess.nl> <200604042148.57286.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030406090500020006070500"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl [213.51.130.201])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E77D01A0
	for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2006 15:49:52 +0200 (MEST)
In-Reply-To: <200604042148.57286.dtor_core@ameritech.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Greg KH <gregkh@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030406090500020006070500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Dmitry Torokhov wrote:

> On Tuesday 04 April 2006 18:12, Rene Herman wrote:

>> To Dmitry, I see you saying "probe() failing is driver's problem.
>> The device is still there and should still be presented in sysfs.".
>> No, at least in the case of these platform drivers (or at least
>> these old ISA cards using the platform driver interface), a -ENODEV
>> return from the probe() method would mean the device is _not_
>> present (or not found at least). NODEV.
> 
> Or you could separate device probing code from driver->probe(). BTW I
> think that ->probe() is not the best name for that method.

Right...

> It really is supposed to allocate resources and initialize the device
> so that it is ready to be used, not to verify that device is present.
> The code that created device shoudl've done that.

How do you feel about the flag that I've been proposing that a driver 
that needs to probe for its hardware could set and that says "if we 
return an error (or specifically -ENODEV I guess) the hardware's 
reallyreally not present and the device should not register"?

Greg, and how do you feel about such a flag?

As an alternative to the flag, how would either of you feel about either

1) adding a .discover method to struct device_driver that noone other 
than drivers for this old non generically discoverable hardware would 
set but which would make a registration fail if set and returning < 0?

2) adding that method only to platform_driver?

3) ... and after a few months when people aren't paying attention 
anymore rename .probe to .init and .discover back to .probe? ;-)

Russel, you wrote:

> Note also that this patch will not do what the ALSA folk want - they
> want to know if the device was found or whether the probe returned
> -ENODEV. We knock -ENODEV and -ENXIO to zero in
> driver_probe_device(), so they won't even see that.

Yes, I know about the -ENODEV / -ENXIO thing. I asked for comment on 
that as well, but haven't gotten any.

Anyways, the additional method would, I feel, be the conceptually 
cleanest approach. Practically speaking though, simply doing a manual 
probe and only calling platform_register() after everything is found to 
be present and accounted for is not much of a problem either.

Takashi, how would you feel about a setup for ALSA going like:

static struct platform_device *devices[SNDRV_CARDS];

static int __devinit snd_foo_probe(int i)
{
	struct snd_card *card;

         if (port[i] == SNDRV_AUTO_PORT) {
                 snd_printk(KERN_ERR "specify port\n");
		return -EINVAL;
         }

	card = snd_card_new(index[i], id[i], THIS_MODULE, 0);
         if (!card) {
                 snd_printk(KERN_ERR "could not create card\n");
                 return -EWHATEVER;
         }

	/* all the other things the probe method does */

         if (snd_card_register(card) < 0) {
                 snd_printk(KERN_ERR "could not register card\n");
                 return -EWHATEVERSNDCARDREGISTERRETURNED;
         }

         devices[i] = platform_device_register_simple(NAME, i, NULL, 0);
         if (IS_ERR(devices[i])) {
                 snd_printk(KERN_ERR "could not register device\n");
		snd_card_free(card);
                 return PTR_ERR(devices[i]);
         }

         platform_set_drvdata(devices[i], card);
         return 0;
}

Then deleting the .probe method from the foo_platform_driver struct and 
in the module init simply do a manual probe, using:

         if (platform_driver_register(&snd_foo_driver) < 0) {
                 snd_printk(KERN_ERR "could not register driver\n");
                 return -EARGHH;
         }

         for (cards = 0, i = 0; i < SNDRV_CARDS; i++)
                 if (enable[i] && snd_foo_probe(i) >= 0)
                         cards++

         if (!cards) {
                 printk(KERN_ER "foo not found or device busy\n");
                 platform_driver_unregister(&snd_foo_driver);
                 return -ENODEV;
         }

Also attached as a patch against adlib.c (it's the simplest driver by 
far, so using that one as an example. it's present in 2.6.17-rc1).

The platform_device registration could also stay in the init loop, but 
since we want the free the card again if it fails same as with all the 
other failures it's best off at the end of probe() I feel. You 
introduced all these nonpnp_probe() methods for platform devices so we 
do have a nice place to put this...

Would you feel this would be an okay setup, assuming we're not getting 
that .discover method?

Rene.

--------------030406090500020006070500
Content-Type: text/plain;
 name="adlib-unregister.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="adlib-unregister.diff"

Index: local/sound/isa/adlib.c
===================================================================
--- local.orig/sound/isa/adlib.c	2006-04-05 02:00:55.000000000 +0200
+++ local/sound/isa/adlib.c	2006-04-05 02:05:45.000000000 +0200
@@ -43,8 +43,7 @@ static int __devinit snd_adlib_probe(str
 	struct snd_card *card;
 	struct snd_opl3 *opl3;
 
-	int error;
-	int i = device->id;
+	int error, i = device->id;
 
 	if (port[i] == SNDRV_AUTO_PORT) {
 		snd_printk(KERN_ERR DRV_NAME ": please specify port\n");
@@ -95,8 +94,7 @@ static int __devinit snd_adlib_probe(str
 	return 0;
 
 out1:	snd_card_free(card);
- out0:	error = -EINVAL; /* FIXME: should be the original error code */
-	return error;
+out0:	return error;
 }
 
 static int __devexit snd_adlib_remove(struct platform_device *device)
@@ -134,6 +132,11 @@ static int __init alsa_card_adlib_init(v
 		if (IS_ERR(device))
 			continue;
 
+		if (!platform_get_drvdata(device)) {
+			platform_device_unregister(device);
+			continue;
+		}
+
 		devices[i] = device;
 		cards++;
 	}

--------------030406090500020006070500--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
