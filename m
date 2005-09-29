From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000079]: Dell Inspiron 8500 ICH4 no sound through internal speakers unless "External Amplifier" switched on
Date: Thu, 29 Sep 2005 12:13:31 +0200
Message-ID: <331ea9b09331a149b1b271ea6b98f29d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 01732191
	for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2005 12:13:31 +0200 (MEST)
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


The following issue has been UPDATED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=79> 
======================================================================
Reported By:                rocco
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   79
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     feedback
Distribution:               Debian
Kernel Version:             2.6.3
======================================================================
Date Submitted:             02-22-2004 21:40 CET
Last Modified:              09-29-2005 12:13 CEST
======================================================================
Summary:                    Dell Inspiron 8500 ICH4 no sound through internal
speakers unless "External Amplifier" switched on
Description: 
Alsa from kernel tree 2.6.3. Internal speakers of the laptop are not
working, when pluggin in something in the headphone output sound is
working. Mixer volume looks ok.
======================================================================

----------------------------------------------------------------------
 rocco - 02-26-04 13:00 
----------------------------------------------------------------------
External Amplifier Power Down must be off (toggled with m, mute) in
alsamixer, then it there is sound in the internal speakers.

This is far from logic, at least that one have to mute external to get
sound.

----------------------------------------------------------------------
 tiwai - 03-01-04 20:13 
----------------------------------------------------------------------
how is the default state of this switch?
it must be off as default.  if it's on, it's a bug of the driver.

and, yes, it's nasty...  note that it's a switch to turn OFF.
maybe it's better to rename it as 'External Amplifier',
and reverse the meaning of the switch.

----------------------------------------------------------------------
 tiwai - 03-10-04 17:57 
----------------------------------------------------------------------
now the switch is renamed to 'External Amplifier'.
it's a bit more obvious than before :)

about the default value: could you check again the default
EAPD value?  stop once alsa service, then remove /etc/asound.state
(or make backup), and start alsa again.

----------------------------------------------------------------------
 jdthood - 03-10-05 15:24 
----------------------------------------------------------------------
> stop once alsa service, then remove /etc/asound.state
> (or make backup), and start alsa again.

Submitter: What is the default External Amplifier state now?

----------------------------------------------------------------------
 jdthood - 09-29-05 12:09 
----------------------------------------------------------------------
Submitter: What is the default External Amplifier state now?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-22-04 21:40 rocco          New Issue                                    
02-26-04 13:00 rocco          Note Added: 0000346                          
03-01-04 20:13 tiwai          Note Added: 0000424                          
03-10-04 17:57 tiwai          Note Added: 0000565                          
03-10-05 15:24 jdthood        Note Added: 0003864                          
09-29-05 12:09 jdthood        Note Added: 0006416                          
09-29-05 12:09 jdthood        Status                   new => feedback     
09-29-05 12:13 jdthood        Summary                  Dell Inspiron 8500 ICH4
no sound through internal speakers, headphone ok. => Dell Inspiron 8500 ICH4 no
sound through internal speakers unless "External Amplifier" switched on
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
