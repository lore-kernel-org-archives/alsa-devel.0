From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001541]: alsa-lib make check: static building doesn't work on PIC architectures
Date: Thu, 10 Nov 2005 12:44:27 +0100
Message-ID: <dff11de18eb6519574ab814c2199759f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ED89A1CA
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2005 12:44:27 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1541> 
======================================================================
Reported By:                Flameeyes
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1541
Category:                   aconnect
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             11-10-2005 12:44 CET
Last Modified:              11-10-2005 12:44 CET
======================================================================
Summary:                    alsa-lib make check: static building doesn't work on
PIC architectures
Description: 
Some architectures, such as AMD64, IA64 and Alpha cannot mix PIC and
non-PIC objects when creating a PIC output. Hardened compilers (which uses
SSP and PIE) creates PIC executables, passing -static in CFLAGS for tests
in make check in alsa-lib makes their linking to fail.

The attached patch removes the -static flag, and let libtool handle the
linking to the local copy of libasound instead of the system's one.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-10-05 12:44 Flameeyes      New Issue                                    
11-10-05 12:44 Flameeyes      File Added: alsa-lib-1.0.10_rc3-hardened.patch    
               
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
