From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000302]: snd-opl3sa2 won't detect sound card in Toshiba Protege 7010 under kernel 2.6.5
Date: Mon, 4 Apr 2005 22:32:01 +0200
Message-ID: <607dcc170927d72ddec0566fc1c8e7ff@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A3C701CF
	for <alsa-devel@alsa-project.org>; Mon,  4 Apr 2005 22:32:01 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=302> 
======================================================================
Reported By:                sjlongland
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   302
Category:                   ISA - opl3sa2
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Mixed: Mostly Slackware 9.0, Gentoo Portage & parts
of Atomic Linux included
Kernel Version:             2.6.5
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             05-25-2004 06:52 CEST
Last Modified:              04-04-2005 22:32 CEST
======================================================================
Summary:                    snd-opl3sa2 won't detect sound card in Toshiba
Protege 7010 under kernel 2.6.5
Description: 
Hi,
  I've recently moved up from running Linux 2.4.24 to Linux 2.6.5 and
noticed that the snd-opl3sa2 driver refuses to load.

  Under Linux 2.4, I used the following command to load my sound card:
(from /etc/rc.d/rc.sound:)
modprobe snd-opl3sa2 \
        port=0x538 sb_port=0x220 wss_port=0x530 \
        fm_port=0x388 midi_port=0x330 irq=5 \
        dma1=1 dma2=0 isapnp=0

  Under Linux 2.6, I can get basic sound with the opl3sa2 (OSS) driver
(which oddly enough won't work under 2.4), but the mixer doesn't work
properly.  (Actually, I get two mixers -- which doesn't play nice with
KDE)

  I'm using the ALSA drivers that came with Linux 2.6.5.  I have not tried
external modules.
======================================================================

----------------------------------------------------------------------
 perex - 05-29-04 10:36 
----------------------------------------------------------------------
Is something in /var/log/messages after the modprobe commands related to
the ALSA driver?

----------------------------------------------------------------------
 sjlongland - 06-01-04 02:59 
----------------------------------------------------------------------
Not that I can find... oddly enough, I just rebooted into Linux 2.6.5 and
found error messages relating to loading modules... it appears at some
point, module-init-tools got overwritten with modutils.

After re-installing module-init-tools (0.9.13-pre) -- all is well.

Apologies for the false alarm.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-25-04 06:52 sjlongland     New Issue                                    
05-25-04 06:53 sjlongland     File Added: config.gz                        
05-25-04 06:53 sjlongland     Distribution              => Mixed: Mostly
Slackware 9.0, Gentoo Portage & parts of Atomic Linux included
05-25-04 06:53 sjlongland     Kernel Version            => 2.6.5           
05-29-04 10:36 perex          Note Added: 0001277                          
06-01-04 02:59 sjlongland     Note Added: 0001287                          
04-04-05 22:32 jdthood        Status                   new => resolved     
04-04-05 22:32 jdthood        Resolution               open => not an issue
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
