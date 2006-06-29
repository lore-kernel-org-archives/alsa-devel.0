From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002144]: Devices hw:0, 0 and hw:0,
	4 do not play the same output (anymore?)
Date: Thu, 29 Jun 2006 16:29:34 +0200
Message-ID: <d6f382a40431dba8c38fc661623b1a80@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 17E2F23D
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jun 2006 16:29:35 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2144> 
======================================================================
Reported By:                prodiger
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2144
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Debian unstable
Kernel Version:             2.6.19
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-22-2006 20:41 CEST
Last Modified:              06-29-2006 16:29 CEST
======================================================================
Summary:                    Devices hw:0,0 and hw:0,4 do not play the same
output (anymore?)
Description: 
I'm desperately trying to do the following thing on my laptop: While at
home I use the S/PDIF over an optical wire while anywhere else I have to
use either the built-in speakers or headphones. It should be just like
that: Unplugging the optical wire should activate the built-in speakers.
This works very well under Windows and was working with an earlier version
of ALSA (i guess 1.10, but not sure about this).
I am able to play to different things on both devices simultaneously, e.g.
I open XMMS twice, the first plays on hw:0,0 the other one on
hw:0,4...works perfectly. But is there ANY way to always play the same
things over both devices? Any way to do so in /etc/asound.conf? I tried
really EVERY combination with capturing with alsamixer, there is no
working configuration.
And as I said, i think this was working with earlier versions of ALSA,
maybe this is a bug?
======================================================================

----------------------------------------------------------------------
 prodiger - 06-29-06 10:05 
----------------------------------------------------------------------
This bug can be closed. The behavior described above can be achieved by
simply setting IEC958 Playback AC97-SPSA in alsamixer to zero. I probably
had this setting set to zero when installing alsa for the first time and
thus everything was working well.

----------------------------------------------------------------------
 tiwai - 06-29-06 16:29 
----------------------------------------------------------------------
OK, let's close it.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-22-06 20:41 prodiger       New Issue                                    
05-22-06 20:41 prodiger       Distribution              => Debian unstable 
05-22-06 20:41 prodiger       Kernel Version            => 2.6.19          
05-22-06 21:35 rlrevell       Note Added: 0009919                          
05-23-06 11:46 prodiger       Note Added: 0009931                          
05-23-06 11:51 prodiger       Note Edited: 0009931                         
06-29-06 10:05 prodiger       Note Added: 0010646                          
06-29-06 16:29 tiwai          Status                   new => resolved     
06-29-06 16:29 tiwai          Resolution               open => fixed       
06-29-06 16:29 tiwai          Assigned To               => tiwai           
06-29-06 16:29 tiwai          Note Added: 0010660                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
