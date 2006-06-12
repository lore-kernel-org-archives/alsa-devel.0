From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002174]: No sound at all using
	snd-hda-intel / alsa-1.0.11
Date: Mon, 12 Jun 2006 22:54:53 +0200
Message-ID: <1172bc1c2e9684b79f5d6948aa0d63a6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 99AE4152
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Jun 2006 22:54:53 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2174> 
======================================================================
Reported By:                carllivitt
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2174
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 5
Kernel Version:             2.6.16-1.2122_FC5smp
======================================================================
Date Submitted:             05-30-2006 17:11 CEST
Last Modified:              06-12-2006 22:54 CEST
======================================================================
Summary:                    No sound at all using snd-hda-intel / alsa-1.0.11
Description: 
On my new Toshiba Satellite Pro P100 laptop, I cannot get sound from the
speakers or headphone jack. It has never worked.

I've used the standard FC5 kernel and the updated kernel
(2.6.16-1.2122FC5smp) without success. 

I've downloaded and installed the alsa-*-1.0.11 drivers etc, but still no
sound. Everything is unmuted, alsamixer can turn the volume controls up
and down, KDE's kmix also works fine but still no sound. There are no
error messages in the syslog. 

I've also tried using the 'single_cmd=1' module loading option. 

I tried the CVS version of ALSA, but it didn't work with my kernel - there
were unresolved symbols that I couldn't resolve. I'm back to using the
1.0.11 version.

======================================================================

----------------------------------------------------------------------
 carllivitt - 06-12-06 22:52 
----------------------------------------------------------------------
I've now got the latest hg build  - the modules are built and working
fine... except of course there is no sound ;)

How do I determine which model I have (other than trying each one in
turn)?

----------------------------------------------------------------------
 rlrevell - 06-12-06 22:54 
----------------------------------------------------------------------
Check /proc/asound/card0/codec* to find out which codec you have then try
all the models listed for that codec in the docs.  It's easy, just rmmod
snd-hda-intel and modprobe again with each model.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-30-06 17:11 carllivitt     New Issue                                    
05-30-06 17:11 carllivitt     Distribution              => Fedora Core 5   
05-30-06 17:11 carllivitt     Kernel Version            => 2.6.16-1.2122_FC5smp
06-04-06 23:36 carllivitt     Issue Monitored: carllivitt                    
06-04-06 23:37 carllivitt     Note Added: 0010065                          
06-12-06 21:51 carllivitt     Note Added: 0010174                          
06-12-06 22:03 rlrevell       Note Added: 0010175                          
06-12-06 22:52 carllivitt     Note Added: 0010176                          
06-12-06 22:54 rlrevell       Note Added: 0010177                          
======================================================================
