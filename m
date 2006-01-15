From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001627]: snd-hda-intel no suitable model
Date: Sun, 15 Jan 2006 19:59:23 +0100
Message-ID: <74e88b6db7c52457d76b02ed3a016f7a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CC5B0127
	for <alsa-devel@alsa-project.org>; Sun, 15 Jan 2006 19:59:26 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1627> 
======================================================================
Reported By:                Elfe
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1627
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             12-07-2005 21:00 CET
Last Modified:              01-15-2006 19:59 CET
======================================================================
Summary:                    snd-hda-intel no suitable model
Description: 
Hi,

I can't find a suitable model for the ALC880 on my Fujitsi Siemens Amilo
1439G.
The following devices are present:
- internal speakers (possibly emulating pc beep)
- internal mic
- one jack for mic/line-in
- one jack for Headset/IEC958
- volume control wheel

status:
- volume control wheel does not work at all
- Headset jack disables internal speakers
- Headset and internal Speakers have a different output control :( (or no
master volume)
- Internal Mic gets disabled when external mic is plugged in
- Mic works with a lot of try and error

the best config would be:
- volume wheel working
- the control for internal speakers and headphone combined into one or
both and a master volume
- correct recording device and volume selection
- microphone boost setting if available

======================================================================

----------------------------------------------------------------------
 tuxlover - 01-15-06 19:55 
----------------------------------------------------------------------
how can I use the information in the part " additional information.

I've a Amilo M1437G. The sound is acceptable. The sound output downside
the notebook doesn't funktion anyway (is not the main problem). The bigger
problem is the mic. The mic is one of the most important think for me. I
looking for a way to make the mic funktion.

Thans for your help

tuxlover

----------------------------------------------------------------------
 rlrevell - 01-15-06 19:59 
----------------------------------------------------------------------
What exactly is the problem with the mic, the original report said "the mic
works with lots of trial and error".

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-07-05 21:00 Elfe           New Issue                                    
12-08-05 17:26 tiwai          Note Added: 0006960                          
01-15-06 19:55 tuxlover       Note Added: 0007668                          
01-15-06 19:59 rlrevell       Note Added: 0007669                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
