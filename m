From: Nicolas Boullis <nboullis@debian.org>
Subject: Re: Bug in the generation of IEC958 subframes
Date: Thu, 17 Nov 2005 20:47:37 +0100
Message-ID: <20051117194736.GB3948@home>
References: <20051116004500.GA5622@home> <s5hbr0jqxw6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hbr0jqxw6.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

Yesterday, I could manage to acces the bugtracking system, and file bugs 
0001570 and 0001571.

On Thu, Nov 17, 2005 at 01:09:13PM +0100, Takashi Iwai wrote:
> At Wed, 16 Nov 2005 01:45:01 +0100,
> Nicolas Boullis wrote:
> > 
> > Hi,
> > 
> > While working on an ALSA driver for the audio part of em8300-based MPEG 
> > decoder boards (Sigma Designs' Hollywood+ boards and Creative Labs' DXR3 
> > boards), I think I discovered a bug in the code that generates IEC958 
> > subframes from linear samples (iec958 plugin): M and W preambles are 
> > swapped, and B preambles should only be used on even subframes. The 
> > attached patch fixes this issue.
> 
> Thanks, applied to CVS now.

Thanks. I think you can close bug #0001570 then.


> > Moreover, (using debian's 1.0.9-3 package, I haven't checked with 
> > 1.0.10rc3), I get segfaults whenever I try to specify the preambles in 
> > my ~/.asoundrc file.
> 
> Hmm, the segfault is more serious.  Could you get a backtrace via gdb?

I submitted some test .asoundrc file + a backtrace I got with valgring 
in bug #0001571. Is it sufficient or should I also get a gdb backtrace?


Thanks,

Nicolas


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
