From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001371]: IEC958 controls/recording/sound quality not working right
Date: Wed, 31 Aug 2005 07:18:17 +0200
Message-ID: <bbd91604e4e2f3ecade7af55367c1b08@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 48EF4208
	for <alsa-devel@alsa-project.org>; Wed, 31 Aug 2005 07:18:17 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1371> 
======================================================================
Reported By:                sprockkets
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1371
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               SuSE 9.3
Kernel Version:             2.6.11.4-21.8
======================================================================
Date Submitted:             08-25-2005 21:27 CEST
Last Modified:              08-31-2005 07:18 CEST
======================================================================
Summary:                    IEC958 controls/recording/sound quality not working
right
Description: 
Using acrecord to record with the cd profile for whatever reason will
record the spdif material coming into it but the end result file will
sound higher pitched. 
Whereas before to hear the spdif material you would activate the "IEC958
In Monitor" control, but now you need that and the "IEC958 In Select"
control to be on. Could be related to bug 000423 but not sure. While that
wouldn't seem to be a pain or a bug, the sound quality of the spdif is
poor, with a little white noise.

The input of the spdif comes from a Sony minidisc recorder. 
Using SuSE 9.1 on the same machine works perfectly like it always had.
======================================================================

----------------------------------------------------------------------
 sprockkets - 08-31-05 07:18 
----------------------------------------------------------------------
It seems that now just having In Monitor selected works under SuSE 9.3

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-25-05 21:27 sprockkets     New Issue                                    
08-25-05 21:27 sprockkets     Distribution              => SuSE 9.3        
08-25-05 21:27 sprockkets     Kernel Version            => 2.6.11.4-21.8   
08-31-05 07:18 sprockkets     Note Added: 0005984                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
