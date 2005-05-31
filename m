From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000126]: SBLive (Value, 1024) card's external analog inputs are only 2 channel
Date: Tue, 31 May 2005 18:02:16 +0200
Message-ID: <07f5293e12de848c651860de30323560@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6E6D91CF
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 18:02:16 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=126> 
======================================================================
Reported By:                Sipi
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   126
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               Gentoo Linux 1.4
Kernel Version:             2.6.1, 2.6.2, 2.6.3
Resolution:                 suspended
Fixed in Version:           
======================================================================
Date Submitted:             03-09-2004 12:57 CET
Last Modified:              05-31-2005 18:02 CEST
======================================================================
Summary:                    SBLive (Value, 1024) card's external analog inputs
are only 2 channel
Description: 
On my SBLive! 1024 card (with 4.1 loudspeakers), all analog inputs (mic,
line, cd-in) sounds only on the front speakers, not on rear. PCM sounds
(mp3, movie) play fine, even in surround. Alsamixer does nothing with it.
(BTW, it is the same with all 1.x.x alsa-driver.)
======================================================================

----------------------------------------------------------------------
 tiwai - 03-09-04 15:11 
----------------------------------------------------------------------
it's a feature of the current driver.
ac97 input is connected onlt to the front output FX BUS.

the routing can be changed dynamically once when the DSP loader
is finished.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-09-04 12:57 Sipi           New Issue                                    
03-09-04 15:11 tiwai          Status                   new => resolved     
03-09-04 15:11 tiwai          Resolution               open => suspended   
03-09-04 15:11 tiwai          Assigned To               => tiwai           
03-09-04 15:11 tiwai          Note Added: 0000545                          
05-31-05 18:02 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
