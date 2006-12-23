From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: Update to Audioscience asihpi driver
Date: Sat, 23 Dec 2006 15:55:44 +1300
Message-ID: <200612231555.44297.linux@audioscience.com>
References: <200612221709.32864.linux@audioscience.com>
	<s5hvek4qguk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hvek4qguk.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Saturday 23 December 2006 01:01, Takashi Iwai wrote:

> Thanks for the patch.  I applied it to HG tree.

Thanks Takashi,

> But, it's basically too big to accept as a single patch.

See below. Sorry about adding to your workload.


> Such a big change is hard to review and trace.  Please submit patches
> more frequently if possible.  This will make our lives easier :)

We will try!

> Also, the conversion from u16 to HW16 isn't good from the kernel code
> perspective.  The former is the standard variable type in the kernel
> code.  I hope they will be reverted again in the future revision.

Aaagh!  My bad.  

Here is an updated patch that has been through our "ALSA sanitization" 
process.  It fixes the HW16 etc, and as a result is about 1/3 of the size, 
and I hope a bit easier to review.

http://audioscience.com/internet/download/beta/alsa-driver-hg3207_asihpi30506-2.tar.bz2
(No change to firmware)

If the previous patch can be backed out of Hg, that would be preferable though 
I understand if it is not possible.

regards

--
Eliot Blennerhassett
AudioScience Inc.

Summary of main changes
* all files
- convert some u32 to u32 *, for 64 bit eg u32 dwMemBase -> u32 * pMemBase 

* hpi.h, hpifunc.c
- remove AES18 functions
- rework some data structures to accomodate 64 bit pointers

* asihpi.c
- adapt to new stream read/write api
- fix error in capture snd_pcm_hardware descriptor
- add more tuner bands
- remove obsolete aesebu clock control
- revise level meter return to be linear approx

* hpi56301.c
- remove support for ASI4400,4500,4600

* hpi6000.c
- remove unused debug code

* hpi6205.c
- add ASI6500 family

* hpios_linux_kernel.h
- correct block read/write macros

Rename hpios_linux.c to hpios_linux_kernel.c (matches hpios_linux_kernel.h)
Remove unused files hpiman.c hpios_linux.[ch] radio-asihpi.c

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
