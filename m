From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001501]: intel8x0 surround channels missing and swapped
Date: Tue, 1 Nov 2005 15:42:19 +0100
Message-ID: <f26ace9a99a73f2e64df8e8a5abfffea@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 64F9015C
	for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2005 15:42:19 +0100 (MET)
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


The following issue has been set as RELATED TO issue 0001173.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1501> 
======================================================================
Reported By:                dkoch
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1501
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 3
Kernel Version:             2.6.14-rc5-gac9b9c66
======================================================================
Date Submitted:             10-25-2005 16:45 CEST
Last Modified:              10-25-2005 18:12 CEST
======================================================================
Summary:                    intel8x0 surround channels missing and swapped
Description: 
By default, the front channels are OK, the rear channels come out on the
center/LFE jack and the center/LFE channels don't come out at all.

Using ICH5/AD1985 (Intel P865PERL motherboard).

Anomolies found: double-rate slot (DRSLOT) is set to 7,8 instead of the
default
10,11 (register 0x20=0400 instead of 0).  After setting 0x20 to 0, the
rear
channel jack starts working.  RL/RR and Center/LFE are still swapped.

I would assume the swappage was hardware, but the Center and LFE volume
controls
affect the speakers on the Center/LFE jack which would indicate the driver
is
incorrectly routing the signals.

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001521 Speakers misplaced in 5.1 surround
related to          0001369 Rear left/right channels swapped with c...
related to          0001173 No sound from rear channels
======================================================================

----------------------------------------------------------------------
 tiwai - 10-25-05 17:56 
----------------------------------------------------------------------
Setting DR slot to 7/8 is intentional, as found in ac97_codec.c.
The question is whether this still has influence even DRA bit is off on
extended status regsiter.
Could you check whether reg 0x2a bit 1 (0x0002) is off during playback of
48khz (or less) samples?

----------------------------------------------------------------------
 dkoch - 10-25-05 18:09 
----------------------------------------------------------------------
0x2a, bit 1 is off: 0:2a = 05f1

----------------------------------------------------------------------
 tiwai - 10-25-05 18:11 
----------------------------------------------------------------------
An experimental patch is attached.  Give it a try.

It won't fix the problem of channel swapping.
This is also what I don't figure out yet.  On older ICH chips, the
surround channels are swapped on alsa-lib.  But, ICH4 or newer don't do
this because the bugreports have suggested they work without swapping. 
And now you report that it's not...

The fix isn't difficult.  The configuration for each card is found in
/usr/share/alsa/cards directory.  Change "surround51" definition in
ICH4.conf just like ICH.conf, using route plugin.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-25-05 16:45 dkoch          New Issue                                    
10-25-05 16:45 dkoch          Distribution              => Fedora Core 3   
10-25-05 16:45 dkoch          Kernel Version            => 2.6.14-rc5-gac9b9c66
10-25-05 17:56 tiwai          Note Added: 0006546                          
10-25-05 18:09 dkoch          Note Added: 0006547                          
10-25-05 18:11 tiwai          Note Added: 0006548                          
10-25-05 18:12 tiwai          File Added: ac97-dra-conflict.diff                
   
11-01-05 15:27 jdthood        Relationship added       related to 0001521  
11-01-05 15:35 jdthood        Relationship added       related to 0001369  
11-01-05 15:42 jdthood        Relationship added       related to 0001173  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
