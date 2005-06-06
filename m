From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000151]: Lockup on Envy24ht/ice1724 when recording with some format/rate combos
Date: Mon, 6 Jun 2005 11:00:52 +0200
Message-ID: <5dd96bb9a9499681ffb8018be5d660d6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (unknown [195.113.161.147])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 33C04189
	for <alsa-devel@alsa-project.org>; Mon,  6 Jun 2005 11:00:52 +0200 (MEST)
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


The following issue has been RESOLVED.
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
Status:                     resolved
Distribution:               Slackware 9.1
Kernel Version:             2.6.4
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-23-2004 06:05 CET
Last Modified:              06-06-2005 11:00 CEST
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
 tiwai - 05-24-05 12:29 
----------------------------------------------------------------------
The version reported here is way too old...
Try 1.0.9rc4.

----------------------------------------------------------------------
 perex - 06-06-05 11:00 
----------------------------------------------------------------------
No response from reporter. It might be a system specific PCI bus related
problem.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-23-04 06:05 patricklang    New Issue                                    
03-23-04 06:05 patricklang    Distribution              => Slackware 9.1   
03-23-04 06:05 patricklang    Kernel Version            => 2.6.4           
03-23-04 19:02 perex          Status                   new => assigned     
03-23-04 19:02 perex          Assigned To               => perex           
05-08-05 14:24 ungod          Note Added: 0004609                          
05-24-05 12:29 tiwai          Note Added: 0004719                          
06-06-05 11:00 perex          Status                   assigned => resolved
06-06-05 11:00 perex          Resolution               open => fixed       
06-06-05 11:00 perex          Note Added: 0004902                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
