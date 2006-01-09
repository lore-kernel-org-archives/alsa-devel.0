From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001720]: Audigy LS only produces noise instead playing music
Date: Mon, 9 Jan 2006 21:51:46 +0100
Message-ID: <d1329ea41652f64ec735ee083f4f47b6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 77CA7141
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2006 21:51:46 +0100 (MET)
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
Status:                     closed
Distribution:               SuSE
Kernel Version:             2.6.13-15-default
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             01-05-2006 18:16 CET
Last Modified:              01-09-2006 21:51 CET
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
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001701 Audigy LS (or SE) doen't work probably
related to          0001679 Audigy 4 SE (SB_0570, ca0106) does not ...
======================================================================

----------------------------------------------------------------------
 rlrevell - 01-09-06 18:02 
----------------------------------------------------------------------
Looks like Audigy SE, SB0570.

Can you try a newer ALSA, 1.0.9b does not support your card very well.

----------------------------------------------------------------------
 jcdutton - 01-09-06 21:51 
----------------------------------------------------------------------
Fixed in alsa-driver 1.0.11rc2 or above.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-05-06 18:16 Nukem36JL      New Issue                                    
01-05-06 18:16 Nukem36JL      Distribution              => SuSE            
01-05-06 18:16 Nukem36JL      Kernel Version            => 2.6.13-15-default
01-05-06 18:19 Nukem36JL      Issue Monitored: Nukem36JL                    
01-07-06 10:29 Nukem36JL      Note Added: 0007511                          
01-07-06 14:19 jcdutton       Note Added: 0007512                          
01-09-06 17:48 Nukem36JL      Note Added: 0007538                          
01-09-06 18:02 rlrevell       Note Added: 0007539                          
01-09-06 21:48 jcdutton       Relationship added       related to 0001679  
01-09-06 21:48 jcdutton       Relationship added       related to 0001701  
01-09-06 21:49 jcdutton       Relationship replaced    duplicate of 0001701
01-09-06 21:51 jcdutton       Status                   assigned => closed  
01-09-06 21:51 jcdutton       Note Added: 0007541                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
