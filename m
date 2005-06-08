From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001162]: no sound on speakers, low volume on the headphones
Date: Wed, 8 Jun 2005 15:08:54 +0200
Message-ID: <e6977233e4bc89a88c6e35bb51713bbe@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 886501E9
	for <alsa-devel@alsa-project.org>; Wed,  8 Jun 2005 15:08:54 +0200 (MEST)
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
Last Modified:              06-08-2005 15:08 CEST
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
 Gildoniel - 06-08-05 14:59 
----------------------------------------------------------------------
Sorry for my incorrect statement of the "quirk" option in my report -
supposed to be "ac97_quirk" of course.

I've used the "ac97_quirk" - "workaround for uncommon hardware" with
settings -1 to 7. Yast2 gave me 3 options to change:
* ac97_clock
* ac97_quirk (possible values -1 to 7)
* spdif_aclink (possible values 0, 1)

----------------------------------------------------------------------
 tiwai - 06-08-05 15:08 
----------------------------------------------------------------------
Hmm it's an unknown codec.  The mixer state looks OK.
Not as easy as I thought...

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
