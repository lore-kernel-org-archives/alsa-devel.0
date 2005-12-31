From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001455]: emu10k1: PCM through digital out cuts off after playing AC3
Date: Sat, 31 Dec 2005 03:28:00 +0100
Message-ID: <da23e80c27dc67730be494168ba8a55e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A5B8412B
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2005 03:28:00 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1455> 
======================================================================
Reported By:                eradicator
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1455
Category:                   PCI - emu10k1
Reproducibility:            sometimes
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.6.13
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             09-25-2005 11:45 CEST
Last Modified:              12-31-2005 03:27 CET
======================================================================
Summary:                    emu10k1: PCM through digital out cuts off after
playing AC3
Description: 
I first noticed this back around 1.0.0 and possibly back in the 0.9.x as
well, but I can't quite remember if it ever worked for me.  I've had the
problem on x86 and x86_64 with sblive, sblive5.1, audigy, and audigy2
cards using the livedrive and livedrive2 (both coax and optical digital
out).

The problem is that raw PCM out works sometimes, but not others.  Using
the ac3 passthrough still works when playing a movie through mplayer/xine,
but after the movie finishes, PCM is not output.  The first time I noticed
this, I was able to workaround the broblem by disabling raw pcm output (so
it's definitely not a problem with my sound system), but now neither raw
nor processed will output via coax or optical outs through the livedrive. 
I can still hear the audio fine through the analog out.  Additionally, I
can play AC3 just fine through mplayer or xine.  Rebooting does not
correct the situation.
======================================================================

----------------------------------------------------------------------
 rlrevell - 11-28-05 18:53 
----------------------------------------------------------------------
Make sure "IEC958 Optical Raw" is off (the movie player app is supposed to
disable this when it exits)

----------------------------------------------------------------------
 rlrevell - 12-31-05 03:27 
----------------------------------------------------------------------
Mixer settings

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-25-05 11:45 eradicator     New Issue                                    
09-25-05 11:45 eradicator     Distribution              => Gentoo          
09-25-05 11:45 eradicator     Kernel Version            => 2.6.13          
11-28-05 18:28 msc            Note Added: 0006860                          
11-28-05 18:53 rlrevell       Note Added: 0006865                          
12-31-05 03:27 rlrevell       Status                   new => closed       
12-31-05 03:27 rlrevell       Note Added: 0007326                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
