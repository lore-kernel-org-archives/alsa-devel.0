From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001162]: no sound on speakers, low volume on the headphones
Date: Sat, 23 Jul 2005 16:09:45 +0200
Message-ID: <70304f914b2be9eeb6bed38c4c708aae@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7655C186
	for <alsa-devel@alsa-project.org>; Sat, 23 Jul 2005 16:09:45 +0200 (MEST)
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
Last Modified:              07-23-2005 16:09 CEST
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
 vitja - 07-22-05 23:46 
----------------------------------------------------------------------
I have one idea. When I load pcspkr instead of snd-atiixp driver. Pcspeaker
works just fine on dynamics & phones. After loading ixp driver I don't
hear it anymore(only in phones) so I guess some inital settings of device
are correct.. May be I should to take dump of ixp & ac97's registers to
understand what is going on?.. My attempts to do this wasn't successful I
get core dump after loading module. Is there a way to do this?

----------------------------------------------------------------------
 vitja - 07-23-05 16:09 
----------------------------------------------------------------------
Uploaded files dmesg+desc & after contain register dumps before(actually in
time) and after snd-atiixp driver loading...

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
06-08-05 16:43 tiwai          Note Added: 0004957                          
06-08-05 16:45 pzad           Note Added: 0004958                          
06-08-05 16:52 Gildoniel      Note Added: 0004959                          
06-08-05 16:57 pzad           Note Added: 0004960                          
06-08-05 17:03 tiwai          Note Added: 0004961                          
06-08-05 17:13 Gildoniel      Note Added: 0004963                          
06-08-05 17:31 Gildoniel      Note Added: 0004964                          
06-08-05 17:35 tiwai          Note Added: 0004965                          
06-08-05 18:03 Gildoniel      Note Added: 0004967                          
06-08-05 18:39 Gildoniel      Note Added: 0004970                          
06-17-05 11:54 Gildoniel      Note Added: 0005068                          
06-17-05 14:20 tiwai          Note Added: 0005069                          
06-20-05 23:31 Gildoniel      Note Added: 0005098                          
06-21-05 11:20 tiwai          Note Added: 0005103                          
07-22-05 10:57 vitja          Note Added: 0005547                          
07-22-05 20:59 jcdutton       Note Added: 0005549                          
07-22-05 23:46 vitja          Note Added: 0005550                          
07-23-05 16:07 vitja          File Added: dmesg+desk                       
07-23-05 16:08 vitja          File Added: after                            
07-23-05 16:09 vitja          Note Added: 0005554                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
