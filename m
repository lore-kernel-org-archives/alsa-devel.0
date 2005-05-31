From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000982]: Sound output locked at 48khz (lower freqs play faster, sound higher)
Date: Tue, 31 May 2005 18:03:34 +0200
Message-ID: <9ef3f5591da0fd3bfd0fefab71593da8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 02DAB1CF
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 18:03:34 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=982> 
======================================================================
Reported By:                Minami Manami
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   982
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             03-12-2005 12:19 CET
Last Modified:              05-31-2005 18:03 CEST
======================================================================
Summary:                    Sound output locked at 48khz (lower freqs play
faster, sound higher)
Description: 
Exactly what it says. In Tuxracer @ 22khz sound, it plays very fast and
high pitched. When I switch it to 44khz, it sounds a bit more like normal,
but when compared to another computer, the sound is high and plays
slightly faster. Same with mpg123, mp3blaster, everything audio. Program
detects a 44.1Khz stream (with an mp3 file) but sound comes out at 48000
samples per second.

======================================================================

----------------------------------------------------------------------
 pzad - 03-12-05 12:35 
----------------------------------------------------------------------
I think, this is not alsa problem, because you are not using alsa - you are
using oss driver (via82cxxx is oss driver).

----------------------------------------------------------------------
 perex - 03-12-05 12:51 
----------------------------------------------------------------------
Yes, we cannot solve bugs in OSS code, move to ALSA at first...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-12-05 12:19 Minami Manami  New Issue                                    
03-12-05 12:25 Minami Manami  Note Added: 0003895                          
03-12-05 12:27 Minami Manami  Note Edited: 0003895                         
03-12-05 12:35 pzad           Note Added: 0003896                          
03-12-05 12:49 perex          Project                  ALSA - firmware => ALSA -
driver
03-12-05 12:49 perex          Category                  => PCI - via82xx   
03-12-05 12:51 perex          Status                   new => resolved     
03-12-05 12:51 perex          Resolution               open => not an issue
03-12-05 12:51 perex          Assigned To               => perex           
03-12-05 12:51 perex          Note Added: 0003897                          
03-12-05 12:51 perex          Assigned To              perex =>            
05-31-05 18:03 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
