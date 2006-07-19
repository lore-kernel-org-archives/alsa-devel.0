From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002249]: intel8x0 doesn't include the
	PCI ID of my NVidia nForce 570 Sound card (it's the MCP55)
Date: Wed, 19 Jul 2006 20:37:30 +0200
Message-ID: <ff8577b4048cf8d7420dd05d3a73944f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B7AEE102
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Jul 2006 20:37:30 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2249> 
======================================================================
Reported By:                cardoe
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2249
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               gentoo
Kernel Version:             2.6.17 w/ external drivers 1.0.12_rc1
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             07-01-2006 10:17 CEST
Last Modified:              07-19-2006 20:37 CEST
======================================================================
Summary:                    intel8x0 doesn't include the PCI ID of my NVidia
nForce 570 Sound card (it's the MCP55)
Description: 
intel8x0 doesn't include the PCI ID of my NVidia nForce 570 Sound card
(it's the MCP55)

So sound doesn't work and ALSA says I have no cards. 1 line patch makes
this all happen properly.
======================================================================

----------------------------------------------------------------------
 rlrevell - 07-13-06 04:42 
----------------------------------------------------------------------
By any chance, did you boot into Windows, then reboot into Linux to get it
to work?

----------------------------------------------------------------------
 tiwai - 07-19-06 20:37 
----------------------------------------------------------------------
I close this bug since the fix was apparently included.  The driver should
simply work.
Reopen if you encounter the same problem again.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-01-06 10:17 cardoe         New Issue                                    
07-01-06 10:17 cardoe         File Added: intel-nforce-mcp55.patch              
     
07-01-06 10:17 cardoe         Distribution              => gentoo          
07-01-06 10:17 cardoe         Kernel Version            => 2.6.17 w/ external
drivers 1.0.12_rc1
07-13-06 03:03 cardoe         Note Added: 0010986                          
07-13-06 04:10 cardoe         Note Added: 0010988                          
07-13-06 04:10 cardoe         Note Deleted: 0010986                        
07-13-06 04:42 rlrevell       Note Added: 0010990                          
07-19-06 20:37 tiwai          Status                   new => resolved     
07-19-06 20:37 tiwai          Resolution               open => not an issue
07-19-06 20:37 tiwai          Assigned To               => tiwai           
07-19-06 20:37 tiwai          Note Added: 0011100                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
