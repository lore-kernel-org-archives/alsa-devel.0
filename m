From: "Dan Nyborg" <nyborg@www.vertice.ca>
Subject: Re: hdsp + acpi/apm = bug/feature?
Date: Mon, 1 Dec 2003 14:58:53 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031201205800.M98871@vertice.ca>
References: <20031130122331.GB15972@sirius.home> <3FCA1B3E.7020102@vertice.ca> <3FCB2AFB.5070205@undata.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FCB2AFB.5070205@undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>, Dan Nyborg <nyborg@vertice.ca>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hello,

i don't have the up to date patch for acpi and had the same problem even
without the low latency patch. i'm going to hold out upgrading until 2.6...
right now, i'm having too much fun with the hdsp ;) - for two months it sat
idle... dust (yes dust!) collected on it!

big thanks for all your software,

dan.

On Mon, 01 Dec 2003 12:50:19 +0100, Thomas Charbonnel wrote
> Dan Nyborg wrote :
> 
> > hello,
> > 
> > some posts were made by myself a couple of months back regarding system 
> > lockups experienced with the hdsp driver - my system would lock during 
> > capture or playback.
> > 
> > this lock has been traced to kernel power management, either acpi or 
> > apm. when either of these are enabled, i experience locks. without them, 
> > no problems.
> > 
> > i use a 2.4.20 kernel with andrew morton's low latency patch. the cpu is 
> > an athlon.
> > 
> > thanks,
> > 
> > dan.
> > 
> 
> Hi Dan,
> 
> There is no power management support in the hdsp driver at the 
> moment, so the problem you have shouldn't come from this (and is 
> definitely not a 'feature' :) Did you use the kernel's built in ACPI 
> support or an up-to-date patch from the linux acpi project ? Did you 
> try without the the low latency patch ? What I would suggest is that 
> you try the new 2.4.23 kernel. The problem you're experiencing might 
> have been fixed.
> 
> Thomas



--
Open WebMail Project (http://openwebmail.org)



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
