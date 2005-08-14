From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001311]: drivers load but unmuting channels / adjusting volumes does not produce any sound
Date: Mon, 15 Aug 2005 01:15:16 +0200
Message-ID: <b16c87309ce69b0282043ce46da5bec2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D18D91A1
	for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2005 01:15:16 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1311> 
======================================================================
Reported By:                hettar
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1311
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu
Kernel Version:             2.6.10
======================================================================
Date Submitted:             08-05-2005 01:10 CEST
Last Modified:              08-15-2005 01:15 CEST
======================================================================
Summary:                    drivers load but unmuting channels / adjusting
volumes does not produce any sound
Description: 
I have installed the 1.0.9b version of alsa kernel/libs and utils in an
attempt to get the intel high definition sound card working. These all
appear to work, I can unmute the various channels, adjust volumes etc,
however no matter what I do I can't get any sound out. Sound apps are all
playing fine but don't actually produce any sound.

This is the card in the new ASUS W2 laptop and could be slightly different
to other models.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001176 problem with alsa-driver and asus m5a n...
======================================================================

----------------------------------------------------------------------
 tiwai - 08-11-05 14:34 
----------------------------------------------------------------------
Try ALSA CVS version.  There is a new model "asus".

----------------------------------------------------------------------
 hettar - 08-15-05 01:15 
----------------------------------------------------------------------
I have installed the CVS version with the following results.
If I specify no model or the asus model I can get sound but only from the
"front" channel. The LFE, center and surround channels seem to do nothing,
and I only get sound out of the front speakers or headphones if plugged
in.

If I specify "model=asus" I have as above but most of the other channels
like spidf are missing. The cards listed in the ALSA-Configuration.txt
file all seem to be for desktop systems not laptops.

I need to use position_fix=1 or it makes a horrible crackling sound. In
addition the volume is very low, I can't actually hear anything until the
volume is up to about 60%.

However at least I can get some sound now :-)

Would it be helpful if I built it with debug ??

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-05-05 01:10 hettar         New Issue                                    
08-05-05 01:10 hettar         Distribution              => Ubuntu          
08-05-05 01:10 hettar         Kernel Version            => 2.6.10          
08-05-05 01:58 hettar         Note Added: 0005654                          
08-05-05 08:39 perex          Note Edited: 0005654                         
08-05-05 08:39 perex          Relationship added       related to 0001176  
08-05-05 09:10 hettar         Note Added: 0005662                          
08-11-05 14:34 tiwai          Note Added: 0005760                          
08-15-05 01:15 hettar         Note Added: 0005816                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
