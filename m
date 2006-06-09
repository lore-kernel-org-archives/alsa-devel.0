From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002193]: kernel module fails to load
	for AD1986A chipset on ASUS A8N-VM
Date: Fri, 9 Jun 2006 03:43:28 +0200
Message-ID: <c239bef3b3582fc33987cf9efe3be440@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1E9A5127
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Jun 2006 03:43:29 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2193> 
======================================================================
Reported By:                rbenech
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2193
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               OpenSuSE
Kernel Version:             2.6.16.13-4-smp
======================================================================
Date Submitted:             06-08-2006 03:09 CEST
Last Modified:              06-09-2006 03:43 CEST
======================================================================
Summary:                    kernel module fails to load for AD1986A chipset on
ASUS A8N-VM
Description: 
With alsa-1.0.11-32, SuSE 10.1 Yast Hardware Sound detects hardware as
"MCP51 High Definition Audio" but cannot complete setup.  With SuSE10
(<alsa-1.0.11rc3), yast would not detect any card.

Similar to fixed issue #0001793. Dupe of issue #0001632, but
miscategorized/flamed.

Tried all 'model=' and 'position_fix=' options I could find in other
issues. Nothing allowed kernel module to load.

I also tried OSS, module also failed to load...
======================================================================

----------------------------------------------------------------------
 rbenech - 06-09-06 03:25 
----------------------------------------------------------------------
This is an upgrade from SuSE 10.  I've been trying different things over
the past few months like installing ALSA from CVS, so I probably borked
something in the process.  I install packages with SuSe's YAST tool that
uses a YUM repository to install .rpm packages directly from an Open SuSE
mirror.  As mentioned above, I just now upgraded to alsa-1.0.11-35.  I
don't have 'locate', but a recursive search of / didn't turn anything up. 
I will try to remove and re-install the packages.  I'm looking thru SuSE
documentation for any more clues...

----------------------------------------------------------------------
 rbenech - 06-09-06 03:43 
----------------------------------------------------------------------
what package would 'snd-hda-intel' be provided by?  I can't seem to find
any providers?

fyi - alsa package looks correct with files in /etc/alsa.d, /usr/bin,
/usr/lib, etc...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-08-06 03:09 rbenech        New Issue                                    
06-08-06 03:09 rbenech        Distribution              => OpenSuSE        
06-08-06 03:09 rbenech        Kernel Version            => 2.6.16.13-4-smp 
06-08-06 03:53 rlrevell       Note Added: 0010106                          
06-09-06 02:34 rbenech        Note Added: 0010120                          
06-09-06 02:41 rlrevell       Note Added: 0010121                          
06-09-06 02:51 rbenech        Note Added: 0010122                          
06-09-06 02:57 rlrevell       Note Added: 0010123                          
06-09-06 03:25 rbenech        Note Added: 0010124                          
06-09-06 03:43 rbenech        Note Added: 0010127                          
======================================================================
