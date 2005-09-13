From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001345]: microphone input does broken after upgrading from kernel 2.6.10 to 2.6.12
Date: Tue, 13 Sep 2005 06:26:15 +0200
Message-ID: <381c3bae7917e6b22d47535bc56d7ac8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5236A1B0
	for <alsa-devel@alsa-project.org>; Tue, 13 Sep 2005 06:26:15 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1345> 
======================================================================
Reported By:                kayosiii
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1345
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Mepis
Kernel Version:             2.6.12 custom compiled
======================================================================
Date Submitted:             08-17-2005 08:13 CEST
Last Modified:              09-13-2005 06:26 CEST
======================================================================
Summary:                    microphone input does broken after upgrading from
kernel 2.6.10 to 2.6.12
Description: 
Basically When a boot using kernel 2.6.10 I can record using a microphone.
With 2.6.12 I get no input... I am running the latest alsa-base in debian
unstable. And have tried just about every setting in kmixer
======================================================================

----------------------------------------------------------------------
 rlrevell - 09-11-05 21:40 
----------------------------------------------------------------------
Your asound.state shows that you have 2 soundcards - an Audigy and an
onboard VIA device.  The Audigy mixer settings look OK but the mic is
muted on the VIA card.  Which one are you trying to get working?

----------------------------------------------------------------------
 kayosiii - 09-13-05 06:26 
----------------------------------------------------------------------
Thats interesting because there is not an audigy or has ever been an audigy
in the system.... I do have another sound card - an emagic AudiowerksII
but that does not even have an alsa driver and I can't imagine it being
mis-detected...

Anyways somehow the endless fiddling turned out fruitfull and after a
reboot everything is working again.

So Thankyou for your time

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-17-05 08:13 kayosiii       New Issue                                    
08-17-05 08:13 kayosiii       Distribution              => Mepis           
08-17-05 08:13 kayosiii       Kernel Version            => 2.6.12 custom
compiled
08-22-05 12:20 perex          Assigned To              perex =>            
08-22-05 12:20 perex          Status                   assigned => new     
08-22-05 12:20 perex          Category                 0_compilation problem_!!!
=> PCI - intel8x0
08-23-05 16:50 tiwai          Note Added: 0005910                          
08-25-05 03:59 kayosiii       Note Added: 0005936                          
09-11-05 07:07 kayosiii       Note Added: 0006138                          
09-11-05 10:35 kayosiii       File Added: asound.state                     
09-11-05 10:38 kayosiii       Note Added: 0006139                          
09-11-05 21:40 rlrevell       Note Added: 0006144                          
09-13-05 06:26 kayosiii       Note Added: 0006151                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
