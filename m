From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000856]: Surround sound only in the two front channels; no CD play
Date: Fri, 28 Jan 2005 15:03:04 +0100
Message-ID: <05baad5da25f50d5f073d83d6d95e51f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3129322A
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2005 15:03:05 +0100 (MET)
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


The following issue has been SUBMITTED.
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
Last Modified:              01-28-2005 15:03 CET
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-28-05 15:03 mab            New Issue                                    
01-28-05 15:03 mab            File Added: alsamixer.png                    
01-28-05 15:03 mab            Distribution              => Fedora Core 3   
01-28-05 15:03 mab            Kernel Version            => 2.6.10-1.741_FC3smp
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
