From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002135]: emu10k1: resume (S3) doesn't
	work with Audigy 2 ZS Notebook
Date: Sun, 23 Jul 2006 18:49:04 +0200
Message-ID: <e689d51828b316f1d12bf0dbb859769c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C09841A0
	for <alsa-devel@alsa-project.org>;
	Sun, 23 Jul 2006 18:49:04 +0200 (MEST)
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


The following issue has been ACKNOWLEDGED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2135> 
======================================================================
Reported By:                cathectic
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   2135
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     acknowledged
Distribution:               Slamd64
Kernel Version:             2.6.17-rc4
======================================================================
Date Submitted:             05-19-2006 01:33 CEST
Last Modified:              07-23-2006 18:49 CEST
======================================================================
Summary:                    emu10k1: resume (S3) doesn't work with Audigy 2 ZS
Notebook
Description: 
System: Acer Aspire 5021
Sound Card: Creative Audigy 2 ZS Notebook
Kernel: 2.6.17-rc4 (also tested on 2.6.16.16)
Append lines: "noapic" and "noapic acpi_irq_balance" (needed for suspend
to work)

When the Audigy 2 ZS Notebook is inserted, and the snd-emu10k1 module is
loaded, after suspending (S3) the laptop, it will not resume.

If the card is removed first; or the snd-emu10k1 module is unloaded before
standby (or the card can be physically ejected while on standby); resume
works fine (the module can then be reloaded afterwards manually and the
card will start working again).
======================================================================

----------------------------------------------------------------------
 jcdutton - 07-23-06 18:49 
----------------------------------------------------------------------
Known problem. Power management not supported yet.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-19-06 01:33 cathectic      New Issue                                    
05-19-06 01:33 cathectic      Distribution              => Slamd64         
05-19-06 01:33 cathectic      Kernel Version            => 2.6.17-rc4      
07-18-06 14:35 jcdutton       Status                   new => assigned     
07-18-06 14:35 jcdutton       Assigned To               => jcdutton        
07-23-06 18:49 jcdutton       Note Added: 0011199                          
07-23-06 18:49 jcdutton       Status                   assigned => acknowledged
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
