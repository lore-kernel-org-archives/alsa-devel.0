From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002204]: Roland UA-20 "advanced
	driver" mode doesn't work
Date: Mon, 12 Jun 2006 18:47:45 +0200
Message-ID: <26986c9d47899d85f7fd3c512137d838@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3F3D814E
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Jun 2006 18:47:46 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2204> 
======================================================================
Reported By:                ldk_linux
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   2204
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu Dapper
Kernel Version:             2.6.16 patched with alsa drivers version 1.0.11
======================================================================
Date Submitted:             06-12-2006 18:47 CEST
Last Modified:              06-12-2006 18:47 CEST
======================================================================
Summary:                    Roland UA-20 "advanced driver" mode doesn't work
Description: 
With the module sound-usb-audio in 1.0.11 my Roland UA-20 doesn't work in
"advanced driver" mode. I think the cause is the fix inserted in
1.0.11rc1, because once restored the old quirk code in usbquirks.h (see
the attached patch, applies to 1.0.11) the unit works again.

I wonder if there's a way to make all versions of the UA-20 work with a
single driver.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-12-06 18:47 ldk_linux      New Issue                                    
06-12-06 18:47 ldk_linux      File Added: UA-20_with_Alsa_1.0.11.diff           
        
06-12-06 18:47 ldk_linux      Distribution              => Ubuntu Dapper   
06-12-06 18:47 ldk_linux      Kernel Version            => 2.6.16 patched with
alsa drivers version 1.0.11
======================================================================
