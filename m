From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000324]: Audigy2 Platinum: very low volume (both in and out)
Date: Wed, 31 Aug 2005 18:54:55 +0200
Message-ID: <d459bbba294cef6337a0e98a7302dc85@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9AB9521F
	for <alsa-devel@alsa-project.org>; Wed, 31 Aug 2005 18:54:55 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=324> 
======================================================================
Reported By:                garden
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Issue ID:                   324
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian sid
Kernel Version:             2.6.5
======================================================================
Date Submitted:             06-06-2004 13:17 CEST
Last Modified:              08-31-2005 18:54 CEST
======================================================================
Summary:                    Audigy2 Platinum: very low volume (both in and out)
Description: 
Both the input and output levels of my Audigy2 Platinum seem to be very low
if compared to the same card with Windows (win98se). For example, I
connected an external source (a MD player with very loud music in the
disc) to the optical input, then to the aux input, then to the aux2 input.
With the mixer settings to 100% the input level still does not go over
20-25% of the maximum amplitude (while with Windows I have to lower the
input level or it will be too high). The same thing applies to the output
level of my analog speakers. [I must be *very* careful when I reboot with
Windows and must not forget to turn the volume knob from 10 to 2]. I had
exactly the same problem when I used the emu10k1 drivers from sourceforge.
======================================================================

----------------------------------------------------------------------
 pzad - 08-31-05 14:01 
----------------------------------------------------------------------
This is not in AC97 - it is used only for recording - and is already on
max. I think diffrence are in DSP code.

----------------------------------------------------------------------
 rlrevell - 08-31-05 18:54 
----------------------------------------------------------------------
Could this be related to the "x4" stuff in the kX driver?  Inputs from the
ADC are multiplied by 4 (since the ADC is 16 bit and the DSP 32 bit) then
divided by 4 at the output.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-06-04 13:17 garden         New Issue                                    
06-06-04 13:17 garden         Distribution              => Debian sid      
06-06-04 13:17 garden         Kernel Version            => 2.6.5           
06-28-04 09:17 pzad           Status                   new => assigned     
06-28-04 09:17 pzad           Assigned To               => pzad            
09-14-04 15:24 garden         Note Added: 0001758                          
09-16-04 10:16 pzad           Note Added: 0001766                          
09-16-04 11:32 garden         File Added: amixer.out                       
09-16-04 11:37 garden         Note Added: 0001769                          
09-16-04 12:17 pzad           Note Added: 0001772                          
09-16-04 13:23 garden         Note Added: 0001773                          
08-30-05 12:23 jdthood        Note Added: 0005975                          
08-30-05 12:32 garden         Note Added: 0005978                          
08-30-05 20:21 rlrevell       Note Added: 0005981                          
08-31-05 14:01 pzad           Note Added: 0005988                          
08-31-05 18:54 rlrevell       Note Added: 0005990                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
