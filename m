From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001059]: dsx_support and APIC interaction
Date: Sun, 17 Apr 2005 20:41:14 +0200
Message-ID: <87e9b54295a00f6967bb628f02c4026b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 42F77214
	for <alsa-devel@alsa-project.org>; Sun, 17 Apr 2005 20:41:14 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1059> 
======================================================================
Reported By:                systemloc
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1059
Category:                   PCI - via82xx
Reproducibility:            have not tried
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Slackware 10.0
Kernel Version:             2.6.7
======================================================================
Date Submitted:             04-17-2005 20:41 CEST
Last Modified:              04-17-2005 20:41 CEST
======================================================================
Summary:                    dsx_support and APIC interaction
Description: 
I was using the 2.6.7 kernel without APIC or ACPI support, and the via82xx

driver worked perfectly, compiled as a module, without any options. I
built a 
new 2.6.7 kernel on the same hardware with APIC and ACPI support in the 
kernel, as the board supports it, and the driver did not work correctly.
When 
sound was played, a short, 1 second long bit of the sound to be played was

looped. Possibly this is the clicking noise described by some people? The

driver works fine with this new kernel after adding the option 
"dxs_support=1". I hope this interaction with ACPI and APIC sheds some
light 
on some of the troubles with this driver. I can provide more information
if 
anyone wants it. Please CC me, I'm not on the list.

TJ


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-17-05 20:41 systemloc      New Issue                                    
04-17-05 20:41 systemloc      Distribution              => Slackware 10.0  
04-17-05 20:41 systemloc      Kernel Version            => 2.6.7           
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
