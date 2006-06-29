From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002243]: TerraTec Aureon 7.1 Universe
	sound cracks at startup and after each played sound file
Date: Thu, 29 Jun 2006 17:53:38 +0200
Message-ID: <f406ae24efc45638f29af5b3def62976@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E9F48249
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jun 2006 17:53:38 +0200 (MEST)
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
Last Modified:              06-29-2006 17:53 CEST
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
 calestyo - 06-29-06 01:35 
----------------------------------------------------------------------
You might also have a look at my post at alsa-users mailinglist
"(Additional) Soundproblems with my TerraTec Auron 7.1	Universe souncard"
from 2006-06-29 (news://news.gmane.org:119/e7v34p$rut$1@sea.gmane.org).

----------------------------------------------------------------------
 tiwai - 06-29-06 17:53 
----------------------------------------------------------------------
Change "Multi Track Internal Clock" to 48000 on alsamixer (during no
playback program is running).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-29-06 01:31 calestyo       New Issue                                    
06-29-06 01:31 calestyo       Distribution              => Debian GNU/Linux
06-29-06 01:31 calestyo       Kernel Version            => 2.6.17          
06-29-06 01:31 calestyo       Issue Monitored: calestyo                    
06-29-06 01:35 calestyo       Note Added: 0010633                          
06-29-06 17:53 tiwai          Note Added: 0010678                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
