From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: patch bus_add_device-losing-an-error-return-from-the-probe-method.patch
 added to gregkh-2.6 tree
Date: Wed, 05 Apr 2006 02:23:22 +0200
Message-ID: <44330DFA.4080106__21461.5914891057$1144196994$gmane$org@keyaccess.nl>
References: <44238489.8090402@keyaccess.nl> <1FQquz-2CO-00@press.kroah.org> <d120d5000604041323h448c1ccfi7e9dcedd82c385ba@mail.gmail.com> <20060404210048.GA5694@suse.de> <4432EF58.1060502@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040709020607090400030303"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl [213.51.130.201])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C470313C
	for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2006 02:22:36 +0200 (MEST)
In-Reply-To: <4432EF58.1060502@keyaccess.nl>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Greg KH <gregkh@suse.de>
Cc: dtor_core@ameritech.net, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, Andrew Morton <akpm@osdl.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040709020607090400030303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Rene Herman wrote:

> As said before, if the behaviour makes sense for other busses, maybe 
> propagating errors up should be dependent on a flags value somewhere 
> that a platform-driver sets?
> 
> If platform_device_register_simple() never returns an IS_ERR() when the 
> device is not found that means it's not a useful interface for hardware 
> that needs to be probed for at the very least. ALSA would need to do 
> something like, just before returning a succesfull return from the 
> probe() method, set a global flag that the platform_device that is about 
> to be registered is actually representing something, and freeing all 
> platform_devices for which the flag is _not_ set again after this.
> 
> Which ofcourse means this is not at all useful. It's just working around 
> the driver model then...

Well, we could in fact hang an unregister off device->private_data as 
per attached example. Wouldn't be _excessively_ ugly. Still sucks 
though. Having a flag somewhere in struct device_driver that a 
platform_driver would set and which would tell the driver model to 
honour the driver probe() method return seems the cleanest approach for 
all hardware where only the driver can now if the device is really 
present or not.

Ofcourse, I'm also still fine with just propagating the error up always 
(and if can be doing something about the ignore of -ENODEV / -ENOXIO)...

Rene.

--------------040709020607090400030303
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

--------------040709020607090400030303--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
