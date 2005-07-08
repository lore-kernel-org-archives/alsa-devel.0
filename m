From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001056]: Realtek ALC 880 on board sound chip not detected.
Date: Fri, 8 Jul 2005 10:37:29 +0200
Message-ID: <bf718dff275ddd3993fdd7e7728fa07e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4504417A
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 10:37:29 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1056> 
======================================================================
Reported By:                David Kinzer
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   1056
Category:                   alisp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             04-15-2005 15:51 CEST
Last Modified:              07-08-2005 10:37 CEST
======================================================================
Summary:                    Realtek ALC 880 on board sound chip not detected.
Description: 
Description of problem:
New HP m7060n Media Center PC. (Private ASUS motherboard with integrated
sound.)
Install FC3 core (workstation config) from scratch.
Sound chip is not detected.
Core is "up2date"

>From Specs sheet:
      Integrated Intel High Definition (TM) audio (Azalia) 

          o Realtek ALC 880 chipset
          o THX certification support
          o 8-channels for Full Dolby 5.1/6.1/7.1 surround sound support
with Dolby Pro Logic IIx
          o Dolby 5.1



======================================================================

----------------------------------------------------------------------
 David Kinzer - 04-17-05 22:55 
----------------------------------------------------------------------
By fiddling with enough things that I read about on the web I have managed
to get everything working at this point.  

Thanks again for your assistance.

Notes for future readers:

Desktop & game noises started working after running the test in
Preferences->More Preferences->Multimedia System Selector.  I don't know
why.

This computer does not ship with an analog audio connection to the CD
drive, the Gnome CD player requires this.  I loaded XMMS and XMMS-cdread
to get a CD player working.  Use cd-rom drive (/dev/cdrom1) instead of
burner drive which would skip regularily as it spun up and down in speed.

----------------------------------------------------------------------
 tiwai - 04-19-05 17:43 
----------------------------------------------------------------------
Thanks for confirmation.  The rest seems to be non-specific to the sound
system, so let's close this now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-15-05 15:51 David Kinzer   New Issue                                    
04-15-05 15:52 David Kinzer   Note Added: 0004501                          
04-15-05 15:57 pzad           Note Added: 0004502                          
04-16-05 04:41 David Kinzer   Note Added: 0004504                          
04-16-05 08:58 pzad           Note Added: 0004505                          
04-17-05 01:03 David Kinzer   Note Added: 0004509                          
04-17-05 22:55 David Kinzer   Note Added: 0004514                          
04-19-05 17:43 tiwai          Status                   new => resolved     
04-19-05 17:43 tiwai          Resolution               open => fixed       
04-19-05 17:43 tiwai          Assigned To               => tiwai           
04-19-05 17:43 tiwai          Note Added: 0004526                          
07-08-05 10:37 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
