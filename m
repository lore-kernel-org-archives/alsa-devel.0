From: Shaju Abraham <shaju@multitech.co.in>
Subject: xrun and snd_pcm_prepare.
Date: Mon, 16 Sep 2002 14:26:40 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D859CC8.7323C2E@multitech.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mtsslvpngway ([202.54.39.98])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id KAA09882
	for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2002 10:58:41 +0200
Received: from multitech.co.in ([192.168.1.48])
	by multitech.co.in (8.12.1/8.12.1) with ESMTP id g8G8wl2r016030
	for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2002 14:28:47 +0530
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Hi,
    In aplay utility to playback music, we see that if the return value
is -EPIPE, a function xrun() is called. This function does nothing more
than snd_pcm_prepare(handle).  What is the meaning of receiving a -EPIPE
return value to a application? and, Why cannot this be done at the
driver level itself? say in pcm_native.c .

Is it ok if this snd_pcm_prepare is called from pcm_native.c instead of
returning -EPIPE to the application?

--Shaju Abraham


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
