From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000971]: Compilation Errors - Cannot find specific files during compilation
Date: Tue, 8 Mar 2005 09:52:09 +0100
Message-ID: <4d5d92e1e9d8929efac4f5d0e6a2c376@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B3E411CE
	for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2005 09:52:09 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=971> 
======================================================================
Reported By:                rbechard1
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   971
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             03-08-2005 01:50 CET
Last Modified:              03-08-2005 09:52 CET
======================================================================
Summary:                    Compilation Errors - Cannot find specific files
during compilation
Description: 
When installing the application using the method described in this link:

http://www.alsa-project.org/alsa-doc/doc-php/template.php?company=Creative+Labs&card=Sound+Blaster+PCI+X+%28Dell+OEM%29.&chip=SB0200&module=emu10k1x

I get error messages during the compilation, yet the process tells me it
has completed successfully. When I go to configure my sound card it has
the correct driver loaded but yet there is no sound. When I checked the
mixer settings nothing is muted. 

There is no option within the sound configuration panel to switch to the
correct driver.
======================================================================

----------------------------------------------------------------------
 rbechard1 - 03-08-05 09:52 
----------------------------------------------------------------------
After reading the /etc/modules.conf file I used the following line in the
install instructions rather than the default line:

./configure --with-sound-slot-0=emu1ok1x --with-sequencer=yes;make;make
install

I was able to get the new ALSA version to automatically load on startup.
When I went to load the modules into the kernal I got similar error
messages as before.

Once again alsaconf recognizes and attempts to load the proper driver but
it does not do anything. Now when I try to open a mixer:

Sound server informational message:
Error while initializing the sound driver:
device: default can't be opened for playback (No such device)
The sound server will continue, using the null output device.

But I thought it was a start to at least get the proper ALSA version to
load at the startup!  lol

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-08-05 01:50 rbechard1      New Issue                                    
03-08-05 01:51 rbechard1      Issue Monitored: rbechard1                    
03-08-05 09:52 rbechard1      Note Added: 0003812                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
