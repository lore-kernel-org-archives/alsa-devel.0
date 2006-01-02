From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001172]: speaker-test:option -p and -f ignored
Date: Mon, 2 Jan 2006 20:29:12 +0100
Message-ID: <1c5fcd7194638c7ca6242783f42fdc77@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 36606BB
	for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2006 20:29:12 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1172> 
======================================================================
Reported By:                norbert
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Issue ID:                   1172
Category:                   speakertest
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Resolution:                 reopened
Fixed in Version:           
======================================================================
Date Submitted:             06-08-2005 15:40 CEST
Last Modified:              01-02-2006 20:29 CET
======================================================================
Summary:                    speaker-test:option -p and -f ignored
Description: 
speaker-test: options -p and -f are ignored

> speaker-test -c6 -p100 -f200 -Dsurround51

speaker-test 0.0.8

Playback device is surround51
Stream parameters are 48000Hz, S16_LE, 6 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 6 to 5461
Period size range from 3 to 2730
Periods = 4
Buffer time size 2525
To choose buffer_size = 5460
To choose period_size = 1365
was set period_size = 1365
was set buffer_size = 5460
 0 - Front Left
 4 - Center

(sorry for choosing category aplay, but no speaker-test found)
======================================================================

----------------------------------------------------------------------
 norbert - 06-23-05 13:42 
----------------------------------------------------------------------
due to -f makes sense only if sine-wave, so you can cancel -t at all.

just an idea...

----------------------------------------------------------------------
 rlrevell - 01-02-06 20:29 
----------------------------------------------------------------------
Does not seem to be a bug?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-08-05 15:40 norbert        New Issue                                    
06-08-05 15:47 perex          Category                 aplay/arecord =>
speakertest
06-23-05 12:12 tiwai          Status                   new => resolved     
06-23-05 12:12 tiwai          Resolution               open => not an issue
06-23-05 12:12 tiwai          Assigned To               => tiwai           
06-23-05 12:12 tiwai          Note Added: 0005178                          
06-23-05 12:41 norbert        Status                   resolved => feedback
06-23-05 12:41 norbert        Resolution               not an issue => reopened
06-23-05 12:41 norbert        Note Added: 0005181                          
06-23-05 13:42 norbert        Note Added: 0005185                          
01-02-06 20:29 rlrevell       Status                   feedback => closed  
01-02-06 20:29 rlrevell       Note Added: 0007383                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
