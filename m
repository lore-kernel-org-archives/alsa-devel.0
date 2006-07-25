From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000222]: Request for Microphone
	support.
Date: Tue, 25 Jul 2006 11:06:22 +0200
Message-ID: <1717808822f7b735db1dd8cea282ed9c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2FF6F232
	for <alsa-devel@alsa-project.org>;
	Tue, 25 Jul 2006 11:06:23 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=222> 
======================================================================
Reported By:                dolphy
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   222
Category:                   PPC - powermac
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.5
======================================================================
Date Submitted:             04-19-2004 13:47 CEST
Last Modified:              07-25-2006 11:06 CEST
======================================================================
Summary:                    Request for Microphone support.
Description: 
I know my imac (ilamp model) has a microphone but no way to get it working
with alsa. Is it supported ? Is it just alsamixer not supporting it ?
======================================================================

----------------------------------------------------------------------
 rlrevell - 03-22-06 02:44 
----------------------------------------------------------------------
Is this fixed in recent ALSA versions?

----------------------------------------------------------------------
 dolphy - 07-25-06 11:06 
----------------------------------------------------------------------
fleur@fleur:~$ arecord -d 10 -f cd -t wav foobar.wav
ALSA lib pcm_dsnoop.c:559:(snd_pcm_dsnoop_open) unable to open slave
arecord: main:544: audio open error: No such file or directory

Apparently not.

There is a capture section in alsamixer but it does not mention microphone
still.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-19-04 13:47 dolphy         New Issue                                    
04-19-04 13:47 dolphy         Distribution              => Debian          
04-19-04 13:47 dolphy         Kernel Version            => 2.6.5           
04-20-04 12:47 tiwai          Note Added: 0000874                          
04-20-04 12:53 dolphy         Note Added: 0000877                          
04-20-04 12:56 tiwai          Note Added: 0000879                          
04-20-04 17:27 dolphy         Note Added: 0000887                          
04-23-04 17:37 tiwai          Note Added: 0000910                          
01-04-06 17:14 schwab         Issue Monitored: schwab                      
03-22-06 02:44 rlrevell       Note Added: 0008784                          
07-25-06 11:06 dolphy         Note Added: 0011225                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
