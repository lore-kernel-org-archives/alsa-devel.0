From: Vince Busam <vince@sixpak.org>
Subject: Re: Fix for slow snd-ali5451 initialization
Date: Sat, 5 Nov 2005 18:14:50 -0800 (PST)
Message-ID: <Pine.LNX.4.61.0511051805250.17655@sixpak.sixpak.org>
References: <Pine.LNX.4.61.0511051136400.16526@sixpak.sixpak.org>
 <1131222132.13627.19.camel@mindpipe>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1131222132.13627.19.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ubuntu and Fedora both wait until the driver is loaded.  If I don't load 
the driver on bootup, and manually load it later, the whole system will 
freeze for 10 seconds while the driver loads.

This function (snd_ali_codec_ready) fails 4 times during initialization, 
no matter how long it waits.  Why does it have to wait for 2.5 seconds 
each time?  As you can see, that total comes to 10 seconds.  Dropping the 
timeout here brings that down to a tolerable level with no ill effects for 
me.  A better fix might be to figure out why it's being called 4 times at 
all when it's going to fail, but I certainly don't know enough about this 
chip or driver to know if that's the case.

Vince

--- alsa-driver-1.0.10rc2/alsa-kernel/pci/ali5451/ali5451.c.orig        2005-11-05 18:01:22.000000000 -0800
+++ alsa-driver-1.0.10rc2/alsa-kernel/pci/ali5451/ali5451.c     2005-11-05 18:04:45.000000000 -0800
@@ -391,7 +391,7 @@ static int snd_ali_codec_ready(     ali_t *c
         unsigned long end_time;
         unsigned int res;

-       end_time = jiffies + 10 * msecs_to_jiffies(250);
+       end_time = jiffies + msecs_to_jiffies(150);
         do {
                 res = snd_ali_5451_peek(codec,port);
                 if (! (res & 0x8000))


On Sat, 5 Nov 2005, Lee Revell wrote:

> On Sat, 2005-11-05 at 11:38 -0800, Vince Busam wrote:
>> The snd-ali5451 driver takes 10 seconds to load, which is quite annoying
>> on a laptop that boots every day.  This patch lowers that to a much more
>> managable time, and still works fine on my laptop.
>>
>> Vince
>>
>>      Summary: Speed up ali5451 initialization
>>
>>      The patch speeds up loading the ali5451 driver by lowering the
>>      wait time in snd_ali_codec_ready()
>
> Does not apply against current ALSA or kernel sources.  Please provide
> an updated patch.
>
> Also, why is this an issue?  Do your distros init scripts delay the boot
> until this driver is loaded?  Shouldn't it be loading all drivers in
> parallel?
>
> Lee
>

-- 
Vince Busam
vince@sixpak.org
http://sixpak.org/vince/


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
