From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000901]: The onboard audigyls chip on msi k8 diamond motherboard not recognized. Path supplied.
Date: Sat, 19 Mar 2005 18:17:54 +0100
Message-ID: <21e48debe453472e81b3ea2f95c76ba3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id AAAEF1EE
	for <alsa-devel@alsa-project.org>; Sat, 19 Mar 2005 18:17:54 +0100 (MET)
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


The issue 0000987 has been set as DUPLICATE OF the following issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=901> 
======================================================================
Reported By:                kiksen
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   901
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo
Kernel Version:             2.6.10
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             02-11-2005 23:49 CET
Last Modified:              02-13-2005 01:27 CET
======================================================================
Summary:                    The onboard audigyls chip on msi k8 diamond
motherboard not recognized. Path supplied.
Description: 
We'll. The driver fails to load (and dmesg comlaints about a missing AC97)

Have made a path.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0000987 new chipset
======================================================================

----------------------------------------------------------------------
 jcdutton - 02-12-05 00:56 
----------------------------------------------------------------------
Please post the output of:
lspci -vn | grep -1 0401

----------------------------------------------------------------------
 kiksen - 02-12-05 14:36 
----------------------------------------------------------------------
Found out the serial in the names section should be 0x10091462 for
detection of correct name.

Here's the output of lspci -vn | grep -1 0401:

00000:01:0d.0 Class 0401: 1102:0007
        Subsystem: 1462:1009

By the way. The chip is named SB0438

----------------------------------------------------------------------
 sHINOBI - 02-12-05 22:47 
----------------------------------------------------------------------
I have the same board, so including it to the future versions of ALSA will
be highly appreciated :-). I'll try the patch and let you know, if it
works.

----------------------------------------------------------------------
 jcdutton - 02-13-05 00:18 
----------------------------------------------------------------------
cat /proc/asound/cards
Does it say: "AudigyLS [Unknown]" after your patch?

----------------------------------------------------------------------
 sHINOBI - 02-13-05 00:54 
----------------------------------------------------------------------
After the patch  cat /proc/asound/cards shows:

0 [CA0106         ]: CA0106 - CA0106
                     AudigyLS [Unknown] at 0xde00 irq 233

The soundcard seems to be working, although the sound is choppy when
playing sound  recorded at 44100 Hz. 48000 Hz audio like the one at DVD's
is played correctly.

----------------------------------------------------------------------
 jcdutton - 02-13-05 01:08 
----------------------------------------------------------------------
In you patch change:
+	 { 0x00071102, "Live! by MSI [SB0000]"}, /* MSI SB Audigy2LS without
AC97 */

to
+	 { 0x10091462, "Live! by MSI [SB0438]"}, /* MSI SB Audigy2LS without
AC97 */

then see if "cat /proc/asound/cards" displays better info.

----------------------------------------------------------------------
 sHINOBI - 02-13-05 01:21 
----------------------------------------------------------------------
*nods*, seems to be better:

0 [CA0106         ]: CA0106 - CA0106
                     Live! by MSI [SB0438] at 0xde00 irq 233

----------------------------------------------------------------------
 jcdutton - 02-13-05 01:27 
----------------------------------------------------------------------
Thank you. A modified patch will be added to alsa cvs.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-11-05 23:49 kiksen         New Issue                                    
02-11-05 23:49 kiksen         File Added: msi_audigyls_patch.patch              
     
02-11-05 23:49 kiksen         Distribution              => Gentoo          
02-11-05 23:49 kiksen         Kernel Version            => 2.6.10          
02-12-05 00:56 jcdutton       Note Added: 0003569                          
02-12-05 14:36 kiksen         Note Added: 0003571                          
02-12-05 22:43 sHINOBI        Issue Monitored: sHINOBI                     
02-12-05 22:47 sHINOBI        Note Added: 0003572                          
02-13-05 00:18 jcdutton       Note Added: 0003574                          
02-13-05 00:54 sHINOBI        Note Added: 0003575                          
02-13-05 01:08 jcdutton       Note Added: 0003576                          
02-13-05 01:21 sHINOBI        Note Added: 0003577                          
02-13-05 01:27 jcdutton       Status                   assigned => resolved
02-13-05 01:27 jcdutton       Resolution               open => fixed       
02-13-05 01:27 jcdutton       Note Added: 0003578                          
02-22-05 19:22 sHINOBI        Issue End Monitor: sHINOBI                    
03-19-05 18:17 jcdutton       Relationship added       has duplicate 0000987
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
