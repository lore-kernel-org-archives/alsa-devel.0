From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000782]: Poor digital aidio quality
Date: Wed, 19 Jan 2005 18:34:35 +0100
Message-ID: <b53f643aa875211cb05e037775ff5f21@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C961A24E
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2005 18:34:37 +0100 (MET)
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
Last Modified:              01-19-2005 18:34 CET
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
 ddemmer - 01-16-05 20:43 
----------------------------------------------------------------------
Well, things have changed with 1.0.8!

I tried installing rhythmbox and everything worked fine. 

I then tried ALSA 1.0.8.rc2, and there was no change: rhythmbox works,
xmms and realplay were "scratchy' with mp3, xmms was fine with libOSS.so
as the output module. Gnome system sounds are enabled and seem fine. I
tried the same with KDE and they are fine, too.

I have just installed 1.0.8 and now:

1. xmms and realplay both complain at startup that the audio device is
busy and won't proceed any further
2. rythmbox complains that the "default" device is busy and that it can't
pause audio, but then after I click OK it goes on to work normally.
3. Gnome soundcard detect works fine.
4. Gstreamer prefs complains that it can't construct test pipeline, for
any sound configuration.
5. Both Gnome and KDE system sounds still work fine.

Note: I have installed alsa-driver, alsa-libs, alsa-utils, alsa-oss, and
alsa-firmware. I didn't really know what to do with alsa-tools and it
doesn't seem to matter.

BTW, I'm still running the  2.6.9-1.681_FC3.i686 kernel.

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
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
