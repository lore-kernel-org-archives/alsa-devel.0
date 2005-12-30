From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000856]: Surround sound only in the two front channels; no CD play
Date: Fri, 30 Dec 2005 23:22:01 +0100
Message-ID: <a5733b4303a6ac6d3b2ed139d8f3f1a2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 71335148
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 23:22:01 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=856> 
======================================================================
Reported By:                mab
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   856
Category:                   PCI - azx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Fedora Core 3
Kernel Version:             2.6.10-1.741_FC3smp
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             01-28-2005 15:03 CET
Last Modified:              12-30-2005 23:22 CET
======================================================================
Summary:                    Surround sound only in the two front channels; no CD
play
Description: 

In 5.1 mode only front speakers works

I can't reproduce CDs with any desktop applications

alsamixer is unmutted, ch=6, only slilders in PCM and PC SPEAKERS (see
screenshot) 

aplay alsa.wav (two channels wave file), works in  6 speakers
xmms alsa.wav the same

xmms chokes (could' open audio) when a surround 5.1 wave file
(chain-id.wav)

% aplay chain-id.wav                  <<<<< only front speakers works
with the following message:
Playing WAVE '/root/Desktop/Surround-SDL-testfiles/chan-id.wav' : Signed
16 bit Little Endian, Rate 44100 Hz, Channels 6

in speaker-test only front spekeakers works

In Windows XP  everything works fine. 

======================================================================

----------------------------------------------------------------------
 jdthood - 09-15-05 16:16 
----------------------------------------------------------------------
Submitter: Do you still have this problem?

----------------------------------------------------------------------
 rlrevell - 12-30-05 23:22 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-28-05 15:03 mab            New Issue                                    
01-28-05 15:03 mab            File Added: alsamixer.png                    
01-28-05 15:03 mab            Distribution              => Fedora Core 3   
01-28-05 15:03 mab            Kernel Version            => 2.6.10-1.741_FC3smp
02-06-05 21:22 mab            Issue Monitored: mab                         
04-17-05 23:38 maranik        Issue Monitored: maranik                     
09-15-05 16:16 jdthood        Note Added: 0006215                          
12-30-05 23:22 rlrevell       Status                   new => closed       
12-30-05 23:22 rlrevell       Note Added: 0007285                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
