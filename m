From: Raymond <rayau@netvigator.com>
Subject: Re: [ALSA - driver 0000059]: On au8820 left and right channels are
 swapped
Date: Thu, 24 Mar 2005 12:03:10 +0800
Message-ID: <42423BFE.6000007@netvigator.com>
References: <b4fad97e0da3fd434019184fdfe66575@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <b4fad97e0da3fd434019184fdfe66575@bugtrack.alsa-project.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


bugtrack@alsa-project.org wrote:
> The following issue has been set as RELATED TO issue 0000949.
> ======================================================================
> <https://bugtrack.alsa-project.org/alsa-bug/view.php?id=59> 
> ======================================================================
> Reported By:                kernel_bug
> Assigned To:                mjander
> ======================================================================
> Project:                    ALSA - driver
> Issue ID:                   59
> Category:                   PCI - au88x0
> Reproducibility:            random
> Severity:                   major
> Priority:                   normal
> Status:                     feedback
> Distribution:               
> Kernel Version:             2.6.2
> ======================================================================
> Date Submitted:             02-13-2004 11:40 CET
> Last Modified:              03-10-2005 21:25 CET
> ======================================================================
> Summary:                    On au8820 left and right channels are swapped
> Description: 
> In most cases, left and right channels are swapped. But in approx. 5% cases
> all OK. Looks like the matter is somewhere in byte alignment...
> ======================================================================

> 
> ----------------------------------------------------------------------
>  kernel_bug - 03-10-05 21:25 
> ----------------------------------------------------------------------
> 
>>Did anyone still get this bug or may we close it ?
> 
> 
> Yes, I still get this bug. Channels are swapped just after the module is
> loaded. First attempt to play something causes output with swapped
> channels, all consequent attempts cause normal output.
> 
> "A long time ago" there was fixed another bug concerned with _random_
> channel swap at _any_ attempt of output. Now we _always_ have swapped
> channels, but only when you try to output something just after the module
> is loaded.
> 
> I use ALSA drivers from the Linux kernel 2.6.11.
> 


Would you add the routine vortex_dump_routes() and post the dump of the 
active routes & mixers at the end of vortex_pcm_hw_params() when 
channels are correct/swapped ?

http://article.gmane.org/gmane.linux.alsa.devel/20490

au88x0_pcm.c
	vortex_dump_routes(chip,"at end of vortex_pcm_close()");
	vortex_dump_routes(chip,"at end of vortex_pcm_hw_params()");
au88x0_core.c
         vortex_dump_routes(vortex,"at end of vortex_connect_deault()");


BTW, this bug seem not RELATED TO issue 0000949.






-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
