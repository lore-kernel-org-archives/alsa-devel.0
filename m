From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000442]: alsactl no loading pcm volume properly.
Date: Thu, 20 Oct 2005 11:00:46 +0200
Message-ID: <ad654ccdec76883c62f8fb8b5dfbfd1c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1BF8E177
	for <alsa-devel@alsa-project.org>; Thu, 20 Oct 2005 11:00:47 +0200 (MEST)
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


The following issue has been set as RELATED TO issue 0001484.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=442> 
======================================================================
Reported By:                lupien_c
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   442
Category:                   PCI - maestro3
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               fedora core 2
Kernel Version:             2.6.7 + acpi + swsusp2
======================================================================
Date Submitted:             08-15-2004 06:35 CEST
Last Modified:              10-20-2005 11:00 CEST
======================================================================
Summary:                    alsactl no loading pcm volume properly.
Description: 
When using alsactl restore after loading the snd_maestro3 sound driver, the
pcm volume is restore only on the right channel. Checking the
settings(with alsactl store or alsamixer) shows the correct value but the
left channel is quiet. 

The same effect is seen when restoring after setting the pcm channel
volume to 0. With a small non-zero volume, the left channel starts quiet
but after a few secdonds comes on.

Changing the pcm channel volume with alsamixer, always works properly and
recovers proper stereo.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001484 Sound works only after volume change
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-15-04 06:35 lupien_c       New Issue                                    
08-15-04 06:35 lupien_c       Distribution              => fedora core 2   
08-15-04 06:35 lupien_c       Kernel Version            => 2.6.7 + acpi +
swsusp2
10-20-05 11:00 jdthood        Relationship added       related to 0001484  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
