From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001053]: cannot change line-in volume on MSI K8N Platinum that has SBLive! 24 bit
Date: Sat, 14 May 2005 15:48:05 +0200
Message-ID: <52b918583b697e55e2931fe374d9f3c9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6C61F2BA
	for <alsa-devel@alsa-project.org>; Sat, 14 May 2005 15:48:05 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1053> 
======================================================================
Reported By:                Cimmo
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1053
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     acknowledged
Distribution:               Fedora Core 4 test 2
Kernel Version:             2.6.11-1.1236 FC4-x86_64 that contains 2.6.12rc2
======================================================================
Date Submitted:             04-14-2005 19:27 CEST
Last Modified:              05-14-2005 15:48 CEST
======================================================================
Summary:                    cannot change line-in volume on MSI K8N Platinum
that has SBLive! 24 bit
Description: 
I have a MSI K8N Platinum motherboard that has SBLive! 24 bit integrated.
(Un)fortunatelly this motherboard provide two different jacks for Mic and
Line-In instead of one single jack in the pci version of the sb live 24
bit (see image).

The result is that I cannot use line-in for my soundcard becuase the
volume is 0 and I cannot change it.

The "Capture feedback into playback" in the mixer change the mic's volume.
======================================================================

----------------------------------------------------------------------
 pelias - 05-14-05 13:14 
----------------------------------------------------------------------
jcdutton,

I own an MSI with CA0106, too. Are you planning to arrange the capturing
capabilities of this SB, or should we worry about buying another audio
board?

Thanks

----------------------------------------------------------------------
 jcdutton - 05-14-05 15:48 
----------------------------------------------------------------------
There are no plans to support any capture features in the ca0106 driver
currently due to lack of datasheets.
This is also noted on the sound card matrix.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-14-05 19:27 Cimmo          New Issue                                    
04-14-05 19:27 Cimmo          File Added: MSIK8N.jpg                       
04-14-05 19:27 Cimmo          Distribution              => Fedora Core 4 test 2
04-14-05 19:27 Cimmo          Kernel Version            => 2.6.11-1.1236
FC4-x86_64 that contains 2.6.12rc2
04-14-05 21:42 jcdutton       Note Added: 0004495                          
04-14-05 21:42 jcdutton       Status                   assigned => acknowledged
05-11-05 15:05 Cimmo          Note Added: 0004636                          
05-14-05 13:14 pelias         Note Added: 0004657                          
05-14-05 15:48 jcdutton       Note Added: 0004659                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
