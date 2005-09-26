From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001447]: SPDIF IN>OUT Loop missing
Date: Mon, 26 Sep 2005 15:48:53 +0200
Message-ID: <e500c37b563241714b889e884de8e617@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8C52417E
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2005 15:48:53 +0200 (MEST)
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


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1447> 
======================================================================
Reported By:                Mimosius
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1447
Category:                   PCI - ymfpci
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             09-23-2005 20:47 CEST
Last Modified:              09-26-2005 15:48 CEST
======================================================================
Summary:                    SPDIF IN>OUT Loop missing
Description: 
Hi,

I'm using a Hoontech Digital-XG and I was missing the capability to loop
the digital signal from SPDIF-in to SPDIF- out, so I modified the
ymfpci_main.c, adding an extra mixer switch (patch against latest CVS
version included). Would anyone of the developers verify this patch and
add this feature to the ymfpci module?

Regards,
Glen Masgai
======================================================================

----------------------------------------------------------------------
 Mimosius - 09-26-05 15:38 
----------------------------------------------------------------------
Hi Clemens,

>Please use a[0] instead of *a when accessing an array.
Of course, a[0] should be the better choice :)

>You don't really need separate variables for ref, shift, and mask;
similar code in other functions was just copied from generic code that
read these values from the mixer element.

... and this is my problem.
To enable the loop bit 5 of register 0x34 has to be set as well as bit 1
to enable Capture on SPDIF-in. If bit 5 is unset and bit 1 is set the
signal from SPDIF-in gets routed through the SRC instead.
In fact that YDSXGR_SPDIFINCTRL is defined as register 0x34 and it's
already used to set bit 1, I really don't know how handle it with bit 5
too in the functions:

static int snd_ymfpci_info_single(snd_kcontrol_t *kcontrol,
snd_ctl_elem_info_t * uinfo)
static int snd_ymfpci_get_single(snd_kcontrol_t * kcontrol,
snd_ctl_elem_value_t * ucontrol)
static int snd_ymfpci_put_single(snd_kcontrol_t * kcontrol,
snd_ctl_elem_value_t * ucontrol)

which provides 
 case YDSXGR_SPDIFINCTRL: break;

Therefore I decided to use separate functions with own reg, shift and
mask.

Regards
Glen Masgai

----------------------------------------------------------------------
 Clemens Ladisch - 09-26-05 15:48 
----------------------------------------------------------------------
You could put two values (register and bit number) into the kcontrol's
private_value field, like the AC'97 codec driver does.

Don't bother too much with interdependencies between registers/bits; the
mixer controls are supposed to reflect the actual hardware controls.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-23-05 20:47 Mimosius       New Issue                                    
09-23-05 20:47 Mimosius       File Added: ymfpci_spdifloop.diff                 
  
09-23-05 20:47 Mimosius       Issue Monitored: Mimosius                    
09-26-05 11:10 Clemens LadischNote Added: 0006392                          
09-26-05 15:38 Mimosius       Note Added: 0006393                          
09-26-05 15:48 Clemens LadischNote Added: 0006394                          
09-26-05 15:48 Clemens LadischAssigned To               => Clemens Ladisch 
09-26-05 15:48 Clemens LadischStatus                   new => assigned     
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
