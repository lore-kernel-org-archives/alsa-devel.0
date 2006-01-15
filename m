From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001407]: Can't use rear speaker channels
Date: Sun, 15 Jan 2006 04:30:32 +0100
Message-ID: <4d12b21ef0fb61cd77cd3ed86386b1ee@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C9535130
	for <alsa-devel@alsa-project.org>; Sun, 15 Jan 2006 04:30:32 +0100 (MET)
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
Last Modified:              01-15-2006 04:30 CET
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
 drow - 11-01-05 00:35 
----------------------------------------------------------------------
Still no luck with this.  However, I now have Windows installed on the same
machine, and the VIA drivers can talk to the rear speakers just fine.  Is
there any way I can dump useful information from the chip registers while
in Windows?

----------------------------------------------------------------------
 nono31 - 01-15-06 04:30 
----------------------------------------------------------------------
Hi,

I have a SN25P too, and I have the same problem... I did not investigate
more because I a 2.1 speakers system...

But there is an anoying thing: sound cannot be used by more than 1 app at
the same time.. If I have xmms playing a music, and I start mplayer to
play a movie, mplayer will hang until I stop xmms. 

Do you have the same problem?

Thanks

Nono31

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
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
