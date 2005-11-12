From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001419]: Input/output jacks mixed up
Date: Sat, 12 Nov 2005 10:43:50 +0100
Message-ID: <ae40341689565fd5cb819bce2121d380@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9F2BA194
	for <alsa-devel@alsa-project.org>; Sat, 12 Nov 2005 10:43:50 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1419> 
======================================================================
Reported By:                tom123
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1419
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               SuSE 9.2 Pro
Kernel Version:             2.6.8
======================================================================
Date Submitted:             09-14-2005 18:09 CEST
Last Modified:              11-12-2005 10:43 CET
======================================================================
Summary:                    Input/output jacks mixed up
Description: 
I'm using alsa 1.0.10rc1 for a Shuttle ST20G5 barebone. The mainboard has
an ULi M1573 southbridge with integrated ALC880 sound. When I play a
normal 2.0 stereo file, sound is applied at rear jacks "line in" and
"front". On the front side the "MIC" jack brings out the sound, not the
"Headphone" jack.

On the rear side are 5 jacks (with explanation from the manual) :

Side-SURR port
Side-SURR is a stereo line-level output port that accepts a 1/8-inch TRS
stereo plug.

Line-In port
Line-In is a stereo line-level input port that accepts a 1/8-inch TRS
stereo plug. It can be used as a source for digital sound recording, a
source to be mixed with the output, or both.

Bass/Center port
Bass/Center-Out is a stereo output port through which the combined signal
of all internal and external audio sources on the board is output. It can
be connected to 1/8-inch TRS stereo headphones or to bass/center amplified
speakers.

Surround-Back port
Surround-Back is a stereo linelevel output port that accepts a 1/8-inch
TRS stereo plug.

Front-Out port
Front-Out is a stereo output port through which the combined signal of all
internal and external audio sources on the board is output. It can be
connected to 1/8-inch TRS stereo headphones or to amplified speakers.

So I had expected sound from Front-Out and Bass/Center port at the rear
side. On the front side sound is expected coming from the headphone jack.


======================================================================

----------------------------------------------------------------------
 dvlierop - 11-12-05 10:43 
----------------------------------------------------------------------
The headphone output is still routed to the microphone jack in
v1.0.10rc3... I'm running FC4 64bit 2.6.13-1.1532_FC4 on my Shuttle
ST20G5.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-14-05 18:09 tom123         New Issue                                    
09-14-05 18:09 tom123         Distribution              => SuSE 9.2 Pro    
09-14-05 18:09 tom123         Kernel Version            => 2.6.8           
11-12-05 10:43 dvlierop       Note Added: 0006684                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
