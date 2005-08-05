From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001312]: aplay has endian issues
Date: Fri, 5 Aug 2005 18:08:28 +0200
Message-ID: <9a811432ca7a4127aa6cb30acdcd916d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1DBEF205
	for <alsa-devel@alsa-project.org>; Fri,  5 Aug 2005 18:08:29 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1312> 
======================================================================
Reported By:                ChrisWhite
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1312
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             08-05-2005 07:18 CEST
Last Modified:              08-05-2005 18:08 CEST
======================================================================
Summary:                    aplay has endian issues
Description: 
It appears that play uses BE specific formating when playing back by
default.  As alsa seems to have a default SND_PCM_FORMAT_S16 which
switches to the correct native endian, I'm not sure why that's not used as
the default instead of endian specific definitions.
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 08-05-05 09:30 
----------------------------------------------------------------------
aplay uses the sample format of the file it's playing.

What type of file are you using?  And what kind of sound card on what
computer architecture?

----------------------------------------------------------------------
 ChrisWhite - 08-05-05 18:08 
----------------------------------------------------------------------
See, that's the problem, using the sample format of the audio file isn't
going to work.  For exmample, the file I'm playing is 44100 Hz, 2 channel,
s16 big endian 320.0kbit format.  However, I'm on a little endian ppc
system with a via82xx sound card.  It's going to use big endian and I'm
going to get static as the usual result.  AFAIK there's a native endian
hardware format flag that can be sent to overcome this (SND_PCM_FORMAT_S16
I think I mentioned).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-05-05 07:18 ChrisWhite     New Issue                                    
08-05-05 09:30 Clemens LadischNote Added: 0005663                          
08-05-05 18:08 ChrisWhite     Note Added: 0005669                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
