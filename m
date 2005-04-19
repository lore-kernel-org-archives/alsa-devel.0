From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001066]: autodetection fails
Date: Tue, 19 Apr 2005 17:25:18 +0200
Message-ID: <b88e26ed5bef7eb876ab2ae49fc9e87b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DBA8723A
	for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2005 17:25:18 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1066> 
======================================================================
Reported By:                El Santo
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1066
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               linux from scratch
Kernel Version:             2.6.11.7
======================================================================
Date Submitted:             04-19-2005 08:54 CEST
Last Modified:              04-19-2005 17:25 CEST
======================================================================
Summary:                    autodetection fails
Description: 
i own a asus a8v (kt800pro) deluxe motherboard. it has a realtec alc850
ac97 codec....

i though this codec was supported

when i load the snd-via82xx dont detect it... and none of the alsa modules
say anything... not in screen, not kernel messages (dmesg), neither in
/var/log/*...

i have a bt878 tv card (bttv works perfectly) and snd-bt87x have the same
problem that snd-via82xx... doesnt identify the card... but at least i can
manually set the boot_all parameter....
this tv card was correctly detected with my last motherboard asus a7v-600
(kt600)

i alsa tried to build alsa into the kernel (not like modules), but i get
the same results

any idea?
======================================================================

----------------------------------------------------------------------
 tiwai - 04-19-05 17:25 
----------------------------------------------------------------------
Check lspci whether you have the entry for VIA8233/8235/8237.  If not, it's
likely a BIOS configuration that you disabled the onboard sound.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-19-05 08:54 El Santo       New Issue                                    
04-19-05 08:54 El Santo       Distribution              => linux from scratch
04-19-05 08:54 El Santo       Kernel Version            => 2.6.11.7        
04-19-05 17:25 tiwai          Note Added: 0004520                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
