From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001051]: 'Headphones', 'PCM', 'Master' control names misassigned
Date: Tue, 13 Dec 2005 03:58:57 +0100
Message-ID: <1cb17b28c0981594dc3dceda5ed18183@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5411B1B5
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2005 03:58:58 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1051> 
======================================================================
Reported By:                kayandus
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1051
Category:                   PCI - via82xx
Reproducibility:            N/A
Severity:                   tweak
Priority:                   normal
Status:                     new
Distribution:               Ubuntu
Kernel Version:             2.6.10-5-k7
======================================================================
Date Submitted:             04-13-2005 21:16 CEST
Last Modified:              12-13-2005 03:58 CET
======================================================================
Summary:                    'Headphones', 'PCM', 'Master' control names
misassigned
Description: 
Hello,

I bought a Targa Traveller 811 laptop a couple of months ago with an
onboard 0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 50) audio controller. It
works fine with the via82xx driver, but there's only one minor problem.
Let me explain my problem.

There are 3 major volume controls for me:

Master: Controls the volume of the internal laptop speaker, so when there
is a plug/earphones in my LINE IN, it changes nothing. (!!)
Headphones: Controls volume of the LINE IN, so does nothing when there is
nothing my LINE IN.
PCM: Controls both internal speaker and LINE IN, so volume goes up and
down whether im using the internal speaker or not.

Probably the problem is clear already to you. Most programs control only
Master, so when I have my laptop attached to my stereo, those programs
don't change my volume =(
I hope you guys can fix this, I suggest by making an option to exchange
Master with PCM.

Thanks in advance, Harm te Hennepe
======================================================================

----------------------------------------------------------------------
 Nafallo - 09-16-05 00:16 
----------------------------------------------------------------------
I got a tip on IRC. I added "options snd-via82xx ac97_quirk=hp_only" to the
end of /etc/modprobe.d/alsa-base. It works now! I guess you want to make
this the default for my card? Here is the lspci -vns 00:11.5 info:

0000:00:11.5 0401: 1106:3059 (rev 50)
        Subsystem: 161f:2032
        Flags: medium devsel, IRQ 22
        I/O ports at 1000 [size=256]



----------------------------------------------------------------------
 Nafallo - 12-13-05 03:58 
----------------------------------------------------------------------
What's the status of this bug?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-13-05 21:16 kayandus       New Issue                                    
04-13-05 21:16 kayandus       Distribution              => Ubuntu          
04-13-05 21:16 kayandus       Kernel Version            => 2.6.10-5-k7     
04-13-05 21:20 kayandus       Issue Monitored: kayandus                    
04-19-05 17:46 kayandus       Issue End Monitor: kayandus                    
04-19-05 18:26 tiwai          Note Added: 0004535                          
04-21-05 20:59 kayandus       Note Added: 0004552                          
09-14-05 04:09 Nafallo        Note Added: 0006156                          
09-14-05 04:10 Nafallo        Note Edited: 0006156                         
09-14-05 04:10 Nafallo        Issue Monitored: Nafallo                     
09-14-05 04:11 Nafallo        Note Edited: 0006156                         
09-14-05 15:45 jdthood        Summary                  Master <--> PCM =>
'Headphones', 'PCM', 'Master' control names misassigned
09-14-05 15:45 jdthood        Description Updated                          
09-15-05 16:04 tiwai          Note Added: 0006211                          
09-15-05 22:38 Nafallo        Note Added: 0006225                          
09-15-05 22:41 Nafallo        Note Edited: 0006225                         
09-15-05 23:35 Nafallo        Note Added: 0006228                          
09-15-05 23:52 rlrevell       Note Added: 0006229                          
09-15-05 23:54 Nafallo        Note Added: 0006230                          
09-15-05 23:59 Nafallo        Note Deleted: 0006230                        
09-16-05 00:07 rlrevell       Note Added: 0006232                          
09-16-05 00:16 Nafallo        Note Added: 0006233                          
09-16-05 00:16 Nafallo        Note Edited: 0006233                         
12-13-05 03:58 Nafallo        Note Added: 0006987                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
