From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Dreamcast AICA driver
Date: Sun, 12 Mar 2006 01:20:27 +0000
Message-ID: <1142126427.9496.56.camel@localhost.localdomain>
References: <1142124747.9496.50.camel@localhost.localdomain>
	 <1142125920.25358.22.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp2.homechoice.co.uk (sc-outsmtp2.homechoice.co.uk [81.1.65.36])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 598C01E2
	for <alsa-devel@alsa-project.org>; Sun, 12 Mar 2006 02:20:31 +0100 (MET)
In-Reply-To: <1142125920.25358.22.camel@mindpipe>
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

On Sat, 2006-03-11 at 20:11 -0500, Lee Revell wrote:
> On Sun, 2006-03-12 at 00:52 +0000, Adrian McMenamin wrote:
> > After a mere three years in development I now have a working (mono only
> > for now) ALSA driver for the Dreamcast driver to test.
> > 
> > Sources are available for browsing at:
> > 
> > http://newgolddream.dyndns.info/cgi-bin/cvsweb
> > 
> > 
> > If there are any testers out there please let me know!
> 
> Cool, what did you have to do to get it working?


Key point was to switch to timer polling. It turned out there were
issues with the ARM7 firmware and interrupts that meant it behaved in
odd ways and essentially didn't work :)

So I still use DMA to transfer the samples, but I use timer polling to
test how much has been played



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
