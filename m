From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002202]: model is not autodetected
	correctly
Date: Mon, 26 Jun 2006 17:19:43 +0200
Message-ID: <c2a27e503e9ada4f1856bdce621cf761@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1836B24F
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jun 2006 17:19:44 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2202> 
======================================================================
Reported By:                el
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2202
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Kubuntu Dapper
Kernel Version:             2.6.15-23
======================================================================
Date Submitted:             06-12-2006 09:45 CEST
Last Modified:              06-26-2006 17:19 CEST
======================================================================
Summary:                    model is not autodetected correctly
Description: 
I am using a Fujitsu-Siemens Amilo M3438G (Datasheet here:
http://www.fujitsu-siemens.com/Resources/59/562938810.pdf )

When I load the module via modprobe snd-hda-intel I get the following
controls in alsamixer: 
playback: PCM, Headphones, Internal Speaker, CD, Mic
capture: 3x Capture
I can not get the Microphone to work, no matter what I select as Input
Source for the Capture channels.

When I use modprobe snd-hda-intel model=auto I get
playback: PCM, front(controls headphones), side(controls internal
speaker), center, lfe, internal mic, mic, ...
capture: 3x Capture
The Microphone (Internal, or external if connected) works when I unmute
the first capture channel and set its input source to Front Mic.
Sometimes the center channel controls the speaker at the bottom of the
laptop, sometimes it doesnt, seems kind of random.

Documentation states, that model=auto is the default, but as you can see
it is not
======================================================================

----------------------------------------------------------------------
 tiwai - 06-26-06 16:02 
----------------------------------------------------------------------
/proc/asound/card0/codec#* files and the file created via "alsactl -f
somefile store".

First of all, try different model options for the mathing codec chip as
described in ALSA-Configuration.txt.

----------------------------------------------------------------------
 rlrevell - 06-26-06 17:19 
----------------------------------------------------------------------
Why are your "Capture" levels all set to 0?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-12-06 09:45 el             New Issue                                    
06-12-06 09:45 el             Distribution              => Kubuntu Dapper  
06-12-06 09:45 el             Kernel Version            => 2.6.15-23       
06-14-06 17:20 el             Note Added: 0010215                          
06-26-06 11:37 el             Note Added: 0010526                          
06-26-06 16:02 tiwai          Note Added: 0010539                          
06-26-06 17:19 rlrevell       Note Added: 0010550                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
