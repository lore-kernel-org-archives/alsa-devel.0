From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001331]: MSI K8N's SB Live 24 bit, no sound from line-in
Date: Sat, 10 Sep 2005 10:31:50 +0200
Message-ID: <c352bae8e11c5bc8ce014857e9436f4e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 19A301C8
	for <alsa-devel@alsa-project.org>; Sat, 10 Sep 2005 10:31:51 +0200 (MEST)
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
Last Modified:              09-10-2005 10:31 CEST
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
 rlrevell - 08-31-05 18:59 
----------------------------------------------------------------------
It's clearly a driver bug so all you can do at this point is wait for a
response from the driver developer.

----------------------------------------------------------------------
 jcdutton - 09-10-05 10:31 
----------------------------------------------------------------------
You might have an older version of the kernel driver.
Please post the output of: http://alsa.opensrc.org/TroubleShooting
Do Questions 1,2,3 and 4 and post the output here.

If you find that you do not have the latest alsa-driver, please try to
upgrade to it.

Please note that Line-in has never ever worked for your motherboard based
sound card in Linux, due to lack of enough information to implement it.
So, it is not really a bug, but instead a feature that we don't know how
to implement yet.

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
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
