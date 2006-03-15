From: "Joe Hsu" <nagual.hsu@gmail.com>
Subject: snd_pcm_hwsync
Date: Wed, 15 Mar 2006 20:06:49 +0800
Message-ID: <7fe205990603150406i5e61842fh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.197])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D28621FD
	for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2006 13:06:50 +0100 (MET)
Received: by zproxy.gmail.com with SMTP id i11so96671nzh
        for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2006 04:06:49 -0800 (PST)
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

Hi all:
    Sometimes, snd_pcm_hwsync would return -32 (-EPIPE).
I can't see why. After snd_pcm_hwsync failed, snd_pcm_avail_update
would return a much bigger positive value than pcm_hw_bufsize.

    Can any one tell me why? and how to avoid such questions?

--
The sun is shinny but the ice is slippery.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
