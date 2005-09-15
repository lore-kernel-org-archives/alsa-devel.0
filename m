From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000856]: Surround sound only in the two front channels; no CD play
Date: Thu, 15 Sep 2005 16:16:45 +0200
Message-ID: <183e65cbb7e52898a22c6e0d66aacca0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 87A9D178
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2005 16:16:45 +0200 (MEST)
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
Status:                     new
Distribution:               Fedora Core 3
Kernel Version:             2.6.10-1.741_FC3smp
======================================================================
Date Submitted:             01-28-2005 15:03 CET
Last Modified:              09-15-2005 16:16 CEST
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
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
