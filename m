From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001053]: cannot change line-in volume on MSI K8N Platinum that has SBLive! 24 bit
Date: Fri, 20 May 2005 00:14:41 +0200
Message-ID: <3730a6b3a87d82e6c8c2ed9fed04516c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 31D57225
	for <alsa-devel@alsa-project.org>; Fri, 20 May 2005 00:14:41 +0200 (MEST)
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
Last Modified:              05-20-2005 00:14 CEST
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
 jcdutton - 05-14-05 15:48 
----------------------------------------------------------------------
There are no plans to support any capture features in the ca0106 driver
currently due to lack of datasheets.
This is also noted on the sound card matrix.

----------------------------------------------------------------------
 dwh - 05-20-05 00:14 
----------------------------------------------------------------------
You don't have datasheets for the EMU10Kx, right?

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
05-20-05 00:14 dwh            Note Added: 0004697                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
