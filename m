From: John Rigg <ad@carbon-black.co.uk>
Subject: Re: jerks
Date: Thu, 8 Dec 2005 19:31:38 +0000
Message-ID: <20051208193138.GA4312@localhost.localdomain>
References: <1134063707.13439.37.camel@snuk.slsware.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail3.uklinux.net (mail3.uklinux.net [80.84.72.33])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BD7C4170
	for <alsa-devel@alsa-project.org>; Thu,  8 Dec 2005 20:22:53 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <1134063707.13439.37.camel@snuk.slsware.lan>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Glenn English <ghe@slsware.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 08, 2005 at 10:41:47AM -0700, Glenn English wrote:
> I'm trying to make a Digital Audio Workstation (DAW) out of a SUN W2100z
> (dual AMD64).
> 
> Every few seconds, at seemingly random times, everything freezes for
> ~50ms. Even the mouse. Sometimes. Reliable at the first card moved in
> Aisle Riot Solitaire and when Jack is running. Often when I'm typing
> email (chars don't get from the keyboard to the screen).
> 
> I know that's not much of a description, but I don't know where to start
> looking for this. I'm assuming interrupts are being disabled entirely
> momentarily. My background says it's time for a bus monitor, but I don't
> have one handy.
> 
> This happens with a 2.6 kernel from the current updated Sarge or a 2.4
> from DeMuDi 1.2.1 distro.

Could this be the libc NPTL bug? Sarge has a buggy version of glibc with
a broken NPTL implementation (don't know about DeMuDi 1.2.1).
If so, threaded apps won't perform properly - I switched to sid for this
reason.
Workaround is to set LD_ASSUME_KERNEL=2.4.22 for jackd and other audio
apps. In sid it's fixed, and you'll also get the extra benefits of
gcc-4.0's better AMD64 optimisation.

John


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
