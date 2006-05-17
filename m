From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001162]: no sound on speakers, low volume on the headphones
Date: Wed, 17 May 2006 17:41:01 +0200
Message-ID: <df6f035b21d7f18c51d46813bb3f67ab@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D7B7719C
	for <alsa-devel@alsa-project.org>; Wed, 17 May 2006 17:41:01 +0200 (MEST)
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


The following issue has been RESOLVED.
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
Status:                     resolved
Distribution:               SuSe Linux 9.3 Professional
Kernel Version:             2.6.11.4.20a
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             06-06-2005 18:54 CEST
Last Modified:              05-17-2006 17:41 CEST
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
 vitja - 07-23-05 16:52 
----------------------------------------------------------------------
Oh my god it worked!!!

----------------------------------------------------------------------
 rlrevell - 05-17-06 17:41 
----------------------------------------------------------------------
User reports problem is solved

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
07-23-05 16:52 vitja          Note Added: 0005555                          
05-17-06 17:41 rlrevell       Status                   assigned => resolved
05-17-06 17:41 rlrevell       Resolution               open => fixed       
05-17-06 17:41 rlrevell       Note Added: 0009855                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
