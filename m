From: Sundaranathan S <snathan@siptech.co.in>
Subject: Regarding global.h
Date: Mon, 23 Jun 2003 11:57:54 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EF73192.58E52113@siptech.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from hummingbird.siptech.co.in ([202.54.64.122])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id IAA04676
	for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2003 08:17:08 +0200
Received: from hornet.siptech.co.in (IDENT:root@[192.168.64.13])
	by hummingbird.siptech.co.in (8.11.6/8.11.6) with ESMTP id h5N5ar210799
	for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2003 11:06:55 +0530
Received: from siptech.co.in ([192.168.64.193])
	by hornet.siptech.co.in (8.11.0/8.11.0) with ESMTP id h5NHkJr08046
	for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2003 23:16:20 +0530
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi All,

        While compiling ALSA libraries i am getting an error which is
stated below

                    control.c: In function `snd_ctl_open_conf':
                    control.c:581: `_dlsym_control_001' undeclared
(first use in this function)
                    control.c:581: (Each undeclared identifier is
reported only once


Can anyone let me know how to solve this problem and also please explain
what does __STRING(version) in global.h means.

thanks in advance,
Sundaranathan
SIP Technologies & Exports Ltd.




-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
