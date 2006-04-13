From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [ALSA STABLE 3/3] a few more -- unregister platform device again if probe was unsuccessful
Date: Thu, 13 Apr 2006 15:57:57 +0100
Message-ID: <20060413145756.GA29959__4636.29614464498$1144940455$gmane$org@flint.arm.linux.org.uk>
References: <443DAD5C.8080007@keyaccess.nl> <200604131126.35841.ioe-lkml@rameria.de> <443E5AAD.5040800@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk [212.18.232.186])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C9915163
	for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2006 16:59:00 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <443E5AAD.5040800@keyaccess.nl>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, Greg KH <gregkh@suse.de>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 13, 2006 at 04:05:33PM +0200, Rene Herman wrote:
> Not honouring/passing up probe() method error returns, not even -ENODEV, 
> makes some sense for discoverable busses such as PCI where you at least 
> have a driver independent bus_id sitting in /sys/devices/pci* that you 
> can later echo into /sys/bus/pci/drivers/*/bind to make the driver bind 
> to a device, but not much sense for the platform bus. Platform devices 
> only "exist" (in /sys/devices/platform) due to the driver creating them 
> itself and keeping them after failing a probe means that directory 
> becomes an enumeration of the drivers we loaded, rather than a view of 
> what's present in the system.

Incorrect.  In some circumstances, they may be created by architecture
support code, and might be created and destroyed dynamically by
architecture support code.

> The driver model crowd did not seem exceedingly interested in the 
> problem though:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114417829014332&w=2

Incorrect summary.  The ALSA use model of the driver model doesn't fit
with the driver model use model.  It's not that we're not interested
in it - it's that it's perverted to the way driver model folk intend
the subsystem to work, and the way that platform devices are used on
some architectures.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
