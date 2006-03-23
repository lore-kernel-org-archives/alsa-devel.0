From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001900]: alsactl stores incorrect values; overwrites non-writable file; does not set emu10k1 mixer
Date: Thu, 23 Mar 2006 17:46:03 +0100
Message-ID: <942a1fda09e4c7a03c5c807acd9553ca@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 480CC1BB
	for <alsa-devel@alsa-project.org>; Thu, 23 Mar 2006 17:46:03 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1900> 
======================================================================
Reported By:                covex
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Issue ID:                   1900
Category:                   alsactl
Reproducibility:            sometimes
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             03-09-2006 17:38 CET
Last Modified:              03-23-2006 17:46 CET
======================================================================
Summary:                    alsactl stores incorrect values; overwrites
non-writable file; does not set emu10k1 mixer
Description: 
I have one main problem with alsa and emu10k1 based SB Live! card. 

It's some time ago I notice that very often (not always) after reboot my
sound card has setup strange values in mixer (e.g wave volume is righ 75
and left 0, see attached asound.state). First I thought it's some
application setting these nonsenses but it's not true - those values are
set SOMETIMES on module removal at reboot.

What I noticed during digging around:
1) Always on user logout I have message in log: ainit: Operation not
permitted
It is not specified what operation.
2) see this situation:
# modprobe -r snd-emu10k1
# modprobe --ignore-install snd-emu10k1 && alsactl restore 0
/usr/sbin/alsactl: load_state:1250: Cannot find soundcard '0'...
The only thing that works is:
# modprobe --ignore-install snd-emu10k1; sleep 1; alsactl restore 0
As the first one is very common situation in all modprobe.conf setups I
see this as fairly bad problem.

3) I set permitions of /etc/asound.state to r--r--r-- to protect it from
being overwriten but issuing alsactl store overwrites this file!

None of these explain why, on module removal the asound is filled with
incorrect values (asound.state is attached). 
BTW: there are three states in that file - for CK804 (it is nForce4
chipset with internal AC97 disabled), for Unknown (guh?!) and Live (finaly
correct).


======================================================================

----------------------------------------------------------------------
 tiwai - 03-15-06 11:50 
----------------------------------------------------------------------
The -F option has no influence for alsactl save.  It's *nix tradition that
root can do everything.  (For example, you can do "echo XXX >
any-file-without-read-bit" as root.)

alsactl has, so far, no function to remove the old entries.  Please use
editor to remove the entries of "Unknown" (although that entry must be
harmless except for place holder).

----------------------------------------------------------------------
 tiwai - 03-23-06 17:46 
----------------------------------------------------------------------
Since these are no real bugs, I close now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-09-06 17:38 covex          New Issue                                    
03-09-06 17:38 covex          File Added: asound.state.wrong                    
03-14-06 15:53 tiwai          Note Added: 0008483                          
03-14-06 21:54 covex          Note Added: 0008517                          
03-14-06 22:03 rlrevell       Note Added: 0008518                          
03-15-06 11:50 tiwai          Note Added: 0008534                          
03-23-06 17:46 tiwai          Status                   new => resolved     
03-23-06 17:46 tiwai          Resolution               open => not an issue
03-23-06 17:46 tiwai          Assigned To               => tiwai           
03-23-06 17:46 tiwai          Note Added: 0008897                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
