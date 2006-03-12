From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Dreamcast AICA driver
Date: Sun, 12 Mar 2006 12:16:07 +0000
Message-ID: <1142165767.9555.9.camel__10221.1766098209$1142165835$gmane$org@localhost.localdomain>
References: <1142124747.9496.50.camel@localhost.localdomain>
	 <1142125920.25358.22.camel@mindpipe>
	 <1142126427.9496.56.camel@localhost.localdomain>
	 <1142144081.25358.103.camel@mindpipe> <1142144901.25358.108.camel@mindpipe>
	 <1142161181.9555.3.camel@localhost.localdomain>
	 <44140DF0.1090908@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp1.homechoice.co.uk (sc-outsmtp1.homechoice.co.uk [81.1.65.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id B32FD1B7
	for <alsa-devel@alsa-project.org>; Sun, 12 Mar 2006 13:16:12 +0100 (MET)
In-Reply-To: <44140DF0.1090908@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-sh <linuxsh-dev@lists.sourceforge.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2006-03-12 at 12:02 +0000, James Courtier-Dutton wrote:

> Adrian,
> 
> It was good to talk to you on IRC. Now, as you have the source code for 
> the ARM7 firmware as well as the SH4 driver code, it might be sensible 
> to highlight the dependencies between them, by maybe using the same 
> human readable constant name in both bits of code. It also makes things 
> easier to understand if the hex addresses are given as offsets from some 
> sort of base.
> 
> if (request_mem_region(0xa0702c00, 4, "AICA ARM control")== NULL) return -ENOMEM;
> 
> then becomes in a .h file:
> #define ARM7_BASE_MEM  0xa0700000
> #define ARM7_AICA_CONTROL  0x2c00
> 
> During driver init:
> base_mem = ARM7_BASE_MEM
> 
> if (request_mem_region(base_mem + ARM7_AICA_CONTROL, 4, "AICA ARM control")== NULL) return -ENOMEM;
> 
> This would then allow movement of the base_mem without much modification to the driver code, if for example the ARM7 firmware required the change.
Sure. I understand the point of course



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
