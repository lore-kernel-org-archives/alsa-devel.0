From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: 2.6.15-rt20, "bad page state", jackd
	(alsa	1.0.10 vs. recent kernels)
Date: Sun, 12 Mar 2006 22:53:41 -0500
Message-ID: <1142222022.25358.277.camel@mindpipe>
References: <1141846564.5262.20.camel@cmn3.stanford.edu>
	 <20060309084746.GB9408@osiris.boeblingen.de.ibm.com>
	 <1141938488.22708.28.camel@cmn3.stanford.edu>
	 <4410B2D7.4090806@yahoo.com.au>
	 <1141958866.22708.69.camel@cmn3.stanford.edu>
	 <441109BC.9070705@yahoo.com.au>
	 <1142016627.6124.33.camel@cmn3.stanford.edu>
	 <44121351.2050703@yahoo.com.au>
	 <1142210977.7471.27.camel@cmn3.stanford.edu>
	 <4414DBFE.1050400@yahoo.com.au>
	 <1142220385.7471.46.camel@cmn3.stanford.edu>
	 <1142220716.25358.273.camel@mindpipe>
	 <1142221144.7471.51.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1142221144.7471.51.camel@cmn3.stanford.edu>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, cc@ccrma.Stanford.EDU, Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net, Ingo Molnar <mingo@elte.hu>, Heiko Carstens <heiko.carstens@de.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 2006-03-12 at 19:39 -0800, Fernando Lopez-Lezcano wrote:
> On Sun, 2006-03-12 at 22:31 -0500, Lee Revell wrote:
>  
> > Older ALSA with a newer kernel has never been supported.  Why would you
> > want to replace the ALSA in the kernel with an old version?
> 
> Because it is not an older version?
> "cat /proc/asound/version" for the 2.6.15 in kernel tree prints this:
>   Advanced Linux Sound Architecture Driver Version 1.0.10rc3
> That should be older than 1.0.10 final.

Ah, sorry.  Then you're right, this patch must have slipped through the
cracks.

> (plus 1.0.10 has drivers that are not yet in the kernel tree AFAIK)

Yeah I never liked this practice, I think all ALSA drivers should be in
the kernel.  IMHO an immature driver is better than no driver.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
