From: boku <boku0712@gmail.com>
Subject: Error - Unable to handle kernel paging request at virtual address- while trying to cat /dev/snd/pcmC0D0p device
Date: Fri, 24 Feb 2006 10:59:47 +0800
Message-ID: <715d90900602231859h125155ew8dd4b3fd43bafd7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.195])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3CF1618F
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2006 03:59:47 +0100 (MET)
Received: by zproxy.gmail.com with SMTP id i11so215675nzh
        for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2006 18:59:47 -0800 (PST)
Content-Disposition: inline
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

Dear all,
    I tried to use cat > /dev/snd/pcmC0D0p to have an intial test. But
the kernel reports error and segmentation fault. The PC is at
mst1xx_i2s_startup() which request down()
The message is as follows:
---
soc: WM8731 <-> mst1xx-i2s info:
soc: rate mask 0x6fe
soc: min ch 2 max ch 2
soc: min rate 8000 max rate 96000
Unable to handle kernel paging request at virtual address 1c02b08e   <=3D=
=3D=3D=3D=3D=3D
pgd =3D c7ae8000
[1c02b08e] *pgd=3D00000000
Internal error: Oops: 5 [#1]
CPU: 0
PC is at mst1xx_i2s_startup+0x4c/0xa0 [snd_soc_mst1xx_i2s]
LR is at 0x0
pc : [<bf02f04c>]    lr : [<00000000>]    Not tainted
sp : c78b9de0  ip : bf02fa40  fp : c78b9dec
r10: 00000000  r9 : 00000026  r8 : c7b13000
r7 : 00000000  r6 : 00000002  r5 : c7eb8580  r4 : 00000000
r3 : 00000000  r2 : 1c02b08e  r1 : bf02f8dc  r0 : 00000001
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  Segment user


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
