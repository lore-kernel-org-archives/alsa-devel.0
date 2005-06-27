From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001083]: NVIDIA CK8 ALC655 SPDIF passthrough
Date: Mon, 27 Jun 2005 16:56:13 +0200
Message-ID: <3c8f82e84124aec41d7c020e13ccc412@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6CFA81DD
	for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2005 16:56:13 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1083> 
======================================================================
Reported By:                vedran
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1083
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian sid
Kernel Version:             2.6.10-ac12
======================================================================
Date Submitted:             04-29-2005 15:33 CEST
Last Modified:              06-27-2005 16:56 CEST
======================================================================
Summary:                    NVIDIA CK8 ALC655 SPDIF passthrough
Description: 
We're using a motherboard with nVidia nforce2IGP chipset, and the sound
device on this board is NVidia CK8, Realtek ALC655 rev 0. The motherboard
is MSI K7N2GM2, and SPDIF passthrough works fine on Windows XP with stock
realtek drivers.

On Linux, I'm using the latest ALSA CVS (29.04.2005.) on a 2.6.10-ac12
kernel.

I've been able to make a 2 channel  pre-decoded SPDIF output work by using
the hw:0,2 device. If I use the default device, there is no sound on
SPDIF, regardless of the SPDIF related controls in mixer. The controls in
the mixer are:

However, I'm having trouble with AC3 passthrough, I'm using ac3dec -C from
alsa-tools CVS, and I get no sound.

I'm attaching the archive with the output of iecset and
/proc/asound/card0/codec97#0/* files during the ac3dec run, and when
idle.

Maybe the fact that decoded SPDIF output is not working until I pass it
through the hw:0,2 has something to do with this, how can I make ac3dec -C
use hw:0,2?
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001094 nforce4 - optical spdif out not working
======================================================================

----------------------------------------------------------------------
 gilesjuk - 06-26-05 13:19 
----------------------------------------------------------------------
But in my case the Realtek chip is on a seperate card with the SPDIF and
audio ports. Surely the audio data gets written to this chip and then
routed to the outputs depending on how the registers are set?

This is my board:
"http://www.abit-usa.com/products/mb/products.php?categories=1&model=262"

Excuse my ignorance, but how is the Nforce chipset responsible for the
audio when it's an external codec being used?



----------------------------------------------------------------------
 tiwai - 06-27-05 16:56 
----------------------------------------------------------------------
nforce chip is the DMA engine and controls the connected ac97 chip(s). 
AC97 chip only converts the signal (that's why called "codec"), and isn't
responsible for DMA.
Although AC97 can support SPDIF, but some onboard controller chips don't
require AC97 for SPDIF I/O but do by themselves, e.g. ATIIXP and ALI5455.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-29-05 15:33 vedran         New Issue                                    
04-29-05 15:33 vedran         File Added: spdif_passthrough.tar.gz              
     
04-29-05 15:33 vedran         Distribution              => Debian sid      
04-29-05 15:33 vedran         Kernel Version            => 2.6.10-ac12     
05-30-05 13:21 vedran         Note Added: 0004809                          
06-01-05 16:53 tiwai          Note Added: 0004862                          
06-01-05 16:54 tiwai          Relationship added       has duplicate 0001094
06-01-05 19:19 eklarson       Issue Monitored: eklarson                    
06-03-05 00:31 Human          Note Added: 0004880                          
06-03-05 00:32 Human          Issue Monitored: Human                       
06-06-05 23:30 Human          Note Added: 0004910                          
06-08-05 15:01 tiwai          Note Added: 0004928                          
06-10-05 18:07 Human          Note Added: 0004984                          
06-19-05 16:07 gilesjuk       Note Added: 0005090                          
06-21-05 00:50 gilesjuk       Note Added: 0005099                          
06-21-05 00:57 gilesjuk       Note Edited: 0005099                         
06-21-05 11:19 tiwai          Note Added: 0005102                          
06-26-05 13:18 gilesjuk       Note Added: 0005263                          
06-26-05 13:19 gilesjuk       Note Edited: 0005263                         
06-27-05 16:56 tiwai          Note Added: 0005280                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
