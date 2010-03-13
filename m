From: Matija Nalis <mnalis-alsadev@voyager.hr>
Subject: cmipci and sound skipping ?
Date: Sat, 13 Mar 2010 21:11:38 +0100
Message-ID: <20100313201138.GA25034@eagle102.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx01.voyager.hr (mx01.voyager.hr [83.139.110.18])
	by alsa0.perex.cz (Postfix) with ESMTP id 8DF111037F1
	for <alsa-devel@alsa-project.org>; Sat, 13 Mar 2010 21:12:00 +0100 (CET)
Content-Disposition: inline
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

My card is "Asonic C-Media8738, 4 channel" and mostly works with snd_cmipci
driver - it is just that (even on completely unloaded system) the sound is
(very annoyingly) skipping. The speaker-test application throws out "Write
error: -32,Broken pipe" errors on every skip (usually every 5-30 times a
wav is played). mpg321 is much worse (every few seconds it clips the sample)
making the listening to music unedurable.

I'm using Debian Lenny with kernel 2.6.26 (also tried 2.6.32, no change)
I've upgraded to the latest snapshot of driver, lib and utils as
recommended, the bug is still there. When driver is compiled with debug, on
every skip it throws out lines in dmesg with info as:

ALSA pcm_lib.c:316: BUG: pcmC0D0p:0, pos = 4294918144, buffer size = 16384, period size = 1024

Note that the pos is *always* the same (4294918144 = 0xffff4000 = -16384) which might be important.

I've reported the problem in bug #4899 at
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4899
(alsa-info.sh and more is attached there)

There I got pointer to contact the alsa-devel list with XRUN_Debug info.

So here it is. When I enable it with "echo 101 > /proc/asound/card0/pcm0p/xrun_debug"
I get the following output :

[33802.573395] ALSA pcm_lib.c:249: hwptr log: pcmC0D0p:0: j=4302816904, pos=1037/1024/16384, hwptr=230413/229376
[33802.573395] ALSA pcm_lib.c:249: hwptr log: pcmC0D0p:0: j=4302816909, pos=2052/1024/16384, hwptr=230413/229376
[33802.573395] ALSA pcm_lib.c:249: hwptr log: pcmC0D0p:0: j=4302816909, pos=2053/1024/16384, hwptr=231428/229376
[33802.573395] ALSA pcm_lib.c:249: hwptr log: pcmC0D0p:0: j=4302816909, pos=2053/1024/16384, hwptr=231429/229376
[33802.573395] ALSA pcm_lib.c:249: hwptr log: pcmC0D0p:0: j=4302816909, pos=2053/1024/16384, hwptr=231429/229376
[33802.573395] ALSA pcm_lib.c:249: hwptr log: pcmC0D0p:0: j=4302816909, pos=2053/1024/16384, hwptr=231429/229376
[33802.573395] ALSA pcm_lib.c:249: hwptr log: pcmC0D0p:0: j=4302816909, pos=2061/1024/16384, hwptr=231429/229376
[33802.573395] ALSA pcm_lib.c:249: hwptr log: pcmC0D0p:0: j=4302816909, pos=2061/1024/16384, hwptr=231437/229376
[33802.573395] ALSA pcm_lib.c:249: hwptr log: pcmC0D0p:0: j=4302816914, pos=3076/1024/16384, hwptr=231437/229376
[33802.573395] ALSA pcm_lib.c:249: hwptr log: pcmC0D0p:0: j=4302816914, pos=3076/1024/16384, hwptr=232452/229376
[33802.573395] ALSA pcm_lib.c:316: BUG: pcmC0D0p:0, pos = 4294918144, buffer size = 16384, period size = 1024
[33802.573395] ALSA pcm_lib.c:415: PCM: hw_ptr skipping! (pos=0, delta=13308, period=1024, jdelta=0/69/0, hw_ptr=232452/232452)
[33806.867658] ALSA pcm_lib.c:316: BUG: pcmC0D0p:0, pos = 4294918144, buffer size = 16384, period size = 1024
[33806.867666] ALSA pcm_lib.c:415: PCM: hw_ptr skipping! (pos=0, delta=16380, period=1024, jdelta=0/85/0, hw_ptr=425988/425988)

Also it seems that enabling xrun_debug kludges around the bug - the
annoying skipping (and "Write error: -32,Broken pipe" errors in
speaker-test) disappears or at least becomes almost inaudiable.

Would some other xrun_debug setting be more useful to give better insight ?
Anything else I can provide or test to help debug the problem ?

Please CC: me as I'm not subscribed to the list.

-- 
Opinions above are GNU-copylefted.
