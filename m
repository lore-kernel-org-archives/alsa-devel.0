From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001014]: card detect function is never called in pxa2xx-ac97
Date: Fri, 8 Jul 2005 10:27:33 +0200
Message-ID: <84cde25b323d7efab2ed2320c4a228b3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6CA1417A
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 10:27:33 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1014> 
======================================================================
Reported By:                twinsen
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1014
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               custom: PXA255/uClibc
Kernel Version:             2.6.11.5
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-25-2005 00:04 CET
Last Modified:              07-08-2005 10:27 CEST
======================================================================
Summary:                    card detect function is never called in pxa2xx-ac97
Description: 
Hi there,
I have a some problem with this driver. The environment:
ALSA source: alsa-driver-1.0.9rc1
Kernel source: linux-2.6.11.5 (stock)

I cross compiled the kernel and the alsa source for arm target with a 
toolchain from handhelds.org. I used the following configure command
line:

./configure --with-cards=pxa2xx-ac97 
--with-kernel=/home/twinsen/EmbeddedLinux/Kernel/linux-2.6.11.5 
--with-build=/home/twinsen/EmbeddedLinux/Kernel/linux-2.6.11.5 
--with-cross=/usr/local/arm/3.3.2/bin/arm-linux-

config runs without problems, when running make gcc complains about
"pci_dev_present" being redefined (alsa-driver-1.0.9rc1/include/adriver.h,
orig: include/linux/pci.h), but compiles ok. 

The problem:
I loaded all modules (snd, snd-timer, snd-page-alloc, snd-pcm,
snd-ac97-codec, snd-pxa2xx-pcm, snd-pxa2xx-ac97) but still no soundcard in
/proc/asound/cards.
I looked a bit inside the driver, and when snd-pxa2xx-ac97 is loaded, the
module init function registers the new driver:
driver_register(&pxa2xx_ac97_driver);

The driver struct contains a probe function:
.probe          = pxa2xx_ac97_probe,
but it's never called, so the driver doesn't even check the existance of
the sound card. Why is that? Did I srcew up the cross compiling?
Thanks:
	George
======================================================================

----------------------------------------------------------------------
 twinsen - 06-14-05 14:15 
----------------------------------------------------------------------
Unfortunately I can't do further testing, the project's over, and I had to
give eval board back to the school. I contacted an other developer using
the same board, same kernel, same environment, and he had success using
alsa. He recommended  adding the following 4 lines in pxa2xx-ac97:
               pxa2xx_ac97_write(pxa2xx_ac97_ac97,
AC97_EXTENDED_STATUS,1);
               pxa2xx_ac97_write(pxa2xx_ac97_ac97, 0x6a,0x1ff7);
               pxa2xx_ac97_write(pxa2xx_ac97_ac97, 0x6a,0x0050);
               pxa2xx_ac97_write(pxa2xx_ac97_ac97, 0x6c,0x0030); 
He told me that this hack will solve the problem, i haven't checked it
though. OSS emulation was fine for finishing the project.
Thanks for all your help!

----------------------------------------------------------------------
 perex - 07-08-05 10:27 
----------------------------------------------------------------------
Note, if you want to fix the issue in CVS, please, provide us a patch.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-25-05 00:04 twinsen        New Issue                                    
03-25-05 00:04 twinsen        Distribution              => custom: PXA255/uClibc
03-25-05 00:04 twinsen        Kernel Version            => 2.6.11.5        
03-29-05 16:25 tiwai          Note Added: 0004247                          
03-29-05 23:43 twinsen        Note Added: 0004259                          
04-03-05 21:47 twinsen        Note Added: 0004321                          
04-03-05 22:28 twinsen        Note Added: 0004322                          
04-04-05 20:51 twinsen        Note Added: 0004330                          
04-06-05 19:20 twinsen        Note Added: 0004351                          
04-07-05 16:46 tiwai          Note Added: 0004359                          
04-10-05 17:25 twinsen        Note Added: 0004439                          
04-11-05 18:24 tiwai          Note Added: 0004443                          
06-06-05 10:58 perex          Note Added: 0004900                          
06-14-05 14:15 twinsen        Note Added: 0005016                          
07-08-05 10:27 perex          Status                   assigned => resolved
07-08-05 10:27 perex          Resolution               open => fixed       
07-08-05 10:27 perex          Note Added: 0005406                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
