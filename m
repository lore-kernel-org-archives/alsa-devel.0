From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001014]: card detect function is never called in pxa2xx-ac97
Date: Mon, 6 Jun 2005 10:58:38 +0200
Message-ID: <1be3bbe1d03045531bf14a0c53432440@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (unknown [195.113.161.147])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F034214E
	for <alsa-devel@alsa-project.org>; Mon,  6 Jun 2005 10:58:38 +0200 (MEST)
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


A NOTE has been added to this issue.
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
Status:                     assigned
Distribution:               custom: PXA255/uClibc
Kernel Version:             2.6.11.5
======================================================================
Date Submitted:             03-25-2005 00:04 CET
Last Modified:              06-06-2005 10:58 CEST
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
 tiwai - 04-11-05 18:24 
----------------------------------------------------------------------
avail_min=0 is the culprit.  I don't know yet why it's set so...

----------------------------------------------------------------------
 perex - 06-06-05 10:58 
----------------------------------------------------------------------
What prints the command 'aplay -v /tmp/music.wav' ?

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
