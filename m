From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001259]: Audigy 4 Pro (SB0380) with
	ALSA 1.0.9rc2 - no sound from AUX in
Date: Sun, 30 Jul 2006 19:41:41 +0200
Message-ID: <e35247379250ed7d6b2d765d1dd7ddab@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1140B13E
	for <alsa-devel@alsa-project.org>;
	Sun, 30 Jul 2006 19:41:41 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue requires your FEEDBACK.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1259> 
======================================================================
Reported By:                iq79
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1259
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     feedback
Distribution:               Gentoo Linux
Kernel Version:             2.6.12-gentoo-r1
======================================================================
Date Submitted:             07-15-2005 18:18 CEST
Last Modified:              07-30-2006 19:41 CEST
======================================================================
Summary:                    Audigy 4 Pro (SB0380) with ALSA 1.0.9rc2 - no sound
from AUX in
Description: 
I am unable to unmute the internal AUX-in header of my Audigy4Pro.

- I played around with all (Playback/Capture) mixer settings in alsamixer
but I couldn't find a configuration which gives me sound from AUX-in.

- I tried loading emu10k1 module with several extin/exout combinations.
That didn't help, too.
======================================================================

----------------------------------------------------------------------
 jcdutton - 03-13-06 23:43 
----------------------------------------------------------------------
Ok, I will have to check into this. I went round renaming all the controls
to match the Audigy 4 pro..(Line1, Line2, Line3 etc.)except the two on the
card itself. I will have to check the CD/AUX analog input, and also the
CD/Digital input connectors on the sound card itself when I get a chance.

----------------------------------------------------------------------
 jcdutton - 07-30-06 19:41 
----------------------------------------------------------------------
It transpires that there are many different Audigy 4s. Please post the
output of:
cat /proc/asound/cards
cat /proc/asound/version
amixer

I can then determine if I have the same card as you or not.



Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-15-05 18:18 iq79           New Issue                                    
07-15-05 18:18 iq79           Distribution              => Gentoo Linux    
07-15-05 18:18 iq79           Kernel Version            => 2.6.12-gentoo-r1
07-15-05 19:49 pzad           Note Added: 0005483                          
07-15-05 19:50 pzad           Note Edited: 0005483                         
07-15-05 23:40 iq79           Note Added: 0005484                          
07-16-05 16:31 jdthood        Note Added: 0005496                          
07-16-05 18:36 iq79           File Added: amixer_output                    
07-16-05 18:38 iq79           Note Added: 0005500                          
07-20-05 05:32 jcdutton       Note Added: 0005532                          
03-01-06 10:46 iq79           Note Added: 0008278                          
03-01-06 18:02 rlrevell       Note Added: 0008286                          
03-02-06 23:00 iq79           Note Added: 0008327                          
03-03-06 17:36 pzad           Note Added: 0008342                          
03-04-06 00:55 iq79           Note Added: 0008344                          
03-13-06 09:50 iq79           Note Added: 0008438                          
03-13-06 09:51 iq79           Note Edited: 0008438                         
03-13-06 17:39 pzad           Note Added: 0008450                          
03-13-06 23:39 jcdutton       Status                   new => assigned     
03-13-06 23:39 jcdutton       Assigned To               => jcdutton        
03-13-06 23:43 jcdutton       Note Added: 0008468                          
07-30-06 19:41 jcdutton       Note Added: 0011328                          
07-30-06 19:41 jcdutton       Status                   assigned => feedback
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
