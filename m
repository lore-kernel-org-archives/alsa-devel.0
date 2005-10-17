From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001472]: Constant distortion noise on digital mixer
Date: Mon, 17 Oct 2005 20:41:19 +0200
Message-ID: <f90e6fa108862d32a3cb096d25af981c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 38C3B188
	for <alsa-devel@alsa-project.org>; Mon, 17 Oct 2005 20:41:20 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1472> 
======================================================================
Reported By:                Atraides
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1472
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Suse
Kernel Version:             2.6.11.4-21.9
======================================================================
Date Submitted:             10-12-2005 02:02 CEST
Last Modified:              10-17-2005 20:41 CEST
======================================================================
Summary:                    Constant distortion noise on digital mixer
Description: 
The hardware in question is a Terratec DMX 6Fire 24/96. I have a constant
crackling (like an old UKW radio between to stations) on the digital
mixer. The noise disappears for a few seconds if I switch the Phono Input,
the Breakout LED or Line In Selector. It changes the noise character when
switching the S/PDIF Input from coaxial to optical. Even if all ins and
outs are muted or tracked down its still there (I can see it in the
Monitor Mixer).
======================================================================

----------------------------------------------------------------------
 alanmann - 10-14-05 12:55 
----------------------------------------------------------------------
It does sound like the same problem if influenced by screening.  However I
think it is not pre-amp type, as it is linked to the digital DXF etc
connector not the analog lines, and most other physical areas of the card
are not involved.  Perhaps an unwanted clock input active?  I wonder if
anyone has data-info on this cards extra functions?

----------------------------------------------------------------------
 Atraides - 10-17-05 20:41 
----------------------------------------------------------------------
Investigation Update:

I played around with envy24control and alsamixer and found something
strange. I get that noise on digital mixer and if I use alsamixer if I set
H/W and H/W 1 (which corresponds to H/W Out 1(L) and H/W Out 2(R) in
envy24control)  to H/W In 7. I can see envy24control switching to the
actual settings when I switch  through the options in alsamixer but
envy24control doesn't know H/W In 6 and 7.

Hope this helps in some kind.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-12-05 02:02 Atraides       New Issue                                    
10-12-05 02:02 Atraides       Distribution              => Suse            
10-12-05 02:02 Atraides       Kernel Version            => 2.6.11.4-21.9   
10-12-05 13:50 tiwai          Note Added: 0006465                          
10-12-05 15:19 Atraides       Note Added: 0006467                          
10-13-05 10:19 alanmann       Note Added: 0006475                          
10-13-05 13:39 Atraides       Note Added: 0006477                          
10-14-05 11:48 Atraides       Note Edited: 0006477                         
10-14-05 12:55 alanmann       Note Added: 0006478                          
10-17-05 20:41 Atraides       Note Added: 0006488                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
