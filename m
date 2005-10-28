From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001510]: ac97 with SiS SI7012 [ALC203 rev 0] doesn't allow to control volume by master channel, PCM and headphones work
Date: Fri, 28 Oct 2005 17:54:45 +0200
Message-ID: <46769680fc0981f66d8287c1d0cd9b5c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 380B9147
	for <alsa-devel@alsa-project.org>; Fri, 28 Oct 2005 17:54:46 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1510> 
======================================================================
Reported By:                wiktorw
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1510
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo 2005.1
Kernel Version:             2.6.13-gentoo-r4
======================================================================
Date Submitted:             10-28-2005 17:54 CEST
Last Modified:              10-28-2005 17:54 CEST
======================================================================
Summary:                    ac97 with SiS SI7012 [ALC203 rev 0] doesn't allow to
control volume by master channel, PCM and headphones work
Description: 
On my Acer Aspire 5002LM laptop I have the following problem:
- Master channel does not control volume level (no matter if I slide it or
mute)
- PCM channel works
- Headphone/PCM-2 channel works

The Master/PCM/Headphone channels are for the "SiS SI7012 (Alsa Mixer)"
device, while Volume/PCM/PCM-2 channels are for the "Realtek ALC203 rev 0
(OSS Mixer)" device. They do the same thing: Master/Volume control in
gnome-volume-control applet doesn't change the volume level.

At first I thought that this problem is software-related, but in fact it
isn't. Now I have tested several things and all give me the same result. I
also suspect that not only I have such problems, althought the original
posters might not be aware of it. See here for the original discussion:

http://forums.gentoo.org/viewtopic-t-387739.html

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-28-05 17:54 wiktorw        New Issue                                    
10-28-05 17:54 wiktorw        Distribution              => Gentoo 2005.1   
10-28-05 17:54 wiktorw        Kernel Version            => 2.6.13-gentoo-r4
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
