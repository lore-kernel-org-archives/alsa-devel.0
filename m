From: Gerard Janssen <G.Janssen@ITS.TUDelft.NL>
Subject: How to route "spdif" to an FXBUS of emu10k1
Date: Wed, 08 Jan 2003 12:47:17 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <724D1102774@Octopus.et.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailhst2.its.tudelft.nl (mailhst2.its.tudelft.nl [130.161.34.250])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id MAA10320
	for <alsa-devel@alsa-project.org>; Wed, 8 Jan 2003 12:44:01 +0100
Received: from Octopus.et.tudelft.nl (dutetvh.et.tudelft.nl [130.161.40.138])
	by mailhst2.its.tudelft.nl (8.11.6/8.11.6) with ESMTP id h08Bhti02661
	for <alsa-devel@alsa-project.org>; Wed, 8 Jan 2003 12:43:57 +0100 (MET)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

By making slight changes in emufx.c, I could use all four spdif stereo
channels of the sblive! that are present on the audio-ext connector. These
spdif0..3 outputs can be accessed via: EXTOUT_TOSLINK_L,R ;
EXTOUT_HEADPHONE_L,R ; EXTOUT_REAR_L,R and EXTOUT_CENTER,LFE. By re-routing
"spdif", "front", "rear" and "center_lfe" to the respective outputs, four
stereo signals (8 channels) can be simultaneously send to these outputs. 

The "front", "rear" and "center_lfe" signals are alsmost perfectly
synchronized (within a few samples) and the small delays are constant.
However, the signal via "spdif" is not: its delay w.r.t. the other signals
is about 60 samples and changes randomly every time the application is
started. 
The "spdif" signal is taken from GPR(8) and GPR(9) in emufx.c. As far as I
could backtrace these signals come from etram, which probably is the cause
of the random delay.

A solution might be to put the "spdif" also directly in two FXBUS registers
(there are still 6 free FXBUS registers), as is done with the other
signals. However, I don't know how to do this.

I would appreciate any help or suggestions in routing "spdif" to an FXBUS.

Thanks,

Gerard Janssen


********************************************************************** 
Dr.ir. Gerard J.M. Janssen
Delft University of Technology 
Faculty of Information Technology and Systems (ITS) 
Wireless Mobile Communications Group
P.O. Box 5031, 2600 GA Delft, The Netherlands 
Phone +31-15-2786736, Fax +31-15-2781774 
E-mail G.Janssen@ITS.TUDelft.NL 
**********************************************************************




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
