From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001312]: aplay has endian issues
Date: Fri, 5 Aug 2005 09:30:08 +0200
Message-ID: <58ff2dbdf8627d9f64f185d3ec626616@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 82E3D20B
	for <alsa-devel@alsa-project.org>; Fri,  5 Aug 2005 09:30:08 +0200 (MEST)
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
Last Modified:              08-05-2005 09:30 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-05-05 07:18 ChrisWhite     New Issue                                    
08-05-05 09:30 Clemens LadischNote Added: 0005663                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
