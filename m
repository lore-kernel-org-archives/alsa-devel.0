From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001674]: Audigy 2 ZS after suspend no sound line in
Date: Tue, 27 Dec 2005 21:01:13 +0100
Message-ID: <4dbbf8ed07fb1fb96f8b14f8636366e7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EBB63128
	for <alsa-devel@alsa-project.org>; Tue, 27 Dec 2005 21:01:13 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1674> 
======================================================================
Reported By:                andreid1303
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1674
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             12-22-2005 21:41 CET
Last Modified:              12-27-2005 21:01 CET
======================================================================
Summary:                    Audigy 2 ZS after suspend no sound line in
Description: 
Finally I have got sound working after suspend with alsa 1.0.11rc1
installed but only line in is silent. PCM and Mic is OK
======================================================================

----------------------------------------------------------------------
 andreid1303 - 12-27-05 20:49 
----------------------------------------------------------------------
Before susppend:
lxuser@av27866:~> cat /proc/asound/Audigy2/codec97#0/ac97#0-0+regs
0:00 = 6940
0:02 = 0000
0:04 = 8000
0:06 = 801f
0:08 = 0000
0:0a = 001a
0:0c = 801f
0:0e = 805f
0:10 = 0f0f
0:12 = 0909
0:14 = 9f1f
0:16 = 0707
0:18 = 9f1f
0:1a = 0000
0:1c = 0000
0:1e = 0000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 800f
0:28 = 0200
0:2a = 0080
0:2c = 0000
0:2e = 0000
0:30 = 0000
0:32 = 0000
0:34 = 0000
0:36 = 0000
0:38 = 0000
0:3a = 0000
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 0000
0:5e = 0000
0:60 = 0000
0:62 = 0000
0:64 = 0000
0:66 = 0000
0:68 = 0000
0:6a = 0000
0:6c = 00c4
0:6e = 000c
0:70 = 0000
0:72 = 0000
0:74 = 0380
0:76 = 0000
0:78 = 8380
0:7a = 0000
0:7c = 8384
0:7e = 7609

After suspend:
lxuser@av27866:~> cat /proc/asound/Audigy2/codec97#0/ac97#0-0+regs
0:00 = 6940
0:02 = 9f1f
0:04 = 8000
0:06 = 801f
0:08 = 0000
0:0a = 001a
0:0c = 801f
0:0e = 805f
0:10 = 0f0f
0:12 = 0909
0:14 = 9f1f
0:16 = 0707
0:18 = 9f1f
0:1a = 0000
0:1c = 0000
0:1e = 0000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 800f
0:28 = 0200
0:2a = 0080
0:2c = 0000
0:2e = 0000
0:30 = 0000
0:32 = 0000
0:34 = 0000
0:36 = 0000
0:38 = 0000
0:3a = 0000
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 0000
0:5e = 0000
0:60 = 0000
0:62 = 0000
0:64 = 0000
0:66 = 0000
0:68 = 0000
0:6a = 0000
0:6c = 00c4
0:6e = 000c
0:70 = 0000
0:72 = 0000
0:74 = 0380
0:76 = 0000
0:78 = 8380
0:7a = 0000
0:7c = 8384
0:7e = 7609

I see value for 0:02 is only different. Is it helpful? Thanks in advance.

Same behavour for analog CD-in. 
/etc/init.d/alsasound restart restore sound



----------------------------------------------------------------------
 pzad - 12-27-05 21:01 
----------------------------------------------------------------------
It is helpfull.

02 is master volume for ac97 - and this is cause of problem. Output from
ac97 is connected to ADC.
0000 - master volume is set to max -  this is default.
9f1f - this is probably mute.

CD in - this is same problem as Line in, because they are mixed together
in ac97 and digitalized in ADC.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-22-05 21:41 andreid1303    New Issue                                    
12-23-05 20:07 pzad           Note Added: 0007137                          
12-27-05 20:47 andreid1303    Note Added: 0007169                          
12-27-05 20:49 andreid1303    Note Edited: 0007169                         
12-27-05 21:01 pzad           Note Added: 0007170                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
