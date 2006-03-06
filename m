From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: kernel threads etc
Date: Mon, 06 Mar 2006 23:29:10 +0000
Message-ID: <1141687750.9230.24.camel__37852.0685284913$1141687826$gmane$org@localhost.localdomain>
References: <1141684061.9230.15.camel@localhost.localdomain>
	 <1141686718.25487.76.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp2.homechoice.co.uk (sc-outsmtp2.homechoice.co.uk [81.1.65.36])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id E9E0E195
	for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2006 00:29:17 +0100 (MET)
In-Reply-To: <1141686718.25487.76.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-sh <linuxsh-dev@lists.sourceforge.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-03-06 at 18:11 -0500, Lee Revell wrote:
> On Mon, 2006-03-06 at 22:27 +0000, Adrian McMenamin wrote:
> > I have an interrupt handler in my sound driver that calls this:
> 
> You never explained why you want to create a kernel thread rather than
> implementing copy/silence callbacks like the docs say.
> 
> Lee

Because what the documents actually say is: "Some chips have their own
hardware buffers and the DMA transfer from the host memory is not
available."

Well, DMA is very much available. Though I can see that: "Another case
is that the chip uses a PCI memory-map region for the buffer" could be
similar.



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
