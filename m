From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0001228]: Skype Does not work with aoss
Date: Sat, 28 Jan 2006 05:34:47 +0100
Message-ID: <b1d9d08fbda95255f12cea15f7232216@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A0FF71B1
	for <alsa-devel@alsa-project.org>; Sat, 28 Jan 2006 05:34:47 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1228> 
======================================================================
Reported By:                hil
Assigned To:                
======================================================================
Project:                    ALSA - liboss
Issue ID:                   1228
Category:                   
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-03-2005 09:09 CEST
Last Modified:              01-28-2006 05:34 CET
======================================================================
Summary:                    Skype Does not work with aoss
Description: 
I downloaded alsa-oss-1.0.9rc2 and install by
# ./configure --with-aoss=yes && make && make install
as root. Virtually every program works except skype
(http://www.skype.com/) version 1.1.0.13_API. I downloaded the Fedora
version of skype from the skype official website. Skype only uses
/dev/dsp. I guess skype uses /dev/dsp as microphone input as well. I could
not hear anything and the microphone did not work as well if I run  skype
like aoss /usr/bin/skype. If I run skype without aoss, then skype works
just fine.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001224 artsd-like style
======================================================================

----------------------------------------------------------------------
 Hetfield - 01-05-06 22:01 
----------------------------------------------------------------------
no, check the bug 1224, i still have the same problems.

seg fault was fixed lots time ago.

the problem is:
1) setting the suggested values in my .asoundrc skype works with aoss
(OK!!)
2) complete dmix system gets faked. i mean..xmms and mplayer (with skype
closed) can't use sound drivers.
3) as 2), using skype with aoss is useless, cause other devices can't use
dsp at the same time.

removing .asoundrc settings fix the 2) but, obviusly keeps 1).

i can do a fast summary:

i hear mp3s/watch dvd. can i hear skype ring in the meanwhile?
actually not.

ps. card is always ens1370

----------------------------------------------------------------------
 nono31 - 01-28-06 05:34 
----------------------------------------------------------------------
I'm using a Shuttle SN25P, which is an nForce4 motherboard with onboard
ice1724.

I use 1.0.11rc2 card's config file to have mutilple apps playing at the
same time.

I use a chrooted environment to run skype.
I've almost skype working:

I've got the call ringing (no sound blocking). But after the call
establishment, it is sound less: I can't hear what the other party is
saying and they can't hear me neither.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-03-05 09:09 hil            New Issue                                    
08-09-05 15:33 rapand         Note Added: 0005732                          
08-10-05 00:49 rlrevell       Relationship added       duplicate of 0001224
08-10-05 00:50 rlrevell       Note Added: 0005740                          
12-31-05 00:19 rlrevell       Note Added: 0007315                          
01-02-06 18:54 rlrevell       Relationship deleted     duplicate of 0001224
01-02-06 18:55 rlrevell       Relationship added       related to 0001224  
01-02-06 18:56 rlrevell       Note Added: 0007375                          
01-05-06 21:36 Hetfield       Note Added: 0007479                          
01-05-06 21:40 rlrevell       Note Added: 0007480                          
01-05-06 21:42 rlrevell       Note Added: 0007481                          
01-05-06 22:01 Hetfield       Note Added: 0007482                          
01-28-06 05:34 nono31         Note Added: 0007824                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
