From: Adrian Bunk <bunk@stusta.de>
Subject: Re: Re: RFC: OSS driver removal, a slightly different approach
Date: Thu, 19 Jan 2006 23:18:13 +0100
Message-ID: <20060119221813.GB19398__23326.3388312936$1137709169$gmane$org@stusta.de>
References: <20060119174600.GT19398@stusta.de> <m3ek34vucz.fsf@defiant.localdomain> <1137703413.32195.23.camel@mindpipe> <20060119215008.GB6595@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 39F82141
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2006 23:18:13 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <20060119215008.GB6595@devserv.devel.redhat.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>, Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 19, 2006 at 04:50:08PM -0500, Bill Nottingham wrote:
> Lee Revell (rlrevell@joe-job.com) said: 
> > Yes, it would require a collector of ancient sound hardware... do you
> > know anyone like that?
> 
> If someone desparately wants a AdLib or PAS16 I might be able to
> scrounge one up. However, are there really users out there
> insisting that their Linux experience is suffering because they
> don't have support for their 8-bit ISA FM synth card?

Half of the cards without ALSA drivers are ancient PC hardware and the 
other half are drivers for !i386 platforms.

Me scheduling other OSS drivers for removal brought me indirectly in
contact with two users of SOUND_TRIX and one user of SOUND_VIDC - and 
I'd assume that most of such hardware has some users somewhere.

I don't consider it a big problem if a handful OSS drivers for obscure 
hardware will stay forever (although getting ALSA drivers for all 
hardware would be the superior solution).

We are already able to both remove a serious amount of code and getting 
many bug reports against the ALSA drivers without removing support for a 
single piece of hardware.

> Bill

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
