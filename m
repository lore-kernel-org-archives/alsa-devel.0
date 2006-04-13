From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [ALSA STABLE 3/3] a few more -- unregister platform device again
 if probe was unsuccessful
Date: Fri, 14 Apr 2006 01:12:17 +0200
Message-ID: <443EDAD1.8090406@keyaccess.nl>
References: <443DAD5C.8080007@keyaccess.nl> <200604131126.35841.ioe-lkml@rameria.de> <443E5AAD.5040800@keyaccess.nl> <20060413145756.GA29959@flint.arm.linux.org.uk> <443E79AD.50505@keyaccess.nl> <20060413170549.GB7805@flint.arm.linux.org.uk> <20060413220205.GA1770@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtpq3.groni1.gr.home.nl (smtpq3.groni1.gr.home.nl [213.51.130.202])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D7EAB175
	for <alsa-devel@alsa-project.org>; Fri, 14 Apr 2006 01:10:42 +0200 (MEST)
In-Reply-To: <20060413220205.GA1770@suse.de>
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
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Greg KH wrote:

> I still really don't understand why these ALSA drivers are so unlike
> any of the zillion other drivers we have in the kernel that work just
> fine today.

It's nothing to do with ALSA, only with ISA -- ALSA is just one of the 
few remaining serious ISA users. Have said this a number of times now, 
so apologies to anyone who _is_ following this. I promise it's going to 
be the last time. The issue:

Historically, ALSA ISA drivers failed to load upon not finding their 
hardware at load time, same as most ISA drivers. When 2.6.16 switched 
them to use of the platform driver interface this behaviour was 
inadvertently changed due to the platform driver interface not passing 
up the probe() return. Things such as the "alsaconf" configuration 
script actualy rely on the non-load behaviour and current submissions to 
-stable simply use drvdata() being !NULL as a private success flag to 
restore that behaviour. This is okay.

Longer term (than -stable) it could ofcourse be better to follow the 
model from saner busses such as PCI more closely -- we could just load 
whether or not a device was bound to. The difference though is that a 
PCI device has a life all by itself by virtue of its _bus_ knowing that 
it's present (it has an entry in /sys/devices/pci*, without any device 
specific driver loaded) while these old ISA devices only exist in the 
driver model by virtue of a driver creating them as a platform device 
because it might want to drive them. If we keep them registered even 
after failing a probe, then /sys/devices/platform turns into an 
enumeration of the drivers we loaded, not a view of what's present in 
the system.

(and there is no point in keeping the driver loaded when we don't keep 
the devices registered as well -- you couldn't do anything with that 
driver, it would just be sitting there taking up memory)

Problem therefore: /sys/devices pollution. Note that ALSA supports some 
20 (non-pnp-only) ISA drivers and imagine loading them all, with all of 
them creating one or more devices in /sys/devices/platform, with none of 
the actual hardware present. I consider this not nice, not from the view 
of ALSA, but because I've been told that one of the reasons for /sys was 
this nice view of "what's in this system" that /sys/devices would provide.

The answer needed -- if you _do_ think it's okay to just have those 
devices present in /sys/devices/platform without the hardware existing, 
then I do not have a problem. I'll just suggest to keep them registered 
and be done with it (*).

If on the other hand you agree it's not nice, I'll try and look into 
what a seperate isa_bus could provide.

Rene.

(*) Note by the way I do not necesarily qualify as an ALSA person. I 
only ran into this when I submitted a new ALSA ISA driver for 2.6.16+. 
Takashi Iwai is being CCed on all these messages though, and he hasn't 
yet protested anything I've been saying, so I assume he's okay with my 
worries at least...



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
