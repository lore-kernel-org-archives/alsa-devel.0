From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001510]: ac97 with SiS SI7012 [ALC203 rev 0] doesn't allow to control volume by master channel, PCM and headphones work
Date: Sun, 30 Oct 2005 09:35:41 +0100
Message-ID: <2949232c86158e9223fb831ad2334ed4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 07350196
	for <alsa-devel@alsa-project.org>; Sun, 30 Oct 2005 09:35:41 +0100 (MET)
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
Last Modified:              10-30-2005 09:35 CET
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

----------------------------------------------------------------------
 garfungiloops - 10-30-05 09:35 
----------------------------------------------------------------------
I have nearly the same problem with SiS 745 and intel8x0.
However I cannot control PCM also. Only one thing i can do is to mute this
channel.

I've tryed in-kernel driver (gentoo-2.6.13-r5) and the recent module.
It works the same way.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-28-05 17:54 wiktorw        New Issue                                    
10-28-05 17:54 wiktorw        Distribution              => Gentoo 2005.1   
10-28-05 17:54 wiktorw        Kernel Version            => 2.6.13-gentoo-r4
10-30-05 09:35 garfungiloops  Note Added: 0006573                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
