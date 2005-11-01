From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001521]: Speakers misplaced in 5.1 surround
Date: Tue, 1 Nov 2005 15:28:32 +0100
Message-ID: <92f2bf60809465d7a3109c1111f32a70@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 18D7E156
	for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2005 15:28:36 +0100 (MET)
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


The following issue has been set as RELATED TO issue 0001206.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1521> 
======================================================================
Reported By:                chareos
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1521
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Ubuntu
Kernel Version:             2.6.12.9 - 2.6.13.4 - 2.6.14
======================================================================
Date Submitted:             11-01-2005 14:29 CET
Last Modified:              11-01-2005 15:28 CET
======================================================================
Summary:                    Speakers misplaced in 5.1 surround
Description: 
With basic Ubuntu Breezy settings I get speakers misplaced: voices are on
rear left channel, rear right channel is mute and I suppose front channel
are messed up.

Note that "speaker-test -Dplug:surround51 -c6" gives excellent and perfect
working results, every channel on the right speaker.

Tried with kernels 2.6.12.9 - 2.6.13.4 - 2.6.14
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001501 intel8x0 surround channels missing and ...
related to          0001206 No center channel; rear left and right ...
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-01-05 14:29 chareos        New Issue                                    
11-01-05 14:29 chareos        Distribution              => Ubuntu          
11-01-05 14:29 chareos        Kernel Version            => 2.6.12.9 - 2.6.13.4 -
2.6.14
11-01-05 15:27 jdthood        Relationship added       related to 0001501  
11-01-05 15:28 jdthood        Relationship added       related to 0001206  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
