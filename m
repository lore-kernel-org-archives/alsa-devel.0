From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000782]: Poor digital aidio quality
Date: Wed, 19 Jan 2005 20:45:06 +0100
Message-ID: <13fdd7b21b356296140ad94657dec48d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 584EE176
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2005 20:45:06 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=782> 
======================================================================
Reported By:                ddemmer
Assigned To:                fmoraes
======================================================================
Project:                    ALSA - driver
Issue ID:                   782
Category:                   PCI - emu10k1x
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core
Kernel Version:             2.6.9-1.681_FC3.i686
======================================================================
Date Submitted:             01-03-2005 16:20 CET
Last Modified:              01-19-2005 20:45 CET
======================================================================
Summary:                    Poor digital aidio quality
Description: 
Attempting to play MP3 files with RealPlay or xmms using ALSA output
results in scratchy, erratic, slow (Realplay) or speeded up (xmms) sound.
I can change the xmms configuration to use libOSS.so instead of libALSA
which fixes the problem.

The gnome "Detect Sound Card" utility works fine and plays it's sound
fine.

The gnome volume control does not affect the output level when using
libOSS.

I have by now muted everything in the alsamixer except the Master volume.

Playing a CD works fine.
======================================================================

----------------------------------------------------------------------
 ddemmer - 01-19-05 18:34 
----------------------------------------------------------------------
Some more info.

Things are getting better. I dug a bit more into the xmms
Options/Preferences. I noticed a "configure" button for the Alsa playback,
and noted it was set to "default PCM" When I changed that to emu10k1x
Front hw:0,0 playback was fine.

So, I think the "default PCM" was reset to something strange when I had
the SB16 installed. I'm sure that when I get the time to look into the
alsa config I can fix that and everything else will be fine.

However, perhaps you guys should look into how the configuration files are
updated when installing/reinstalling cards.

----------------------------------------------------------------------
 tiwai - 01-19-05 20:45 
----------------------------------------------------------------------
Make sure that you have no pcm.default definition in ~/.asoundrc.

Just to be sure: instead of hw:0,0, please try plughw:0,0.
Does it work, too?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-03-05 16:20 ddemmer        New Issue                                    
01-03-05 16:20 ddemmer        Distribution              => Fedora Core     
01-03-05 16:20 ddemmer        Kernel Version            => 2.6.9-1.681_FC3.i686
01-03-05 16:49 stransky       Issue Monitored: stransky                    
01-04-05 13:43 ddemmer        Issue Monitored: ddemmer                     
01-04-05 13:43 ddemmer        Issue End Monitor: ddemmer                    
01-16-05 14:57 fmoraes        Note Added: 0003217                          
01-16-05 20:43 ddemmer        Note Added: 0003221                          
01-19-05 18:34 ddemmer        Note Added: 0003310                          
01-19-05 20:45 tiwai          Note Added: 0003317                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
