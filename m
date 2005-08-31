From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001331]: MSI K8N's SB Live 24 bit, no sound from line-in
Date: Wed, 31 Aug 2005 15:14:06 +0200
Message-ID: <4bb99676b28b90a619b8d7d9ef967527@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5248E1D5
	for <alsa-devel@alsa-project.org>; Wed, 31 Aug 2005 15:14:06 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1331> 
======================================================================
Reported By:                Cimmo
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1331
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   trivial
Priority:                   normal
Status:                     feedback
Distribution:               Fedora Core 4
Kernel Version:             2.6.12-1.1398-x86_64
======================================================================
Date Submitted:             08-13-2005 01:27 CEST
Last Modified:              08-31-2005 15:14 CEST
======================================================================
Summary:                    MSI K8N's SB Live 24 bit, no sound from line-in
Description: 
I have a MSI K8N Platinum motherboard that has a SBLive! 24 bit
integrated.
(Un)fortunatelly this motherboard provide two different jacks for Mic and
Line-In instead of one single jack like the pci version of the sb live 24
bit.

With this card I cannot hear any sound that come from line-in.
For Example I have a tv card, its output audio go into line-in: result is
I cannot hear nothing from the tv, I can only see channels without audio.

The "Capture feedback into playback" in the mixer change the mic's
volume.
There is nothing that change line-in's volume.
======================================================================

----------------------------------------------------------------------
 Cimmo - 08-13-05 18:30 
----------------------------------------------------------------------
There are some problems, none of the 4 lines works, this is what I have
done:

[cimmo@localhost ~]$ arecord -fdat -Dhw:0,0 | aplay
Recording WAVE 'stdout' : Signed 16 bit Little Endian, Rate 48000 Hz,
Stereo
Playing WAVE 'stdin' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
Aborted by signal Interrupt...
Aborted by signal Interrupt...
[cimmo@localhost ~]$ arecord -fdat -Dhw:0,1 | aplay
Recording WAVE 'stdout' : Signed 16 bit Little Endian, Rate 48000 Hz,
Stereo
Playing WAVE 'stdin' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
Aborted by signal Interrupt...
Aborted by signal Interrupt...
[cimmo@localhost ~]$ arecord -fdat -Dhw:0,2 | aplay
Recording WAVE 'stdout' : Signed 16 bit Little Endian, Rate 48000 Hz,
Stereo
Playing WAVE 'stdin' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
arecord: pcm_read:1252: read error: Input/output error
[cimmo@localhost ~]$ arecord -fdat -Dhw:0,3 | aplay
Recording WAVE 'stdout' : Signed 16 bit Little Endian, Rate 48000 Hz,
Stereo
Playing WAVE 'stdin' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
arecord: pcm_read:1252: read error: Input/output error

----------------------------------------------------------------------
 Cimmo - 08-31-05 15:14 
----------------------------------------------------------------------
What I have to do? Waiting for an answer...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-13-05 01:27 Cimmo          New Issue                                    
08-13-05 01:27 Cimmo          Distribution              => Fedora Core 4   
08-13-05 01:27 Cimmo          Kernel Version            => 2.6.12-1.1398-x86_64
08-13-05 01:41 jcdutton       Note Added: 0005798                          
08-13-05 01:42 jcdutton       Status                   assigned => feedback
08-13-05 18:30 Cimmo          Note Added: 0005807                          
08-31-05 15:14 Cimmo          Note Added: 0005989                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
