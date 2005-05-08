From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000151]: Lockup on Envy24ht/ice1724 when recording with some format/rate combos
Date: Sun, 8 May 2005 14:24:15 +0200
Message-ID: <37305ef7fba1a10d353cf233a96bfe59@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A420D278
	for <alsa-devel@alsa-project.org>; Sun,  8 May 2005 14:24:15 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=151> 
======================================================================
Reported By:                patricklang
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   151
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               Slackware 9.1
Kernel Version:             2.6.4
======================================================================
Date Submitted:             03-23-2004 06:05 CET
Last Modified:              05-08-2005 14:24 CEST
======================================================================
Summary:                    Lockup on Envy24ht/ice1724 when recording with some
format/rate combos
Description: 
arecord -f S32_LE -r 48000 -c 2 file.wav
(also other rates like 96000)
records just fine, but crashes after a while.  S16_LE/44100 and S32_LE
lock or crash (with stack trace) almost immediately.  S32_LE/48k and
S32_LE/96k seem stable (at least for the 20-30 seconds I recorded)

======================================================================

----------------------------------------------------------------------
 ungod - 05-08-05 14:24 
----------------------------------------------------------------------
I can't force the driver to crash no matter what I do

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-23-04 06:05 patricklang    New Issue                                    
03-23-04 06:05 patricklang    Distribution              => Slackware 9.1   
03-23-04 06:05 patricklang    Kernel Version            => 2.6.4           
03-23-04 19:02 perex          Status                   new => assigned     
03-23-04 19:02 perex          Assigned To               => perex           
05-08-05 14:24 ungod          Note Added: 0004609                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
