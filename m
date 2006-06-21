From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000321]: Left front channel always
	muted on boot
Date: Wed, 21 Jun 2006 09:38:00 +0200
Message-ID: <45bb94cb1b7b5e67f6dbb1761af6fb32@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2D8A5190
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jun 2006 09:38:01 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=321> 
======================================================================
Reported By:                64bitten
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   321
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     acknowledged
Distribution:               gentoo
Kernel Version:             2.6.6
======================================================================
Date Submitted:             06-02-2004 08:09 CEST
Last Modified:              06-21-2006 09:37 CEST
======================================================================
Summary:                    Left front channel always muted on boot
Description: 
ice1724 (M Audio Revolution 7.1 in my case) always restores the mixer
settings at boot, but the left front channel is muted regardless.  The fix
is to run alsamixer and adjust the slider again.  This forces the channel
to unmute.  Should I be worried "amixer scontrols" reports everything as
"Mono" as well?
======================================================================

----------------------------------------------------------------------
 goldenfish - 06-21-06 09:05 
----------------------------------------------------------------------
Hi Raymond,

in attachment my /var/lib/asound/asound.state.

There is small tip:

/proc/asound/card0/ice1724

M Audio Revolution-7.1 at 0xb400, irq 21

EEPROM:
  Subvendor        : 0x12143036
  Size             : 19 bytes
  Version          : 2
                 ^^^^^^^^^
This bug may be dependent on revision of card.

----------------------------------------------------------------------
 herby - 06-21-06 09:37 
----------------------------------------------------------------------
This problem has been around for quite a while (couple of years).  It
manifests itself by NOT doing the first volume set.  This is usually the
left front.  Since the driver saves the value (so it won't send the data
twice) it persists.  What I did to "workaround" is to set the value to 80%
(any value other than what you want), and then set the "real" value.  This
has alsways worked for me.  I suspect that something in the init sequence
(run at driver load) leaves something in a bad state.  At the moment I
don't have the card in close proximity (to test), but be assured that this
fault has been around since the 0.9 era.  I will also note that after the
first set, the card behaves quite properly.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-02-04 08:09 64bitten       New Issue                                    
06-02-04 08:09 64bitten       Distribution              => gentoo          
06-02-04 08:09 64bitten       Kernel Version            => 2.6.6           
12-17-04 03:15 K6-III         Note Added: 0002845                          
12-17-04 06:46 herby          Note Added: 0002846                          
12-17-04 06:51 rlrevell       Note Added: 0002847                          
12-21-04 07:09 64bitten       File Added: amixer.bad                       
12-21-04 07:10 64bitten       Note Added: 0002896                          
04-09-05 17:24 jdthood        Status                   new => acknowledged 
10-20-05 02:36 sst4           Note Added: 0006497                          
10-20-05 05:18 Fran           Note Added: 0006498                          
10-21-05 03:51 64bitten       Note Added: 0006509                          
11-18-05 21:03 goldenfish     Note Added: 0006758                          
11-18-05 21:04 goldenfish     File Added: proc_changes.diff                    
06-20-06 22:55 effie          Issue Monitored: effie                       
06-20-06 23:05 effie          Issue End Monitor: effie                     
06-20-06 23:29 effie          Note Added: 0010356                          
06-20-06 23:31 effie          Note Edited: 0010356                         
06-21-06 06:10 Raymond        Note Added: 0010382                          
06-21-06 09:05 goldenfish     Note Added: 0010384                          
06-21-06 09:07 goldenfish     File Added: asound.state                     
06-21-06 09:37 herby          Note Added: 0010388                          
======================================================================
