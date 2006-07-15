From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001357]: Add a Capture setting
Date: Sat, 15 Jul 2006 22:38:11 +0200
Message-ID: <59fab87b1c5f2dd8c92c4943bf549c54@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3F098160
	for <alsa-devel@alsa-project.org>;
	Sat, 15 Jul 2006 22:38:11 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1357> 
======================================================================
Reported By:                Electro
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1357
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.6.12-gentoo-r6
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             08-22-2005 09:37 CEST
Last Modified:              07-15-2006 22:38 CEST
======================================================================
Summary:                    Add a Capture setting
Description: 
In order to record with an Audiotrak Prodigy 7.1 (snd-1724), I have to
first set the IGAIN setting using aumix. Also I have to use aumix to set
what input I want to capture from. Then I can record with any program. I
would like to a way to set what input to be use for capture and a setting
for the capture level accessible through alsamixer, so it can be changed,
stored, restored. I could use aumix to load the save settings but
sometimes it screws up and only the left channel is recorded.
======================================================================

----------------------------------------------------------------------
 tiwai - 08-23-05 16:53 
----------------------------------------------------------------------
Everything you can do through OSS mixer can be done via alsamixer, too.
You must have missed something in alsamixer (e.g. didn't change the view
mode).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-22-05 09:37 Electro        New Issue                                    
08-22-05 09:37 Electro        Distribution              => Gentoo          
08-22-05 09:37 Electro        Kernel Version            => 2.6.12-gentoo-r6
08-23-05 16:53 tiwai          Note Added: 0005911                          
07-15-06 22:38 Adrian Bunk    Status                   new => closed       
07-15-06 22:38 Adrian Bunk    Resolution               open => not an issue
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
