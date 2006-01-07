From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001720]: Audigy LS only produces noise instead playing music
Date: Sat, 7 Jan 2006 10:29:23 +0100
Message-ID: <00c31421f883cfb8a7d79a99082a65bb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F234913B
	for <alsa-devel@alsa-project.org>; Sat,  7 Jan 2006 10:29:23 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1720> 
======================================================================
Reported By:                Nukem36JL
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1720
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               SuSE
Kernel Version:             2.6.13-15-default
======================================================================
Date Submitted:             01-05-2006 18:16 CET
Last Modified:              01-07-2006 10:29 CET
======================================================================
Summary:                    Audigy LS only produces noise instead playing music
Description: 
lspci:
00:0c.0 Multimedia audio controller: Creative Labs SB Audigy LS

While trying to play a wave- file the card produces noise only. Effect is
the same for all kind of players including aplay, ogg123 .... The card is
used together with another card, which works properly.

Module snd-ca0106 loads without error messages. 
======================================================================

----------------------------------------------------------------------
 Nukem36JL - 01-07-06 10:29 
----------------------------------------------------------------------
In alsamixer card is displayed as "CA0106" Chip is empty. Maybe this causes
the Problem.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-05-06 18:16 Nukem36JL      New Issue                                    
01-05-06 18:16 Nukem36JL      Distribution              => SuSE            
01-05-06 18:16 Nukem36JL      Kernel Version            => 2.6.13-15-default
01-05-06 18:19 Nukem36JL      Issue Monitored: Nukem36JL                    
01-07-06 10:29 Nukem36JL      Note Added: 0007511                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
