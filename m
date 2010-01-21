From: Anton Yashin <fynjy-007@yandex.ru>
Subject: Re: Problem with PPH plugin
Date: Thu, 21 Jan 2010 11:19:24 +0000 (UTC)
Message-ID: <loom.20100121T115627-815@post.gmane.org>
References: <hj4rap$ofp$2@ger.gmane.org> <s5hr5pljj7a.wl%tiwai@suse.de>
	<loom.20100120T231250-50@post.gmane.org>
	<s5hfx60csn8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id F42322435F
	for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2010 12:19:53 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.50) id 1NXv4n-0000yn-Nl
	for alsa-devel@alsa-project.org; Thu, 21 Jan 2010 12:19:49 +0100
Received: from 95-29-147-16.broadband.corbina.ru ([95.29.147.16])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2010 12:19:49 +0100
Received: from fynjy-007 by 95-29-147-16.broadband.corbina.ru with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2010 12:19:49 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai <at> suse.de> writes:

> OK, just one more thing to be sure -- does this happen also with samplerate
> plugin?  I suppose it's PPH specific, but it's not clear whether this comes
> from the PCM core side or just in the SRC side.
> 

You mean alsa-plugins-samplerate ? No this issue exists if alsa-plugins is
installed. Installing or uninstalling alsa-plugins-samplerate does not change
the situation.

> Also, did you see any similar error with other apps?
> 
> thanks,
> 
> Takashi
> 

There is unique to firefox. Is the only browser that makes sounds. The rest
multithreaded audio output is working properly. For example i can watch two
videos at once on youtube.

One more thing. Raymond	says:
>is flashsupport.c the source code of libflashplayer.so 
>
>http://labs.adobe.com/wiki/index.php/Flash_Player:Additional_Interface_Support_for_Linux
[^]
>
>It seem that there are some bugs in flashsupport.c 
>
>
>#14 0xb5ae6379 in snd_pcm_mmap_writei (pcm=0xb0c96ac0, buffer=0xaa1ae000,
size=940) at pcm_mmap.c:186
>#15 0xb5ad415e in _snd_pcm_writei (size=<value optimized out>, buffer=<value
optimized out>, pcm=<value optimized out>) at pcm_local.h:516
>#16 snd_pcm_writei (size=<value optimized out>, buffer=<value optimized out>,
pcm=<value optimized out>) at pcm.c:1247
>#17 0xab01acd4 in ?? () from /usr/lib/browser-plugins/libflashplayer.so
>#18 0xab01af15 in ?? () from /usr/lib/browser-plugins/libflashplayer.so
>#19 0xb7e876e5 in start_thread (arg=0x0) at pthread_create.c:297
>#20 0xb7e87600 in ?? () at pthread_create.c:216 from /lib/libpthread.so.0

at https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4878

Later I will send a bug in the adobe.

Thanks,

Anton
