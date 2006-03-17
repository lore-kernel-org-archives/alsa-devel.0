From: "Joe Hsu" <nagual.hsu@gmail.com>
Subject: libaoss.so hole?
Date: Fri, 17 Mar 2006 21:12:25 +0800
Message-ID: <7fe205990603170512j58c63e4es@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.203])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DF4EC171
	for <alsa-devel@alsa-project.org>; Fri, 17 Mar 2006 14:12:27 +0100 (MET)
Received: by zproxy.gmail.com with SMTP id i11so542849nzh
        for <alsa-devel@alsa-project.org>; Fri, 17 Mar 2006 05:12:25 -0800 (PST)
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

    I've tested over and over. With my limited number of computers,
I've found this problem only happens in the computers with intel8x0
audio chips:

    I have an oss application which registers SIGCHLD signal handler
in the beginning and then opens /dev/dsp, and then forks a child
process. If the child process dies, the father process would receive a
SIGCHLD process and then free the allocated resources and then exit.

    Without pre-loading libaoss.so, everything goes well. With
libaoss.so pre-loaded, my applications exit in the computers with
intel8x0 audio chips because my application receives SIGCHLD signal
and thinks its process were dead. But in fact, it does not fork the
child process yet.

    After I turn on the ALSA_OSS_DEBUG environment variable,
libaoss.so first tried to open /dev/dsp0 but in vain. Then it tried a
alsa-default device successfully. I can see that every time libaoss.so
tries to opena pcm device with a new thread. And thta's the source of
the un-expected SIGCHLD signal.

    However, other computers with other audio chips go through the
same process (/dev/dsp0 failed and then alsa-default  device
successfully), but my application does not receive any un-expected
SIGCHLD signal before forking its own child process.

    I guess this is a hole. Any body thinks so ?


--
The sun is shinny but the ice is slippery.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
