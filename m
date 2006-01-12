From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001517]: No sound on hda-intel on Acer TravelMate 4061NLMi
Date: Thu, 12 Jan 2006 13:45:30 +0100
Message-ID: <d8c94ec20c304231d6eeac48ec20a8c1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 64B2A159
	for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2006 13:45:31 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1517> 
======================================================================
Reported By:                er-ku
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1517
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu Breezy
Kernel Version:             2.6.12-9-686
======================================================================
Date Submitted:             10-31-2005 00:19 CET
Last Modified:              01-12-2006 13:45 CET
======================================================================
Summary:                    No sound on hda-intel on Acer TravelMate 4061NLMi
Description: 
This will be very much like other reports around.

Just bought a new laptop and installed Ubuntu Linux on it, and updated it.
Sound modules load silently, no complainments, alsamixer works and
channels are unmuted, but I get absolutely no sound from speakers of
headphones.

I'm not the only one having this issue
(http://ubuntuforums.org/showthread.php?p=450628), however, all the info I
managed to google either didn't help me, or was simply unfinished (like
forum questions that aren't answered).

I tried the stock drivers provided by the Ubuntu kernel, then I tried
1.0.10rc2, and cvs builds i made myself (created them as .debs though). In
all cases the result was the same - absolute silence.

======================================================================

----------------------------------------------------------------------
 OnO - 01-07-06 17:19 
----------------------------------------------------------------------
What are You think about?
device 10ec:0260 is listed by DXDiag but not by lspci ?
device 8086:2668 is listed by both.

[DXDiag]
-------------
Sound Devices
-------------
            Description: Realtek HD Audio output
            Hardware ID:
HDAUDIO\FUNC_01&VEN_10EC&DEV_0260&SUBSYS_1025160D&REV_1004
        Manufacturer ID: 1
             Product ID: 100
                   Type: WDM
            Driver Name: RtkHDAud.sys
         Driver Version: 5.10.0000.5148 (English)
      Driver Attributes: Final Retail
...
        Driver Provider: Realtek Semiconductor Corp.
         HW Accel Level: Full
              Cap Flags: 0xF5F
    Min/Max Sample Rate: 100, 192000
Static/Strm HW Mix Bufs: 33, 32
 Static/Strm HW 3D Bufs: 33, 32
              HW Memory: 0
       Voice Management: No
 EAX(tm) 2.0 Listen/Src: Yes, Yes
   I3DL2(tm) Listen/Src: Yes, Yes
Sensaura(tm) ZoomFX(tm): No
               Registry: OK
-------------
     Name: Microsoft UAA Bus Driver for High Definition Audio
Device ID: PCI\VEN_8086&DEV_2668&SUBSYS_008F1025&REV_04\3&B1BFB68&0&D8
   Driver: F:\WINDOWS\system32\DRIVERS\hdaudbus.sys, 5.10.0001.5013
(English), 1/7/2005 17:07:18, 138752 bytes
-------------


[lspci]
-------------
0000:00:00.0 0600: 8086:2590 (rev 03)
0000:00:02.0 0300: 8086:2592 (rev 03)
0000:00:02.1 0380: 8086:2792 (rev 03)
0000:00:1b.0 0403: 8086:2668 (rev 04)
0000:00:1c.0 0604: 8086:2660 (rev 04)
0000:00:1c.1 0604: 8086:2662 (rev 04)
0000:00:1c.2 0604: 8086:2664 (rev 04)
0000:00:1d.0 0c03: 8086:2658 (rev 04)
0000:00:1d.1 0c03: 8086:2659 (rev 04)
0000:00:1d.2 0c03: 8086:265a (rev 04)
0000:00:1d.3 0c03: 8086:265b (rev 04)
0000:00:1d.7 0c03: 8086:265c (rev 04)
0000:00:1e.0 0604: 8086:2448 (rev d4)
0000:00:1f.0 0601: 8086:2641 (rev 04)
0000:00:1f.1 0101: 8086:266f (rev 04)
0000:00:1f.3 0c05: 8086:266a (rev 04)
0000:06:01.0 0607: 104c:ac56
0000:06:04.0 0280: 8086:4220 (rev 05)
0000:06:08.0 0200: 10ec:8139 (rev 10)
-------------

----------------------------------------------------------------------
 er-ku - 01-12-06 13:45 
----------------------------------------------------------------------
Is issue 1618 a dupe of this?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-31-05 00:19 er-ku          New Issue                                    
10-31-05 00:19 er-ku          Distribution              => Ubuntu Breezy   
10-31-05 00:19 er-ku          Kernel Version            => 2.6.12-9-686    
10-31-05 00:21 er-ku          Issue Monitored: er-ku                       
12-19-05 02:28 rlrevell       Note Added: 0007083                          
12-24-05 03:28 OnO            Note Added: 0007139                          
12-24-05 03:32 OnO            Note Added: 0007140                          
12-26-05 17:06 er-ku          Note Added: 0007160                          
12-26-05 17:07 er-ku          Note Edited: 0007160                         
01-04-06 14:59 eudoxos        Issue Monitored: eudoxos                     
01-06-06 17:22 morigane       Note Added: 0007489                          
01-06-06 18:38 er-ku          Note Added: 0007492                          
01-06-06 19:39 rlrevell       Note Added: 0007495                          
01-06-06 19:46 er-ku          Note Added: 0007496                          
01-06-06 19:56 morigane       Note Added: 0007497                          
01-06-06 20:04 eudoxos        Note Added: 0007498                          
01-07-06 17:19 OnO            Note Added: 0007517                          
01-12-06 13:45 er-ku          Note Added: 0007585                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
