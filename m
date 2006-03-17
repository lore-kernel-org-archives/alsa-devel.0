From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001939]: New (nifty) feature: GUI to create .asoundrc
Date: Fri, 17 Mar 2006 21:52:45 +0100
Message-ID: <8dc0fe546b7a0d4493fc23593beb178c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DF7AC1B0
	for <alsa-devel@alsa-project.org>; Fri, 17 Mar 2006 21:52:45 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1939> 
======================================================================
Reported By:                nur_temporär
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1939
Category:                   1_OTHERS
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               n/a
Kernel Version:             n/a
======================================================================
Date Submitted:             03-17-2006 21:16 CET
Last Modified:              03-17-2006 21:52 CET
======================================================================
Summary:                    New (nifty) feature: GUI to create .asoundrc
Description: 
Hello, 

i do not know if this category fits for feature-requests, but i came here
via the link "bug report/feature request" but could not spot the correct
switch where to request this. So, could you rely this to the people who
"are the right guys"? Thanks. 

REQUEST: 
A graphical tool which helps you set up the (quite cryptic) file .asoundrc
file would be nifty. You just pick your card in a pulldown menu, can set
the surround channels, the filter for the subwoofer and similar other
things the average user would want (not all the complex stuff you can do
with the file!). 

Someone with clue(TM) should be able to code this pretty fast, yet the
only problem would be to put in the different settings (eg for the
surround channels). 

If this is done, it could be included in the alsa-mixer. 
Remeber: Windows does have those features, so it would be nifty if Linux
had them as well (if you want to see this OS on desktops, easy usuable
sound is a *must have*). 

Sorry, i do not want to steal more of your precious time, i hope someone
(who can do something about this) agrees to me the idea is good. 

Have a nice day. ;) 
======================================================================

----------------------------------------------------------------------
 rlrevell - 03-17-06 21:52 
----------------------------------------------------------------------
We are approaching this from another angle, by providing the functionality
Windows users expect (software mixing, stereo->5.1 upmixing, etc) in the
default configuration.

The idea is that a custom .asoundrc should only be required for advanced,
specialized usage.

"Remeber: Windows does have those features, so it would be nifty if Linux
had them as well (if you want to see this OS on desktops, easy usuable
sound is a *must have*)."

Exactly which features are you referring to?  My experience is that each
Windows driver provides its own set of features.  It certainly does not
let you configure the device to the same extent that ALSA does...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-17-06 21:16 nur_temporär   New Issue                                    
03-17-06 21:16 nur_temporär   Distribution              => n/a             
03-17-06 21:16 nur_temporär   Kernel Version            => n/a             
03-17-06 21:52 rlrevell       Note Added: 0008661                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
