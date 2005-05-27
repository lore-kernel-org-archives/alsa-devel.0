From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000557]: SNDCTL_DSP_GETOPTR not working correctly in specific situation
Date: Fri, 27 May 2005 15:41:04 +0200
Message-ID: <60c456b2817c0e2ae16753162d5c70ab@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 275C320F
	for <alsa-devel@alsa-project.org>; Fri, 27 May 2005 15:41:05 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=557> 
======================================================================
Reported By:                minmax
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   557
Category:                   CORE OSS - pcm
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian unstable
Kernel Version:             vanilla 2.6.7
======================================================================
Date Submitted:             10-01-2004 16:18 CEST
Last Modified:              05-27-2005 15:41 CEST
======================================================================
Summary:                    SNDCTL_DSP_GETOPTR not working correctly in specific
situation
Description: 
When the first few writes to the oss emulation device are done in specific
way, SNDCTL_DSP_GETOPTR returns wrongly huge results in info.bytes
======================================================================

----------------------------------------------------------------------
 perex - 05-27-05 11:04 
----------------------------------------------------------------------
Ok, attached fix2.patch might fix this issue properly. Could you test it?

----------------------------------------------------------------------
 parente - 05-27-05 15:41 
----------------------------------------------------------------------
perex: The fix2.patch does not work on my system. It compiles, but refuses
to be inserted into the kernel with a "symbol error." (Probably because
int64 isn't recognized on my system?)

I also tried just casting to regular "int" but that does not solve the
problem. Output from gnome-speech is still clipped.

What about the patch submitted by Roger Mach? I can compile and install
it, and it appears to correct the problem without introducing others.
Maybe the last expression computes the number of bytes properly using the
number of frames?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-01-04 16:18 minmax         New Issue                                    
10-01-04 16:18 minmax         Distribution              => Debian unstable 
10-01-04 16:18 minmax         Kernel Version            => vanilla 2.6.7   
10-02-04 10:52 minmax         Issue Monitored: minmax                      
04-09-05 16:09 jdthood        Note Added: 0004406                          
04-09-05 16:22 minmax         Note Added: 0004410                          
05-13-05 15:20 gk4            Note Added: 0004646                          
05-13-05 15:24 perex          Note Added: 0004647                          
05-13-05 15:26 tiwai          Note Added: 0004648                          
05-13-05 19:35 gk4            Note Added: 0004651                          
05-13-05 19:38 tiwai          Note Added: 0004652                          
05-13-05 19:48 gk4            Note Added: 0004655                          
05-15-05 15:50 tiwai          Note Added: 0004663                          
05-16-05 16:08 gk4            Note Added: 0004676                          
05-19-05 15:28 parente        Note Added: 0004693                          
05-20-05 00:38 minmax         Note Added: 0004698                          
05-26-05 17:27 Roger Mach     Note Added: 0004738                          
05-27-05 10:56 perex          Note Added: 0004742                          
05-27-05 11:03 perex          File Added: fix2.patch                       
05-27-05 11:04 perex          Note Added: 0004743                          
05-27-05 15:41 parente        Note Added: 0004752                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
