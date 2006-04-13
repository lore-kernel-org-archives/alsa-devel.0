From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [ALSA STABLE 3/3] a few more -- unregister platform device again
 if probe was unsuccessful
Date: Thu, 13 Apr 2006 18:17:49 +0200
Message-ID: <443E79AD.50505__42542.5286441625$1144945051$gmane$org@keyaccess.nl>
References: <443DAD5C.8080007@keyaccess.nl> <200604131126.35841.ioe-lkml@rameria.de> <443E5AAD.5040800@keyaccess.nl> <20060413145756.GA29959@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtpq3.tilbu1.nb.home.nl (smtpq3.tilbu1.nb.home.nl [213.51.146.202])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AFF8516D
	for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2006 18:16:09 +0200 (MEST)
In-Reply-To: <20060413145756.GA29959@flint.arm.linux.org.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, Greg KH <gregkh@suse.de>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Russell King wrote:

> On Thu, Apr 13, 2006 at 04:05:33PM +0200, Rene Herman wrote:

>> Not honouring/passing up probe() method error returns, not even -ENODEV, 
>> makes some sense for discoverable busses such as PCI where you at least 
>> have a driver independent bus_id sitting in /sys/devices/pci* that you 
>> can later echo into /sys/bus/pci/drivers/*/bind to make the driver bind 
>> to a device, but not much sense for the platform bus. Platform devices 
>> only "exist" (in /sys/devices/platform) due to the driver creating them 
>> itself and keeping them after failing a probe means that directory 
>> becomes an enumeration of the drivers we loaded, rather than a view of 
>> what's present in the system.
> 
> Incorrect.  In some circumstances, they may be created by architecture
> support code, and might be created and destroyed dynamically by
> architecture support code.

Okay, thanks, that's relevant information. Please explain though what's 
incorrect about the fact that for these ISA devices on the plain old PC, 
with nothing other than the driver available to probe for them, just 
keeping them registered after failing a probe turns 
/sys/devices/platform into a view of "what drivers did we load".

>> The driver model crowd did not seem exceedingly interested in the 
>> problem though:
>>
>> http://marc.theaimsgroup.com/?l=linux-kernel&m=114417829014332&w=2
> 
> Incorrect summary.  The ALSA use model of the driver model doesn't fit
> with the driver model use model.  It's not that we're not interested
> in it - it's that it's perverted to the way driver model folk intend
> the subsystem to work, and the way that platform devices are used on
> some architectures.

And I take it that interest is reflected in getting a grand total of 0 
comments from anyone on my own feeble attempts to suggest things in that 
thread such as the settable flag that would make the driver model pass 
up the error return from probe when set, or having an additional 
.discover method, or ..

M'kay. I believe there's one clean way out of this. We could add an "isa 
bus", where the _user_ would first need to setup the hardware from 
userspace by echoing values into sysfs. Say, something like:

echo -n foo		>/sys/devices/isa0/new
echo -n "io 0x220"	>/sys/devices/isa0/foo/resources
echo -n "irq 5"		>/sys/devices/isa0/foo/resources
echo -n "dma 1"		>/sys/devices/isa0/foo/resources

and so on. The type of resources would be modelled after ISA-PnP (and to 
make them more equal, you could do multiple device id's per bus id, card 
id's, in PNP lingo, but this principle at least)

The driver would them request id "foo" as an agreed upon ID (snd-sb8 
would request "sb8", say) or we could pass in the id as a module parameter.

I actually think this would be Great. Comments? Pitchforks?

 From the driver's standpoint, there would not be a difference with 
ISA-PnP anymore other than ISA-PnP also providing for the possibilty to 
change them -- something which ALSA also uses, but which it should 
probably not; has annoyed me for some time. We could then in fact also 
integrate this into ISA-PnP itself, using PnP-like device IDs and all, 
so that from the driver's standpoint, it _is_ always speaking to an 
ISA-PnP device.

Rene.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
