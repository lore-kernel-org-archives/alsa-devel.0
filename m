From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001407]: Can't use rear speaker channels
Date: Tue, 1 Nov 2005 00:35:11 +0100
Message-ID: <71118a0afdeef31790d46d399c8843bb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A62CD167
	for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2005 00:35:11 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1407> 
======================================================================
Reported By:                drow
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1407
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.13-rc6
======================================================================
Date Submitted:             09-09-2005 05:11 CEST
Last Modified:              11-01-2005 00:35 CET
======================================================================
Summary:                    Can't use rear speaker channels
Description: 
I'm using a Shuttle SN25P, which is an nForce4 motherboard with onboard
ice1724.  I've spent most of tonight trying to get surround sound to
work... but the best I can get is four channels (specifically, front
left/right, center, LFE).  Nothing happens when samples are sent to the
rear channels.  And the front channels are mirrored onto the rear
speakers, under control of the Headphone volume control.

Which is really annoying, because it means that muting the master volume
doesn't mute the back speakers.

I realize this isn't much information.  I don't know what else to check
but I'll be glad to debug it if someone can give me a pointer.

======================================================================

----------------------------------------------------------------------
 drow - 09-12-05 18:05 
----------------------------------------------------------------------
I don't know if this is related, but if I use ttable to remap channels, I
get strange results.  I can map the center channel of a sample to the
center speaker, or to the front speakers.  But I can't map the front
channels to the center speaker!

    # ttable.1.0 1 # FR comes out FL speaker
    # ttable.1.1 1 # FR comes out FR speaker
    # ttable.1.* 1 -> nothing

    # ttable.0.0 1 # FL comes out FL speaker
    # ttable.0.* 1 -> nothing

    # ttable.2.0 1 # RL comes out FL
    # ttable.2.1 1 # RL comes out FR
    # ttable.2.2 1 # RL comes out C
    # ttable.2.* 1 -> nothing

    # ttable.3.3 1 # RR (?) comes out center speaker muffled - LFE?

    # ttable.4.4 1 # Nothing, 0-3 work
    # ttable.5.5 1 # Nothing

    # ttable.5.0 1 # Mixed comes out FL
    # ttable.5.1 1 # Mixed comes out FR
    # ttable.5.2 1 # Mixed comes out C
    # ttable.5.3 1 # Mixed comes out LFE
    # ttable.5.4 1 # Nothing
    # ttable.5.5 1 # Nothing

----------------------------------------------------------------------
 drow - 11-01-05 00:35 
----------------------------------------------------------------------
Still no luck with this.  However, I now have Windows installed on the same
machine, and the VIA drivers can talk to the rear speakers just fine.  Is
there any way I can dump useful information from the chip registers while
in Windows?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-09-05 05:11 drow           New Issue                                    
09-09-05 05:11 drow           Distribution              => Debian          
09-09-05 05:11 drow           Kernel Version            => 2.6.13-rc6      
09-09-05 05:13 drow           Note Added: 0006091                          
09-12-05 18:05 drow           Note Added: 0006148                          
11-01-05 00:35 drow           Note Added: 0006591                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
