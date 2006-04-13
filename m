From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [ALSA STABLE 3/3] a few more -- unregister platform device again
 if probe was unsuccessful
Date: Thu, 13 Apr 2006 16:05:33 +0200
Message-ID: <443E5AAD.5040800__28854.6317410239$1144937108$gmane$org@keyaccess.nl>
References: <443DAD5C.8080007@keyaccess.nl> <200604131126.35841.ioe-lkml@rameria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl [213.51.146.200])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 28122154
	for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2006 16:03:56 +0200 (MEST)
In-Reply-To: <200604131126.35841.ioe-lkml@rameria.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, Greg KH <gregkh@suse.de>, Russell King <rmk+lkml@arm.linux.org.uk>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Ingo Oeser wrote:

Why did you remove alsa-devel from the CC?

> This is inserting lots of duplicate and control heavy code. It looks 
> like the same pattern and is using just platform_xxx funxtions.
> 
> Any counter-examples with a different pattern, which you converted in
> a different manner?

Not lots really... for all of them it's basically:

if (!platform_get_drvdata(device)) {
	platform_device_unregister(device);
	continue;
}

in the driver's main init loop. In this batch there were three drivers 
that both did not support more than one device and passed the error on 
up meaning it looks a bit a bit more clumsy than that but when moving 
these drivers from the platform_device_register_simple() interface this 
code will be revisited again; making them support more devices can also 
happen longer term.

> Wouldn't it be more useful to do these checks in 
> platform_register_simple() and return the proper error value there?

That interface is going away. I checked where ALSA used them due to that 
in fact (the same patches for sound/isa are already in ALSA and have 
been submitted for -stable as well).

Yes, it would be better if the driver model supplied this functionality 
itself. The problem is that an error return from the platform probe() 
method is not being honoured/passed up by the driver model so that we 
don't get a chance to say "no, the hardware's not here, go away!".

Not honouring/passing up probe() method error returns, not even -ENODEV, 
makes some sense for discoverable busses such as PCI where you at least 
have a driver independent bus_id sitting in /sys/devices/pci* that you 
can later echo into /sys/bus/pci/drivers/*/bind to make the driver bind 
to a device, but not much sense for the platform bus. Platform devices 
only "exist" (in /sys/devices/platform) due to the driver creating them 
itself and keeping them after failing a probe means that directory 
becomes an enumeration of the drivers we loaded, rather than a view of 
what's present in the system.

The driver model crowd did not seem exceedingly interested in the 
problem though:

http://marc.theaimsgroup.com/?l=linux-kernel&m=114417829014332&w=2

It _is_ ofcourse an option to not care about /sys/devices/platform, and 
ALSA could do that as well longer term. This was discussed:

http://marc.theaimsgroup.com/?l=linux-kernel&m=114442720631596&w=2

(marc seems to be not so good at keeping threads intact. reply at: 
http://marc.theaimsgroup.com/?l=linux-kernel&m=114469016131522&w=2)

and for now, we'll keep the old behaviour of not loading on probe 
failure, using drvdata() as a private success flag set from probe(). 
Longer term, we can revisit this.

Most importantly though, you replied to the one submitted for -stable. 
For -stable, this is certainly the way to go. ALSA drivers always failed 
to load on probe() failure before they were even using the platform 
driver interface (which was new to 2.6.16) and things like the alsaconf 
script rely on this. For -stable, it's a simple bugfix therefore.

> Or just create a small helper, if this have to be done seperate.

That would be going way overboard for the three lines as stated in the 
beginning. Certainly when they might/will go again in the future...

Rene.



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
