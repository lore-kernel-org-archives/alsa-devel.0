From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001988]: No microphone input on Dell Inspiron 6400
Date: Mon, 3 Apr 2006 08:03:43 +0200
Message-ID: <d2a84c2281ee0d1be1f157b66fa93488@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D04641AA
	for <alsa-devel@alsa-project.org>; Mon,  3 Apr 2006 08:03:43 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1988> 
======================================================================
Reported By:                tbecker37
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1988
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 5
Kernel Version:             2.6.16-1.2080_FC5smp
======================================================================
Date Submitted:             03-31-2006 21:28 CEST
Last Modified:              04-03-2006 08:03 CEST
======================================================================
Summary:                    No microphone input on Dell Inspiron 6400
Description: 
Installing the 1.0.11rc4 driver enabled sound output both for extenal and
headphone jack. However microphone input does not work.  Mic input is
displayed in alsamixer but is not adjustable.

I have also compiled and tried the driver from CVS on 3-31 with no
success.
======================================================================

----------------------------------------------------------------------
 anarki - 04-03-06 08:03 
----------------------------------------------------------------------
I can reproduce this on a Dell Inspiron 630m laptop (sigmatel chip, using
intel-hda driver), with ubuntu dapper, kernel 2.6.15-19 (latest) and
latest alsa-driver cvs

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-31-06 21:28 tbecker37      New Issue                                    
03-31-06 21:28 tbecker37      Distribution              => Fedora Core 5   
03-31-06 21:28 tbecker37      Kernel Version            => 2.6.16-1.2080_FC5smp
03-31-06 23:39 tbecker37      Issue Monitored: tbecker37                    
04-03-06 08:03 anarki         Note Added: 0009087                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
