From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002144]: Devices hw:0,0 and hw:0,4 do not play the same output (anymore?)
Date: Tue, 23 May 2006 11:46:55 +0200
Message-ID: <0c3be183ceca07e075a459d39478b0e7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BB1D4164
	for <alsa-devel@alsa-project.org>; Tue, 23 May 2006 11:46:55 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2144> 
======================================================================
Reported By:                prodiger
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2144
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian unstable
Kernel Version:             2.6.19
======================================================================
Date Submitted:             05-22-2006 20:41 CEST
Last Modified:              05-23-2006 11:46 CEST
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
 rlrevell - 05-22-06 21:35 
----------------------------------------------------------------------
Are you sure this used to work?  Is it possible to verify it by booting a
live CD with an old ALSA version?

----------------------------------------------------------------------
 prodiger - 05-23-06 11:46 
----------------------------------------------------------------------
No, I am not sure. I just installed a 2.6.14 kernel again and used the
built-in ALSA driver. I couldn't reproduce it anymore. I even installed
the old 1.0.10 from alsa-project.org drivers but it didn't work either. So
maybe I'm wrong, maybe it never used to work. Either way, it SHOULD work i
think. Sound output to both devices simultaneously is working already so
I'd carefully say (i really have no idea how alsa works, unfortunately) it
should be easy to just copy the output stream from hw:0,4 to hw:0,0 (maybe
there is a way in /etc/asound.conf?) As I'm using this driver on a laptop
and have only one (physical) output for digital/analog signal there is no
point in having to independent devices anyway.

Also, there is also no way of controlling the volume of the digital output
with alsamixer. There's simply no device listed there that affects it.

In the end i think this bug report should probably turned into a wishlist
report although I think, the behaviour described above is quite important
and standard.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-22-06 20:41 prodiger       New Issue                                    
05-22-06 20:41 prodiger       Distribution              => Debian unstable 
05-22-06 20:41 prodiger       Kernel Version            => 2.6.19          
05-22-06 21:35 rlrevell       Note Added: 0009919                          
05-23-06 11:46 prodiger       Note Added: 0009931                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
