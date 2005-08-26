From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001303]: AD1816A sound driver has no parameter to adjust reference clock frequency
Date: Fri, 26 Aug 2005 14:55:37 +0200
Message-ID: <0bece420a256a6130de8b02caa3fe658@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7AFBA1D6
	for <alsa-devel@alsa-project.org>; Fri, 26 Aug 2005 14:55:37 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1303> 
======================================================================
Reported By:                tek01
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1303
Category:                   ISA - ad1816a
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               does not matter
Kernel Version:             at least up to 2.6.13-rc4
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             08-02-2005 17:38 CEST
Last Modified:              08-26-2005 14:55 CEST
======================================================================
Summary:                    AD1816A sound driver has no parameter to adjust
reference clock frequency
Description: 
The ALSA AD1816A sound driver has no parameter to specify the reference
clock frequency. The AD1816A chip has been designed for a 33MHz reference
clock, however some cards are shipped with different reference clocks
(mostly 32.125MHz). Thus the sample rate has to be corrected on those
cards before it is written to the hardware registers for proper capture
and playback speed.
======================================================================

----------------------------------------------------------------------
 tiwai - 08-03-05 12:30 
----------------------------------------------------------------------
Could you try the attached patch?

----------------------------------------------------------------------
 tiwai - 08-26-05 14:55 
----------------------------------------------------------------------
The patch is already on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-02-05 17:38 tek01          New Issue                                    
08-02-05 17:38 tek01          Distribution              => does not matter 
08-02-05 17:38 tek01          Kernel Version            => at least up to
2.6.13-rc4
08-02-05 18:27 Adrian Bunk    Issue Monitored: Adrian Bunk                    
08-03-05 12:30 tiwai          Note Added: 0005622                          
08-03-05 12:32 tiwai          File Added: ad1816a-clockfreq.diff                
   
08-26-05 14:55 tiwai          Status                   new => resolved     
08-26-05 14:55 tiwai          Resolution               open => fixed       
08-26-05 14:55 tiwai          Assigned To               => tiwai           
08-26-05 14:55 tiwai          Note Added: 0005953                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
