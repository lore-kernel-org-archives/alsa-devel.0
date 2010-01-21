From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Problem with PPH plugin
Date: Thu, 21 Jan 2010 14:29:34 +0000
Message-ID: <4B5864CE.4090807@colin.guthr.ie>
References: <hj4rap$ofp$2@ger.gmane.org>
	<s5hr5pljj7a.wl%tiwai@suse.de>	<loom.20100120T231250-50@post.gmane.org>	<s5hfx60csn8.wl%tiwai@suse.de>
	<loom.20100121T115627-815@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 956912443D
	for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2010 15:29:55 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.50) id 1NXy2j-0005zU-2J
	for alsa-devel@alsa-project.org; Thu, 21 Jan 2010 15:29:53 +0100
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2010 15:29:53 +0100
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2010 15:29:53 +0100
In-Reply-To: <loom.20100121T115627-815@post.gmane.org>
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
Cc: Anton Yashin <fynjy-007@yandex.ru>
List-Id: alsa-devel@alsa-project.org

'Twas brillig, and Anton Yashin at 21/01/10 11:19 did gyre and gimble:
> One more thing. Raymond	says:
>> is flashsupport.c the source code of libflashplayer.so 
>>
>> http://labs.adobe.com/wiki/index.php/Flash_Player:Additional_Interface_Support_for_Linux
> [^]
>>
>> It seem that there are some bugs in flashsupport.c 
>>
>>
>> #14 0xb5ae6379 in snd_pcm_mmap_writei (pcm=0xb0c96ac0, buffer=0xaa1ae000,
> size=940) at pcm_mmap.c:186
>> #15 0xb5ad415e in _snd_pcm_writei (size=<value optimized out>, buffer=<value
> optimized out>, pcm=<value optimized out>) at pcm_local.h:516
>> #16 snd_pcm_writei (size=<value optimized out>, buffer=<value optimized out>,
> pcm=<value optimized out>) at pcm.c:1247
>> #17 0xab01acd4 in ?? () from /usr/lib/browser-plugins/libflashplayer.so
>> #18 0xab01af15 in ?? () from /usr/lib/browser-plugins/libflashplayer.so
>> #19 0xb7e876e5 in start_thread (arg=0x0) at pthread_create.c:297
>> #20 0xb7e87600 in ?? () at pthread_create.c:216 from /lib/libpthread.so.0
> 
> at https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4878
> 
> Later I will send a bug in the adobe.

I'm not sure where Raymond sees flashsupport.c...

Could it be that you have libflashsupport.so (probably in /usr/lib/) on
your system somewhere? If so you should try removing it (e.g. finding
which package owns the file - rpm -qf <file> - and then removing the
package) and see if the problem goes away.

It's used to extend Flash player and I guess it could be cocking up
somewhere or other.

Col

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mandriva Linux Contributor [http://www.mandriva.com/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
