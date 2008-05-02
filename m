From: Sean McNamara <smcnam@gmail.com>
Subject: Re: error using aplay
Date: Fri, 02 May 2008 13:57:46 -0400
Message-ID: <481B561A.9010509@gmail.com>
References: <481B446C.20800@carallon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.156])
	by alsa0.perex.cz (Postfix) with ESMTP id F2F372438B
	for <alsa-devel@alsa-project.org>;
	Fri,  2 May 2008 19:57:55 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so560302ywk.2
	for <alsa-devel@alsa-project.org>; Fri, 02 May 2008 10:57:50 -0700 (PDT)
In-Reply-To: <481B446C.20800@carallon.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Will Wagner <will_wagner@carallon.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

It's possible that your chipset driver doesn't natively support one of 
the parameters of the soundfile you're trying to play (endianness, bit 
width, sample rate, etc.) or one of the software parameters that aplay 
is requesting (period size, hw buffer size, etc). In the hardware params 
case,  invoking the alsa-lib plug layer will solve practically any 
hardware params problem. You can invoke the plug layer as such:
aplay -vvv -Dplug:fixme /path/to/file.wav
where you substitute your real ALSA device for "fixme". Plug is also 
sometimes useful in the software params case, but this is usually a 
problem the ALSA client has to fix themselves (to be more flexible).

Your debugging efforts may actually point to an ALSA bug -- on your 
platform/hardware, obviously, since we don't have this kind of problem 
on x86 with, say, HDA Intel sound -- but at the same time, half of the 
difficulties with ALSA are due to not taking advantage of the plugin 
layer, of which "plug" is a great example.

With this general class of problems, rather than delving right into the 
code, I tend to suggest the following:

1. Please post the console output of
aplay -vvv -Dfixme /path/to/some/file.wav
so that we can see what code paths aplay is taking.
2. Please try the plug layer as stated above.
3. Please tell us what version of ALSA you're using, and what ALSA 
module(s) need to be loaded in the kernel for your hardware to work.

One final note about your problem: it's possible that alsa-lib is using 
__old_snd_pcm_hw_params_get_period_size() because your ALSA lib and ALSA 
kernel versions are disjoint. If alsa-lib's current 
snd_pcm_hw_params_get_period_size() implementation expects kernel 
interfaces not available in your ALSA kernel build, that would be one 
plausible explanation. But of course, without knowing any ALSA versions 
or kernel modules you're using, I can't go into any more detail.

HTH,

Sean

Will Wagner wrote:
> I have cross compiled alsa-lib & alsa-utils for my arm platform. All 
> appears to be working as speaker_test works fine (and have had the 
> kernel sound driver working previously).
>
> However when I try to play a wav file with aplay it fails. This is 
> because in set_params(), after initialising the hardware (which happens 
> with no errors), it then tries to read back the period_size with the call:
>
> 	snd_pcm_hw_params_get_period_size(params, &chunk_size, 0);
>
> Which for the file I am playing should return 2048 but instead returns 
> zero. After that it reallocs the buffer to zero size and exits. To try 
> to work out what's going wrong I have been debugging this and inspecting 
> params get the following:
>
> (gdb) p *params
> $21 = {flags = 0, masks = {{bits = {8, 0, 0, 0, 0, 0, 0, 0}}, {bits = 
> {4, 0,
>          0, 0, 0, 0, 0, 0}}, {bits = {1, 0, 0, 0, 0, 0, 0, 0}}}, mres =
> {{
>        bits = {0, 0, 0, 0, 0, 0, 0, 0}}, {bits = {0, 0, 0, 0, 0, 0, 0,
> 0}}, {
>        bits = {0, 0, 0, 0, 0, 0, 0, 0}}, {bits = {0, 0, 0, 0, 0, 0, 0,
> 0}}, {
>        bits = {0, 0, 0, 0, 0, 0, 0, 0}}}, intervals = {{min = 16, max =
> 16,
>        openmin = 0, openmax = 0, integer = 1, empty = 0}, {min = 32, max
> = 32,
>        openmin = 0, openmax = 0, integer = 1, empty = 0}, {min = 2, max =
> 2,
>        openmin = 0, openmax = 0, integer = 1, empty = 0}, {min = 22050,
>        max = 22050, openmin = 0, openmax = 0, integer = 1, empty = 0}, {
>        min = 92879, max = 92880, openmin = 1, openmax = 1, integer = 0,
>        empty = 0}, {min = 2048, max = 2048, openmin = 0, openmax = 0,
>        integer = 1, empty = 0}, {min = 8192, max = 8192, openmin = 0,
>        openmax = 0, integer = 1, empty = 0}, {min = 5, max = 5, openmin =
> 0,
>        openmax = 0, integer = 1, empty = 0}, {min = 464399, max = 464400,
>        openmin = 1, openmax = 1, integer = 0, empty = 0}, {min = 10240,
>        max = 10240, openmin = 0, openmax = 0, integer = 1, empty = 0}, {
>        min = 40960, max = 40960, openmin = 0, openmax = 0, integer = 1,
>        empty = 0}, {min = 10000, max = 10000, openmin = 0, openmax = 0,
>        integer = 1, empty = 0}}, ires = {{min = 0, max = 0, openmin = 0,
>        openmax = 0, integer = 0, empty = 0}, {min = 0, max = 0, openmin =
> 0,
>        openmax = 0, integer = 0, empty = 0}, {min = 0, max = 0, openmin =
> 0,
>        openmax = 0, integer = 0, empty = 0}, {min = 0, max = 0, openmin =
> 0,
>        openmax = 0, integer = 0, empty = 0}, {min = 0, max = 0, openmin =
> 0,
>        openmax = 0, integer = 0, empty = 0}, {min = 0, max = 0, openmin =
> 0,
>        openmax = 0, integer = 0, empty = 0}, {min = 0, max = 0, openmin =
> 0,
>        openmax = 0, integer = 0, empty = 0}, {min = 0, max = 0, openmin =
> 0,
>        openmax = 0, integer = 0, empty = 0}, {min = 0, max = 0, openmin =
> 0,
>        openmax = 0, integer = 0, empty = 0}}, rmask = 0, cmask = 1048327,
>    info = 65795, msbits = 16, rate_num = 22050, rate_den = 1, fifo_size =
> 0,
>    reserved = '\0' <repeats 63 times>}
>
>
> My reading of this is that period_size is correct at 2048, however 
> openmin is 0 (dont' know what openmin is all about). So inspecting the 
> code I thought this should all work. However it appears that there is 
> some magic going on with functions being redirected as a backtrace shows:
>
> (gdb) bt
> #0  __snd_pcm_hw_params_get_period_size (params=0xbef44700,
> val=0xbef44674,
>      dir=0x2166c) at pcm.c:4263
> #1  0x4006f1c8 in __old_snd_pcm_hw_params_get_period_size
> (params=0xbef44700,
>      dir=0x2166c) at pcm.c:6822
> #2  0x0000eda0 in set_params () at aplay.c:983
> #3  0x00014004 in playback_go (fd=4, loaded=0, count=171008, rtype=2,
>      name=0xbef44de7 "/sdcard/sounds/tada.wav") at aplay.c:1950
> #4  0x000147b8 in playback (name=0xbef44de7 "/sdcard/sounds/tada.wav")
>      at aplay.c:2042
> #5  0x0000c8c4 in main (argc=3, argv=0xbef44ce4) at aplay.c:615
>
> It seems the call is somehow being redirected through 
> __old_snd_pcm_hw_params_get_period_size and the implementation of this 
> means that I end up returning openmin instead of min for period_size.
>
> Can someone explain what is going on here? Why am I being redirected 
> through this old function? Is it correct that I should be reading 
> openmin here?
>
> Any help much appreciated.
>
> Will.
>
>
>
>   
