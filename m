From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Adding a new architecture to alsa-driver
Date: Tue, 11 Apr 2006 22:37:00 +0100
Message-ID: <1144791420.9248.2.camel@localhost.localdomain>
References: <1144510532.10642.1.camel@localhost.localdomain>
	 <1144512218.22490.146.camel@mindpipe>
	 <1144542208.10642.9.camel@localhost.localdomain>
	 <1144545416.22490.184.camel@mindpipe>
	 <1144706767.9278.11.camel@localhost.localdomain>
	 <1144718017.18918.6.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1144718017.18918.6.camel@mindpipe>
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
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-04-10 at 21:13 -0400, Lee Revell wrote:
> On Mon, 2006-04-10 at 23:06 +0100, Adrian McMenamin wrote:
> > On Sat, 2006-04-08 at 21:16 -0400, Lee Revell wrote:
> > > c_opts="-mno-space-regs -mfast-indirect-calls -mschedule=7200
> > > -mdisable-fpregs"
> > 
> > 
> > I have tried this patch and it doesn't work. Essentially the aica card
> > isn't picked up. I think this has something to do with aclocal.m4 or
> > something similar.
> > 
> > To be honest I've hit a brick wall and any help at all would be welcome.
> > 
> > 
> 
> Adrian,
> 
> OK, here's the working (I think) patch against ALSA CVS.
> 
> I could not figure out how to add a new arch while leaving the driver in
> alsa-driver, so this adds it to alsa-kernel.


I just cannot get this patch to apply. It seems to be made at two
different patch levels




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
