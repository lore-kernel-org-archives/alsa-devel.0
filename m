From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002243]: TerraTec Aureon 7.1 Universe
	sound cracks at startup and after each played sound file
Date: Thu, 29 Jun 2006 19:04:01 +0200
Message-ID: <b878a26d8d8f62482a03b4b4f111188c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5784A29D
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jun 2006 19:04:01 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2243> 
======================================================================
Reported By:                calestyo
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2243
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian GNU/Linux
Kernel Version:             2.6.17
======================================================================
Date Submitted:             06-29-2006 01:31 CEST
Last Modified:              06-29-2006 19:04 CEST
======================================================================
Summary:                    TerraTec Aureon 7.1 Universe sound cracks at startup
and after each played sound file
Description: 
At startup (exactly when the kernel loads ALSA and the soundcard drivers
which I have statically compiled into the kernel) and - more seriously -
after
nearly every audio file that I play I hear cracks...
For all applications (GNOME/esd like gaim or xine which directly uses
ALSA) this
is at the end of the sound file. But when using mplayer it is shortly
before the
end,.. then it cracks and then the remaining sound is played.


This doesn't happen when playing the same files under Windows using the
original TerraTec drivers!!!
======================================================================

----------------------------------------------------------------------
 tiwai - 06-29-06 17:53 
----------------------------------------------------------------------
Change "Multi Track Internal Clock" to 48000 on alsamixer (during no
playback program is running).

----------------------------------------------------------------------
 calestyo - 06-29-06 19:04 
----------------------------------------------------------------------
It seems that changing this is not stored. When I shut down gnome log in
via console and use alsa mixer to change that to 48kHz,.. then I restart
gnome and gnome-volume-control says that is 44,1kHz again... The only
thing that helps is setting Multi Track Rate Locking,.. then it remains by
48000 but all sounds are played much to fast... AND it seems that it does
not resolve the cracking problem at all.

Anyway,.. even if it would have worked with 48kHz,.. isn't the card
supposed to work with all the given rates?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-29-06 01:31 calestyo       New Issue                                    
06-29-06 01:31 calestyo       Distribution              => Debian GNU/Linux
06-29-06 01:31 calestyo       Kernel Version            => 2.6.17          
06-29-06 01:31 calestyo       Issue Monitored: calestyo                    
06-29-06 01:35 calestyo       Note Added: 0010633                          
06-29-06 17:53 tiwai          Note Added: 0010678                          
06-29-06 19:04 calestyo       Note Added: 0010694                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
