From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001517]: No sound on hda-intel on Acer TravelMate 4061NLMi
Date: Fri, 6 Jan 2006 17:22:58 +0100
Message-ID: <3c84ecc5b2ca40fd5ab5dd3d26d0c924@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 18450140
	for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2006 17:22:59 +0100 (MET)
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
Last Modified:              01-06-2006 17:22 CET
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
 er-ku - 12-26-05 17:07 
----------------------------------------------------------------------
I forgot to mention one thing that might be important. That's a part of
"dmidecode" output:
Handle 0x000D
        DMI type 10, 6 bytes.
        On Board Device Information
                Type: Sound
                Status: Disabled
                Description: ADI

Notice: the Status says "Disabled". And the problem is that there are no
relevant configuration entries in BIOS... However, snd-hda-intel doesn't
complain about missing devices. 

Could this be the root cause of sound problems?



----------------------------------------------------------------------
 morigane - 01-06-06 17:22 
----------------------------------------------------------------------
I've exactly the same problem on an Acer Aspire 1641 (laptop) with sound
card Intel (chipset Realtek ALC260). I'm on a Mandriva 2006. I've made a
bugtrack to Mandriva, who gave me the latest developer versions kernels
(2.6.12-15 (containing an hda patch) and 2.6.15), with no result. I've
tried the Realtek drivers for linux (which had totally damaged the audio
config and obliged me to reinstall the system), and the alsa drivers
1.0.10 and 1.0.11rc2. I've still no sound. The dmidecode give me the same
result : Status Disabled.
Morigane

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
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
