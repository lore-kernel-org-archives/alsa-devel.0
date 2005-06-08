From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000026]: Noises when playing sound on VT8237+ALC655
Date: Wed, 8 Jun 2005 18:07:32 +0200
Message-ID: <c7f4656eeee463490ff804e1c998039e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 236B71DE
	for <alsa-devel@alsa-project.org>; Wed,  8 Jun 2005 18:07:33 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=26> 
======================================================================
Reported By:                xram
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   26
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-02-2004 06:22 CET
Last Modified:              06-08-2005 18:07 CEST
======================================================================
Summary:                    Noises when playing sound on VT8237+ALC655
Description: 
I have noisy crackles when playing sound. I tried to set dxs_support=1, 2,
3 and 4. Best result - dxs_support=4 (minimum crackles). I upgraded my
system bios, but it didn't solve my problem. My system:
M/B: Epox 8KRAI
South Bridge: VIA VT8237
Codec: Realtek ALC 655

PS.(Sorry for my english :)
======================================================================

----------------------------------------------------------------------
 tiwai - 03-01-04 19:21 
----------------------------------------------------------------------
the bugs with ALC655/658 should have been fixed with the recent version.
try 1.0.3.

----------------------------------------------------------------------
 perex - 06-08-05 18:07 
----------------------------------------------------------------------
Ok, just ping, does this problem persist with the latest ALSA driver?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-02-04 06:22 xram           New Issue                                    
02-02-04 15:16 tiwai          Note Added: 0000106                          
02-02-04 15:16 tiwai          Status                   new => assigned     
02-02-04 15:16 tiwai          Assigned To               => tiwai           
02-03-04 17:37 chb            Note Added: 0000138                          
03-01-04 19:21 tiwai          Note Added: 0000420                          
06-08-05 18:07 perex          Note Added: 0004968                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
