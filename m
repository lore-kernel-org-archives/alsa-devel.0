From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000637]: Laptop volume control & mute buttons don't work
Date: Sat, 19 Mar 2005 16:06:02 +0100
Message-ID: <511bd323a3f83d9aae89660f11a440f3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 83C4D1D8
	for <alsa-devel@alsa-project.org>; Sat, 19 Mar 2005 16:06:02 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=637> 
======================================================================
Reported By:                Mark Knecht
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   637
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo
Kernel Version:             2.6.9-rc2-mm4-VP-S7-noACPI-UMP
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             11-08-2004 18:50 CET
Last Modified:              03-19-2005 16:06 CET
======================================================================
Summary:                    Laptop volume control & mute buttons don't work
Description: 
The Compaq, like may laptops, comes with buttons to increase and decrease
volume, as well as a mute button. Under Linux these buttons do nothing.
The mute button is always lit even when sound is coming out. The volume
control buttons do not adjust volume.
======================================================================

----------------------------------------------------------------------
 tiwai - 11-09-04 10:35 
----------------------------------------------------------------------
Usually these buttons are controlled over ACPI.
In some cases, you can get a key event in X server, then you can configure
the window manager to do the right thing.

Anyway, this is not a bug or a missing feature of the sound driver.

----------------------------------------------------------------------
 Mark Knecht - 11-09-04 16:13 
----------------------------------------------------------------------
This was not filed as a bug. It was filed as a feature request. Please do
not be so dismissive. What did you spend? Maybe 3 seconds and then blew it
off?

Under Windows the buttons control volume. Pushing the buttons raises or
lowers volume in the applications. you can see the volume controls go up
and down. 

Why should Linux *not* work this way? I am requesting that Alsa consider
how to be more user friendly. I am not filing a bug report. 

If they are already handled under ACPI (which I do not use on my laptop as
it causes kernel timing problems) then please simply state that Alsa
already handles this. However, I do not beleive that these specific
buttons are handled by ACPI, but that's just my guess.

----------------------------------------------------------------------
 tiwai - 11-09-04 16:57 
----------------------------------------------------------------------
Calm down, this has *nothing* to do with ALSA although the buttons are
printed as volume up/down.  There is *no* hardware connection between
buttons and the sound chip in your case.  Thus, there is nothing the sound
driver can do for this directly.

To support this feature, the ACPI event must be handled by a certain user
space program such as the window manager (or desktop system).

Windows works because it grabs the ACPI event and processes it properly. 
Linux could handle this but the current system doesn't care it.

----------------------------------------------------------------------
 Mark Knecht - 11-09-04 17:49 
----------------------------------------------------------------------
There's no point discussing this. Bye.

----------------------------------------------------------------------
 jdthood - 03-19-05 15:33 
----------------------------------------------------------------------
This can be closed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-08-04 18:50 Mark Knecht    New Issue                                    
11-08-04 18:50 Mark Knecht    Distribution              => Gentoo          
11-08-04 18:50 Mark Knecht    Kernel Version            =>
2.6.9-rc2-mm4-VP-S7-noACPI-UMP
11-09-04 10:35 tiwai          Note Added: 0002317                          
11-09-04 10:36 tiwai          Resolution               open => not an issue
11-09-04 10:37 tiwai          Status                   assigned => resolved
11-09-04 16:13 Mark Knecht    Status                   resolved => feedback
11-09-04 16:13 Mark Knecht    Resolution               not an issue => reopened
11-09-04 16:13 Mark Knecht    Note Added: 0002326                          
11-09-04 16:57 tiwai          Note Added: 0002328                          
11-09-04 17:49 Mark Knecht    Note Added: 0002329                          
03-19-05 15:33 jdthood        Note Added: 0004052                          
03-19-05 16:06 perex          Status                   feedback => resolved
03-19-05 16:06 perex          Resolution               reopened => not an issue
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
