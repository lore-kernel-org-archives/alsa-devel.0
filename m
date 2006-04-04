From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: patch bus_add_device-losing-an-error-return-from-the-probe-method.patch
 added to gregkh-2.6 tree
Date: Wed, 05 Apr 2006 00:12:40 +0200
Message-ID: <4432EF58.1060502__37294.4762850695$1144188798$gmane$org@keyaccess.nl>
References: <44238489.8090402@keyaccess.nl> <1FQquz-2CO-00@press.kroah.org> <d120d5000604041323h448c1ccfi7e9dcedd82c385ba@mail.gmail.com> <20060404210048.GA5694@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl [213.51.130.201])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BDB66178
	for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2006 00:11:50 +0200 (MEST)
In-Reply-To: <20060404210048.GA5694@suse.de>
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

Greg KH wrote:

>  - if that probe() function returns -ENODEV or -ENXIO[1] then the error
>    is ignored and 0 is returned, causing the loop to continue to try
>    more drivers

> [1] - stupid agp drivers (or some other video drivers) require this.  I
>     need to go fix them up so they don't do this, if they haven't been
>     fixed already...

Is the "this" in "require this" referring to (-ENODEV or -ENXIO) or to 
-ENXIO alone and do you consider the -ENODEV behaviour correct?

ALSA wants platform_device_register_simple() to return an IS_ERR() on 
driver probe error and the submitted patch makes it do so for all the 
other errors but ALSA likes to propagate errors up as far as possible, 
and currently its probe() methods can return either...

To Dmitry, I see you saying "probe() failing is driver's problem. The 
device is still there and should still be presented in sysfs.". No, at 
least in the case of these platform drivers (or at least these old ISA 
cards using the platform driver interface), a -ENODEV return from the 
probe() method would mean the device is _not_ present (or not found at 
least). NODEV.

As said before, if the behaviour makes sense for other busses, maybe 
propagating errors up should be dependent on a flags value somewhere 
that a platform-driver sets?

If platform_device_register_simple() never returns an IS_ERR() when the 
device is not found that means it's not a useful interface for hardware 
that needs to be probed for at the very least. ALSA would need to do 
something like, just before returning a succesfull return from the 
probe() method, set a global flag that the platform_device that is about 
to be registered is actually representing something, and freeing all 
platform_devices for which the flag is _not_ set again after this.

Which ofcourse means this is not at all useful. It's just working around 
the driver model then...

Rene.




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
