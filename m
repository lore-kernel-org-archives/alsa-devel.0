From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002018]: Realtek ALC861 hda-intel headphones problem
Date: Wed, 12 Apr 2006 22:05:29 +0200
Message-ID: <841a48968619e7b54cc592410ca26dd6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D22B614B
	for <alsa-devel@alsa-project.org>; Wed, 12 Apr 2006 22:05:29 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2018> 
======================================================================
Reported By:                fgrieco
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2018
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.16
======================================================================
Date Submitted:             04-12-2006 22:05 CEST
Last Modified:              04-12-2006 22:05 CEST
======================================================================
Summary:                    Realtek ALC861 hda-intel headphones problem
Description: 
The driver works but when i connect headphones to my notebook and then
disconnet them, there is no sound. I have to restart the alsasound service
in my Gentoo (unload and reload modules) to have again sounds on the
notebook.
If i connect headphones, disconnet and reconnect them, sounds are still
present in headphones.
Driver: alsa-driver 1.0.11-rc5

The notebook is a Toshiba A100-155
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-12-06 22:05 fgrieco        New Issue                                    
04-12-06 22:05 fgrieco        Distribution              => Gentoo          
04-12-06 22:05 fgrieco        Kernel Version            => 2.6.16          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
