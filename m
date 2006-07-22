From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0001831]: envy24control does not work
	with Hercules Fortissimo IV
Date: Sat, 22 Jul 2006 22:57:19 +0200
Message-ID: <a7108f4ff261e4352ac71fe210a7cc9b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 47EB2158
	for <alsa-devel@alsa-project.org>;
	Sat, 22 Jul 2006 22:57:19 +0200 (MEST)
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


The following issue has been set as RELATED TO issue 0002293.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1831> 
======================================================================
Reported By:                liiwi
Assigned To:                
======================================================================
Project:                    ALSA - tools
Issue ID:                   1831
Category:                   envy24control
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-08-2006 20:03 CET
Last Modified:              07-22-2006 02:57 CEST
======================================================================
Summary:                    envy24control does not work with Hercules Fortissimo
IV
Description: 
Previously I did not have any pressing need to try envy24control. However
recently
for some odd reason left channel got just about muted. So, I tried
envy24control:

>No ICE1712 cards found

So, now I'm without left channel.

>From dmesg:

ice1724: No matching model found for ID 0x81160100
ice1724: Invalid EEPROM version 1

Hrm, this might be an driver issue if envy24control asks from driver about
the card and it does not know what model... 

This happens with all the way to 1.0.11-rc3.

lspci says about the card:

>Multimedia audio controller: VIA Technologies Inc. VT1720/24
[Envy24PT/HT] PCI >Multi-Channel Audio Controller (rev 01)


======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0002136 ice1724gt support for Envy24Control
related to          0002293 M-Audio Delta 192 - Missing controls
======================================================================

----------------------------------------------------------------------
 liiwi - 02-11-06 13:17 
----------------------------------------------------------------------
Hrm, after playing with envy24control sources, mainly replacing "ICE1712"
with "ICE1724", it looks like reading from card eeprom does not give
what's expected.
Just a guess, though. So, this might be driver issue.

As ICE1712 requirement is hardcoded into envy24control, are there any
plans to add  real ICE1724 support?

----------------------------------------------------------------------
 liiwi - 02-11-06 13:48 
----------------------------------------------------------------------
Ok, one problem solved: left channel was missing, because I had screwed up
bindings in .asoundrc.Color of face today is RED.

However, the thing about envy24control still is there. I'd also like to
record something, but so far I've only been able to get silence from
capture channels.
I'm just guessing that either the driver is not supporting this card
properly
or I just need to adjust levels with envy24control.

----------------------------------------------------------------------
 cruiseoveride - 07-22-06 02:56 
----------------------------------------------------------------------
hows ur C, liiwi  ?

i have managed to get the "Main RCA OUT" on the envy24control for the
ice1724, perhaps u might give it a go, 

let me find my envy24control, zip it and upload it for u.

we can hack on it.

I have put printf statements all over the place , so when u launch it from
a terminal, u are going to see a lot of verbose output.

The Digital Mixer and the the RCA out works,
I got the Master clock working too.

if u get anything else working, please upload, and let me know wat u
changed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-08-06 20:03 liiwi          New Issue                                    
02-11-06 13:17 liiwi          Note Added: 0008015                          
02-11-06 13:48 liiwi          Note Added: 0008016                          
07-22-06 02:56 cruiseoveride  Note Added: 0011159                          
07-22-06 02:57 cruiseoveride  File Added: cruise24control.tar.bz2               
    
07-22-06 22:56 rlrevell       Relationship added       related to 0002136  
07-22-06 22:57 rlrevell       Relationship added       related to 0002293  
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
