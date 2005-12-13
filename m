From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001331]: MSI K8N's SB Live 24 bit, no sound from line-in
Date: Tue, 13 Dec 2005 13:34:19 +0100
Message-ID: <9d3b0e2ebce3447721c5400c1885f391@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E1E431C8
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2005 13:34:19 +0100 (MET)
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
Last Modified:              12-13-2005 13:34 CET
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
 jcdutton - 12-13-05 13:16 
----------------------------------------------------------------------
Ok, so now the mic in works, but line in does not.
The only way to fix this is if I get a hardware sample.
The connections of the mic and line in are hardware specific and different
from all other SB Live 24bit cards.
You could try and get MSI to send me a hardware sample if you wish to fix
this.

----------------------------------------------------------------------
 Cimmo - 12-13-05 13:34 
----------------------------------------------------------------------
Of course send to you a sample means that I have to pay for this and can't
do this :)
The only thing I can do is to give and ssh login to my pc to try via
remote, it can help you?

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
08-31-05 18:59 rlrevell       Note Added: 0005991                          
09-10-05 10:31 jcdutton       Note Added: 0006107                          
10-19-05 19:13 Cimmo          Note Added: 0006496                          
11-07-05 00:02 jcdutton       Note Added: 0006610                          
11-07-05 11:07 Cimmo          Note Added: 0006612                          
11-11-05 19:33 Cimmo          Note Added: 0006678                          
12-13-05 13:16 jcdutton       Note Added: 0007007                          
12-13-05 13:34 Cimmo          Note Added: 0007015                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
