From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002135]: emu10k1: resume (S3) doesn't work with Audigy 2 ZS Notebook
Date: Fri, 19 May 2006 01:33:16 +0200
Message-ID: <7c88516b447804beaa785afafb47031e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 46FA1197
	for <alsa-devel@alsa-project.org>; Fri, 19 May 2006 01:33:16 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2135> 
======================================================================
Reported By:                cathectic
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2135
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Slamd64
Kernel Version:             2.6.17-rc4
======================================================================
Date Submitted:             05-19-2006 01:33 CEST
Last Modified:              05-19-2006 01:33 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-19-06 01:33 cathectic      New Issue                                    
05-19-06 01:33 cathectic      Distribution              => Slamd64         
05-19-06 01:33 cathectic      Kernel Version            => 2.6.17-rc4      
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
