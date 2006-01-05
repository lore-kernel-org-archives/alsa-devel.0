From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001720]: Audigy LS only produces noise instead playing music
Date: Thu, 5 Jan 2006 18:16:01 +0100
Message-ID: <a404ec8b67d8ff94540f6397d44b5f1d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 57EDD18B
	for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2006 18:16:01 +0100 (MET)
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


The following issue has been SUBMITTED.
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
Last Modified:              01-05-2006 18:16 CET
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-05-06 18:16 Nukem36JL      New Issue                                    
01-05-06 18:16 Nukem36JL      Distribution              => SuSE            
01-05-06 18:16 Nukem36JL      Kernel Version            => 2.6.13-15-default
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
