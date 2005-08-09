From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000216]: Speed/pitch issues when playing multiple sounds
Date: Tue, 9 Aug 2005 13:13:43 +0200
Message-ID: <02275ed1b9a85f3395b9a6b4fa8f8d6c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5F7411C9
	for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2005 13:13:43 +0200 (MEST)
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


The following issue has been set as RELATED TO issue 0000299.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=216> 
======================================================================
Reported By:                mushroom_head
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   216
Category:                   PCI - au88x0
Reproducibility:            sometimes
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Debian Woody
Kernel Version:             2.4.26
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             04-17-2004 09:13 CEST
Last Modified:              05-22-2004 16:34 CEST
======================================================================
Summary:                    Speed/pitch issues when playing multiple sounds
Description: 
I've compiled alsa driver 1.0.4 today, with kernel 2.4.26.  This bug has
been around going back several versions of alsa and several kernel
versions as well, but I have just been able to track down a way to
reproduce it fairly reliably.  The problem is when playing multiple sound
streams on the sound card, some/all of them can become corrupted.  They
will sometimes play at a higher speed/pitch than they should.  Usually not
lower.  I can reliably trigger it by playing an mp3 over XMMS/oss
emulation, and then taking GAIM set to automatic mode, and rapidly forcing
multiple AIM sounds to the sound card.  This will cause the same AIM sound
to start coming out different.  The will vary in pitch, speed and clarity.
 If The mp3 stream may or may not get corrupted, but if I start another
one up, it sounds very staticy.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000299 No audio after recommended patch (see 0...
======================================================================

----------------------------------------------------------------------
 mjander - 04-17-04 18:54 
----------------------------------------------------------------------
This bug is believed to be fixed on CVS. Use the latest ALSA driver (beyond
1.0.4) and try again.

Thanks

----------------------------------------------------------------------
 mjander - 04-17-04 19:02 
----------------------------------------------------------------------
Try this patch against 1.0.4

http://docencia.mat.utfsm.cl/~mjander/aureal/alsa/aureal-2.6.5.diff.gz

----------------------------------------------------------------------
 salmo - 05-15-04 09:13 
----------------------------------------------------------------------
Wanted to document that I experience the same issue with 2.6.6 (w/ included
ALSA 1.04rc2) on Gentoo.  For me once the Chipmunks start playing all my
favorite songs (as I like to describe the problem) all sounds from that
point forward are sped up and horribly decreased in quality.  So I guess
it's more of a bad Chipmunks bootleg.  GAIM is also what triggered this
for me.

----------------------------------------------------------------------
 mjander - 05-17-04 06:17 
----------------------------------------------------------------------
Well, have you "really" applied the patch ? 2.6.6 still doesn't include it,
and it will with 100% certainty fail. Apply this patch:

http://galadriel.mat.utfsm.cl/~mjander/aureal/alsa/aureal-2.6.5.diff.gz

You'll need it. As it looks like, there will pass some time until the ALSA
team sends a new ALSA update to Linus...

Best Regards

Manuel Jander.

----------------------------------------------------------------------
 mjander - 05-22-04 16:34 
----------------------------------------------------------------------
Please apply the attached patch or use the current CVS (have not tested
personally but i was told that this patch was applied) of ALSA.

Best Regards

Manuel Jander

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-17-04 09:13 mushroom_head  New Issue                                    
04-17-04 09:13 mushroom_head  Distribution              => Debian Woody    
04-17-04 09:13 mushroom_head  Kernel Version            => 2.4.26          
04-17-04 18:54 mjander        Note Added: 0000848                          
04-17-04 19:02 mjander        Note Added: 0000850                          
05-15-04 09:13 salmo          Note Added: 0001120                          
05-17-04 06:17 mjander        Note Added: 0001128                          
05-22-04 16:33 mjander        File Added: aureal-2.6.6.diff.gz                  
 
05-22-04 16:34 mjander        Status                   assigned => closed  
05-22-04 16:34 mjander        Note Added: 0001174                          
08-09-05 13:13 perex          Relationship added       related to 0000299  
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
