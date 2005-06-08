From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001162]: no sound on speakers, low volume on the headphones
Date: Wed, 8 Jun 2005 16:42:29 +0200
Message-ID: <a628609768629f5cc03b12bd6eece861@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A43331C8
	for <alsa-devel@alsa-project.org>; Wed,  8 Jun 2005 16:42:29 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1162> 
======================================================================
Reported By:                Gildoniel
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1162
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               SuSe Linux 9.3 Professional
Kernel Version:             2.6.11.4.20a
======================================================================
Date Submitted:             06-06-2005 18:54 CEST
Last Modified:              06-08-2005 16:42 CEST
======================================================================
Summary:                    no sound on speakers, low volume on the headphones
Description: 
Problem diagnosis:
 
* Sound card is detected and automatically configured, but no sound can be
heard.
* It is possible to hear _faint_ sound (very low volume) through
headphones.
* Headphone volume is 0 and I can still hear low volume sound (maybe
master/headphone switched?)
* It seems to be possible to record voice on the microphone (I see the
amplitude when talking into the mic)
 
Solution attempts so far:
 
* used alsamixer to turn up and unmute all channels (failed: no sound on
speakers, very low volume on headphones)
* use the "quirk" option of the driver -1 through 7 (failed - no bettering
and error messages with certain settings)
* tried other sounddrivers (intel, via and others - didn't try them all)
(failed - error loading modules on those I tried)
======================================================================

----------------------------------------------------------------------
 tiwai - 06-08-05 16:41 
----------------------------------------------------------------------
Is snd-atiixp-modem driver loaded?  This may conflict with the audio part.

----------------------------------------------------------------------
 pzad - 06-08-05 16:42 
----------------------------------------------------------------------
Sorry. This wasn't mean to you, this was for alsa driver developers.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-06-05 18:54 Gildoniel      New Issue                                    
06-06-05 18:54 Gildoniel      File Added: qta0733a.inf                     
06-06-05 18:54 Gildoniel      Distribution              => SuSe Linux 9.3
Professional
06-06-05 18:54 Gildoniel      Kernel Version            => 2.6.11.4.20a    
06-07-05 17:52 Gildoniel      Note Added: 0004913                          
06-08-05 14:35 tiwai          Note Added: 0004922                          
06-08-05 14:43 Gildoniel      File Added: asound.state                     
06-08-05 14:50 Gildoniel      File Added: proc-asound-card-codec97.txt          
         
06-08-05 14:52 Gildoniel      Note Added: 0004924                          
06-08-05 14:59 Gildoniel      Note Added: 0004927                          
06-08-05 15:08 tiwai          Note Added: 0004929                          
06-08-05 15:29 Gildoniel      Note Added: 0004933                          
06-08-05 15:31 Gildoniel      Note Added: 0004934                          
06-08-05 15:36 pzad           Note Added: 0004935                          
06-08-05 16:13 Gildoniel      Note Added: 0004948                          
06-08-05 16:21 pzad           Note Added: 0004949                          
06-08-05 16:39 Gildoniel      Note Added: 0004954                          
06-08-05 16:41 tiwai          Note Added: 0004955                          
06-08-05 16:42 pzad           Note Added: 0004956                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
