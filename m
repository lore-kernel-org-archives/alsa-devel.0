From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001027]: Linux 2.4 oops
Date: Thu, 31 Mar 2005 08:03:47 +0200
Message-ID: <d1b6e2df9602af0d270ee747e1320c07@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id F0A61261
	for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2005 08:03:47 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1027> 
======================================================================
Reported By:                mdarwin
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1027
Category:                   OTHERS
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               debian
Kernel Version:             Linux elk 2.4.27-2-k7
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 Thu Jan 20 11:25:34 JST
2005 i686 GNU/L
======================================================================
Date Submitted:             03-31-2005 08:03 CEST
Last Modified:              03-31-2005 08:03 CEST
======================================================================
Summary:                    Linux 2.4 oops
Description: 
(from dmesg)

intel8x0_measure_ac97_clock: measured 41953 usecs
intel8x0: clocking to 46651
Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
f8a74a85
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<f8a74a85>]    Tainted: PF
EFLAGS: 00010203
eax: 00000006   ebx: f5dd1f14   ecx: f5e55cc0   edx: 00000000
esi: 00000000   edi: f5dd1f74   ebp: f5e55cc0   esp: f5dd1ef8
ds: 0018   es: 0018   ss: 0018
Process artsd (pid: 4763, stackpage=f5dd1000)
Stack: bffff058 f8a7598a f5e55cc0 f5dd1f14 00000000 f5dd1f34 f7216400
00000006
       00000000 00000000 00000000 00000005 00000001 00000000 00000000
00008002
       00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
Call Trace:    [<f8a7598a>] [<f8a75cf4>] [<c014bb6b>] [<c013cc39>]
[<c0108a7f>]

Code: 89 02 8b 43 04 89 42 04 8b 43 08 89 42 08 8b 43 0c 89 42 0c
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-31-05 08:03 mdarwin        New Issue                                    
03-31-05 08:03 mdarwin        Distribution              => debian          
03-31-05 08:03 mdarwin        Kernel Version            => Linux elk 2.4.27-2-k7
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 Thu Jan 20 11:25:34 JST
2005 i686 GNU/L
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
