From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001383]: ac3 passthrough lost in
	2.6.12 and later
Date: Sun, 30 Jul 2006 17:58:39 +0200
Message-ID: <d602cb7c44801f4dd96dfc81c729af35@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 699FC14F
	for <alsa-devel@alsa-project.org>;
	Sun, 30 Jul 2006 17:58:39 +0200 (MEST)
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


The following issue requires your FEEDBACK.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1383> 
======================================================================
Reported By:                Antonio
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1383
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               Fedora Core 3
Kernel Version:             2.6.12-1.1376_FC3
======================================================================
Date Submitted:             08-31-2005 11:52 CEST
Last Modified:              07-30-2006 17:58 CEST
======================================================================
Summary:                    ac3 passthrough lost in 2.6.12 and later
Description: 
i have an audigy2 board
when i used an 2.6.11 FC kernel (2.6.11-1.35_FC3) and earlier ones all was
fine.
when i updated to 2.6.12 fc3 kernels (2.6.12-1.1372_FC3 and
2.6.12-1.1376_FC3) ac3 passthrough works no more.
When i boot back to 2.6.11 ac3 is back....

i consider the following patch(2.6.12 kernel changelog) is the reason:

<perex@suse.cz>
        [ALSA] Enables SPDIF output on the Audigy2 Value
        
        EMU10K1/EMU10K2 driver
        Enables SPDIF output on the Audigy2 Value.
        It seems to work for PCM, but not AC3 yet.


======================================================================

----------------------------------------------------------------------
 Adrian Bunk - 07-25-06 02:09 
----------------------------------------------------------------------
Is this issue still present in recent ALSA versions (e.g. the version
shipped with kernel 2.6.17)?

----------------------------------------------------------------------
 jcdutton - 07-30-06 17:58 
----------------------------------------------------------------------
Is this issue still present in recent ALSA versions (e.g. the version
shipped with kernel 2.6.17)?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-31-05 11:52 Antonio        New Issue                                    
08-31-05 11:52 Antonio        Distribution              => Fedora Core 3   
08-31-05 11:52 Antonio        Kernel Version            => 2.6.12-1.1376_FC3
02-12-06 17:13 fmoraes        Note Added: 0008030                          
02-12-06 17:13 fmoraes        Assigned To              fmoraes => jcdutton 
07-09-06 17:49 jcdutton       Assigned To              jcdutton => fmoraes 
07-25-06 02:09 Adrian Bunk    Note Added: 0011221                          
07-25-06 02:09 Adrian Bunk    Assigned To              fmoraes => jcdutton 
07-25-06 02:09 Adrian Bunk    Category                 PCI - emu10k1x => PCI -
emu10k1
07-30-06 17:58 jcdutton       Note Added: 0011320                          
07-30-06 17:58 jcdutton       Status                   assigned => feedback
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
