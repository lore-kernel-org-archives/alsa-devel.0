From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000410]: Cannot listen to line-in and aux at the same time
Date: Tue, 9 Nov 2004 16:43:23 +0100
Message-ID: <23b2cdf77c384edf1670cb06546a0637@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A2F581EF
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:43:23 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=410> 
======================================================================
Reported By:                skamp
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   410
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               LFS 5.1.1, BLFS 5.1
Kernel Version:             2.4.26
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             07-27-2004 18:48 CEST
Last Modified:              11-09-2004 16:43 CET
======================================================================
Summary:                    Cannot listen to line-in and aux at the same time
Description: 
I cannot listen to sound coming from line-in and aux at the same time,
since I have to switch between either one of them with the "capture"
switch.
I can't listen to both line-in or aux and pcm, for that matter, since I
have to switch H/W and H/W 1 from PCM Out to H/W In 0 and vice versa.

I have my TV plugged to line-in, and my DXR3 MPEG2 decoder plugged to aux,
and I found it convenient with my former sound card (Sound Blaster Live!
with OSS drivers) to be able to listen to either source (TV, DVD or PCM)
without unplugging my headphones or triggering any switch.
======================================================================

----------------------------------------------------------------------
 skamp - 10-01-04 17:55 
----------------------------------------------------------------------
Nah, actually I'm up very late ;-)
The alteration to /etc/asound.conf (not alsa.conf) works, thanks!

----------------------------------------------------------------------
 tiwai - 10-06-04 12:20 
----------------------------------------------------------------------
Thanks Peter, I committed your patch to CVS.

Closing this bug now...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-27-04 18:48 skamp          New Issue                                    
07-27-04 18:48 skamp          File Added: aadebug                          
07-27-04 18:48 skamp          Distribution              => LFS 5.1.1, BLFS 5.1
07-27-04 18:48 skamp          Kernel Version            => 2.4.26          
07-30-04 16:51 tiwai          Note Added: 0001491                          
08-01-04 14:29 skamp          Note Added: 0001515                          
08-01-04 18:00 skamp          Note Added: 0001516                          
08-02-04 18:21 tiwai          Note Added: 0001523                          
09-28-04 22:37 ungod          Note Added: 0001958                          
09-28-04 23:15 tiwai          Status                   new => resolved     
09-28-04 23:15 tiwai          Resolution               open => fixed       
09-28-04 23:15 tiwai          Assigned To               => tiwai           
09-28-04 23:15 tiwai          Note Added: 0001959                          
09-29-04 02:14 skamp          Status                   resolved => feedback
09-29-04 02:14 skamp          Resolution               fixed => reopened   
09-29-04 02:14 skamp          Note Added: 0001963                          
09-29-04 02:15 skamp          Issue Monitored: skamp                       
09-29-04 04:33 ungod          Note Added: 0001964                          
09-29-04 05:05 ungod          Note Added: 0001965                          
09-29-04 05:05 ungod          File Added: aureon-ac97mute.diff                  
 
09-29-04 05:45 skamp          File Added: aadebug                          
09-29-04 05:47 skamp          Note Added: 0001967                          
09-29-04 07:05 ungod          Note Added: 0001968                          
09-29-04 07:20 skamp          Note Added: 0001969                          
09-29-04 07:39 ungod          Note Added: 0001970                          
09-29-04 07:40 ungod          Note Edited: 0001970                         
09-29-04 17:56 tiwai          Note Added: 0001973                          
09-30-04 05:00 skamp          Note Added: 0001981                          
09-30-04 07:55 ungod          Note Added: 0001982                          
09-30-04 09:18 skamp          Note Added: 0001983                          
09-30-04 16:00 ungod          Note Added: 0001984                          
09-30-04 22:31 ungod          File Added: aureon-vout.diff                    
09-30-04 22:37 ungod          Note Added: 0001986                          
09-30-04 22:40 ungod          Note Added: 0001987                          
10-01-04 01:28 ungod          Note Added: 0001992                          
10-01-04 01:42 ungod          Note Added: 0001993                          
10-01-04 01:43 ungod          Note Edited: 0001993                         
10-01-04 01:55 ungod          Note Added: 0001994                          
10-01-04 01:55 ungod          File Added: aureon-init.diff                    
10-01-04 09:15 skamp          Note Added: 0001995                          
10-01-04 15:40 ungod          Note Added: 0001999                          
10-01-04 17:55 skamp          Note Added: 0002003                          
10-06-04 12:20 tiwai          Status                   feedback => resolved
10-06-04 12:20 tiwai          Resolution               reopened => fixed   
10-06-04 12:20 tiwai          Note Added: 0002024                          
11-09-04 16:43 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
