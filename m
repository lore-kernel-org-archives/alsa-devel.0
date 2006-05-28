From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001627]: snd-hda-intel no suitable
	model
Date: Sun, 28 May 2006 06:14:22 +0200
Message-ID: <3819a8d5c0d8db2f49a1595589068077@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6E92A171
	for <alsa-devel@alsa-project.org>;
	Sun, 28 May 2006 06:14:22 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
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
Last Modified:              05-28-2006 06:14 CEST
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
 rlrevell - 01-23-06 21:22 
----------------------------------------------------------------------
The original bug report is too vague.  Please comment individually on these
problems:

- volume control wheel does not work at all

  It's not implemented yet.

- Headset jack disables internal speakers

  This is usually the behavior users want.

- Headset and internal Speakers have a different output control :( (or no
master volume)

  As tiwai said, the hardware does not have a master volume

- Internal Mic gets disabled when external mic is plugged in

  This also seems correct to me.

- Mic works with a lot of try and error

  Please explain

"the best config would be:
- correct recording device and volume selection"

This is too vague, what do you mean by "correct"?

----------------------------------------------------------------------
 der_sprengmeister - 05-28-06 06:14 
----------------------------------------------------------------------
To rlrevell: Why should he use the fujitsu-model? It's only exist in
ALC260/262. But the FujitsiSiemens AmiloM1439G has an ALC880.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-07-05 21:00 Elfe           New Issue                                    
12-08-05 17:26 tiwai          Note Added: 0006960                          
01-15-06 19:55 tuxlover       Note Added: 0007668                          
01-15-06 19:59 rlrevell       Note Added: 0007669                          
01-15-06 21:55 tuxlover       Note Added: 0007673                          
01-15-06 21:57 rlrevell       Note Added: 0007674                          
01-15-06 21:57 tuxlover       Note Edited: 0007673                         
01-15-06 21:59 rlrevell       Note Added: 0007675                          
01-15-06 22:01 tuxlover       Note Added: 0007676                          
01-15-06 22:07 rlrevell       Note Added: 0007677                          
01-15-06 22:14 tuxlover       Note Added: 0007678                          
01-15-06 22:26 rlrevell       Note Added: 0007679                          
01-23-06 21:05 Alexander LavrinenkoNote Added: 0007763                          
01-23-06 21:22 rlrevell       Note Added: 0007764                          
05-28-06 06:14 der_sprengmeisterNote Added: 0009996                          
======================================================================
