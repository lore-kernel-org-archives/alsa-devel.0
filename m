From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001183]: Details about known bug "Capture doesn't work"
Date: Mon, 26 Sep 2005 10:20:51 +0200
Message-ID: <7356510c8f1e16eb0075a1faac338f60@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BCEA0139
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2005 10:20:51 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1183> 
======================================================================
Reported By:                Jochen
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1183
Category:                   PCI - es1968
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             06-11-2005 20:34 CEST
Last Modified:              09-26-2005 10:20 CEST
======================================================================
Summary:                    Details about known bug "Capture doesn't work"
Description: 
I'm experiencing the problem with es1968 not supporting capture described
in various places. This bug keeps me from using skype: the second it tries
to read from the OSS compatibility device it receives and EINVAL

using the old OSS maestro driver works thou.

apparently this is the known bug "capture doesn't work"

I'd like to ask for a little more information on this bug, and whether
it's possible to contribute here.
======================================================================

----------------------------------------------------------------------
 tiwai - 06-15-05 14:42 
----------------------------------------------------------------------
Compile ALSA drivers with debug option and see the kernel message whether
any relevant message appears.

----------------------------------------------------------------------
 LawrenceG - 09-26-05 10:20 
----------------------------------------------------------------------
I can confirm this behaviour on a Toshiba Satellite 4030cdt laptop. lspci
shows the sound chip as an ESS Technology ES1978 Maestro 2E rev 10.
Playback is working fine but attempts to read from /dev/dsp result in
consistant returned errors on the read call of Invalid Argument. An ioctl
(SNDCTL_DSP_GETISPACE) right before the read shows available 64k of buffer
space, but always returns 0 available bytes and 0 available fragments.
This problem is specific to the es1968 driver as the same application code
runs fine on another sound card (ensoniq) in another pc. Any chance of
getting this fixed? The laptop runs fine with the oss free drivers that
came with rh8... perhaps the recording code can be ported?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-11-05 20:34 Jochen         New Issue                                    
06-13-05 13:07 tiwai          Note Added: 0005007                          
06-13-05 15:53 Jochen         Note Added: 0005011                          
06-15-05 14:42 tiwai          Note Added: 0005028                          
09-26-05 10:04 LawrenceG      Issue Monitored: LawrenceG                    
09-26-05 10:20 LawrenceG      Note Added: 0006390                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
