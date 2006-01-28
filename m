From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001407]: Can't use rear speaker channels
Date: Sat, 28 Jan 2006 02:08:26 +0100
Message-ID: <585ac1753560e31071559dd984ed49de@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4F44316B
	for <alsa-devel@alsa-project.org>; Sat, 28 Jan 2006 02:08:26 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1407> 
======================================================================
Reported By:                drow
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1407
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.13-rc6
======================================================================
Date Submitted:             09-09-2005 05:11 CEST
Last Modified:              01-28-2006 02:08 CET
======================================================================
Summary:                    Can't use rear speaker channels
Description: 
I'm using a Shuttle SN25P, which is an nForce4 motherboard with onboard
ice1724.  I've spent most of tonight trying to get surround sound to
work... but the best I can get is four channels (specifically, front
left/right, center, LFE).  Nothing happens when samples are sent to the
rear channels.  And the front channels are mirrored onto the rear
speakers, under control of the Headphone volume control.

Which is really annoying, because it means that muting the master volume
doesn't mute the back speakers.

I realize this isn't much information.  I don't know what else to check
but I'll be glad to debug it if someone can give me a pointer.

======================================================================

----------------------------------------------------------------------
 nono31 - 01-28-06 02:01 
----------------------------------------------------------------------
Hum. so was just this...

Anyway, I still have the problem that skype is block my resource.


NB: Skype is running chrooted because there is no 64bits versions of
skype. chrooted user is same,  groups are ported to the chroot
environment, /dev is binded...

NB2: openwengo block sound too even that it is using alsa. They say that
it is because openwengo is not supporting dmix...

----------------------------------------------------------------------
 rlrevell - 01-28-06 02:08 
----------------------------------------------------------------------
Skype should not block anything as long as it is run as "aoss skype".

openwengo should work too - apps do not have to do anything special to
"support dmix", as long as it's using the "default" PCM and not one of the
"hw:x" devices.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-09-05 05:11 drow           New Issue                                    
09-09-05 05:11 drow           Distribution              => Debian          
09-09-05 05:11 drow           Kernel Version            => 2.6.13-rc6      
09-09-05 05:13 drow           Note Added: 0006091                          
09-12-05 18:05 drow           Note Added: 0006148                          
11-01-05 00:35 drow           Note Added: 0006591                          
01-15-06 04:30 nono31         Note Added: 0007658                          
01-15-06 04:39 rlrevell       Note Added: 0007659                          
01-16-06 16:17 drow           Note Added: 0007687                          
01-16-06 16:45 fearofcarpet   Issue Monitored: fearofcarpet                    
01-28-06 01:33 nono31         Note Added: 0007811                          
01-28-06 01:34 nono31         Note Edited: 0007811                         
01-28-06 01:45 rlrevell       Note Added: 0007812                          
01-28-06 01:56 nono31         Issue Monitored: nono31                      
01-28-06 02:01 nono31         Note Added: 0007813                          
01-28-06 02:08 rlrevell       Note Added: 0007814                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
