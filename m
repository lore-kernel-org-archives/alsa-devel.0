From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000610]: Abit AV8 entry required for programs that do not use 48k (Fix inside)
Date: Wed, 27 Oct 2004 04:23:11 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <bc7b3dff722da0b7fc643afa9ec55277@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7ECCD2F9
	for <alsa-devel@alsa-project.org>; Wed, 27 Oct 2004 04:23:11 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=610> 
======================================================================
Reported By:                badbunny
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   610
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 3 X86_64
Kernel Version:             2.6.9
======================================================================
Date Submitted:             10-27-2004 01:37 CEST
Last Modified:              10-27-2004 04:23 CEST
======================================================================
Summary:                    Abit AV8 entry required for programs that do not use
48k (Fix inside)
Description: 
For programs such as Doom 3 or aplay (that use 41k channels)...This card in
it's current state of only accepting 48k streams is not working out for
these type programs. Adding the following to the whitelist[] in via82xx.c
resolves this problem:

{ .vendor = 0x147b, .device = 0x1415, .action = VIA_DXS_NO_VRA }, /* Abit
AV8 */

I have have fully tested this. I also ran using VIA_DXS_ENABLE, but it
causes a hiss in the sound. So this works the best. Without this users
whould just have to know to set "dxs_support=4"...I think it's best this
be in the driver.

Below is lspci output:
lspci -nvs 00:11.5
00:11.5 Class 0401: 1106:3059 (rev 60)
        Subsystem: 147b:1415
        Flags: medium devsel, IRQ 177
        I/O ports at e400 [size=256]
        Capabilities: [c0] Power Management version 2

lspci -vs 00:11.5
00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
        Subsystem: ABIT Computer Corp.: Unknown device 1415
        Flags: medium devsel, IRQ 177
        I/O ports at e400 [size=256]
        Capabilities: [c0] Power Management version 2

======================================================================

----------------------------------------------------------------------
 badbunny - 10-27-04 03:06 
----------------------------------------------------------------------
This also fixes a problem with gstreamer and alsasink plugin interaction
with this card.

----------------------------------------------------------------------
 badbunny - 10-27-04 04:23 
----------------------------------------------------------------------
one last remark...wouldn't it be better behavior for the via82xx to set
cards to VIA_DXS_NO_VRA rather than VIA_DXS_48K when it does not know the
card. I'm not familiar with all the sound cards that use this, but for
future cards I see this as being better behavior for the driver & less
headache for the user.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-27-04 01:37 badbunny       New Issue                                    
10-27-04 01:37 badbunny       Distribution              => Fedora Core 3 X86_64
10-27-04 01:37 badbunny       Kernel Version            => 2.6.9           
10-27-04 03:06 badbunny       Note Added: 0002271                          
10-27-04 04:23 badbunny       Note Added: 0002272                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
