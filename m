From: Will Wagner <will_wagner@carallon.com>
Subject: error using aplay
Date: Fri, 02 May 2008 17:42:20 +0100
Message-ID: <481B446C.20800@carallon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from carallon.f9.co.uk (carallon.force9.co.uk [80.229.37.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 775B124376
	for <alsa-devel@alsa-project.org>;
	Fri,  2 May 2008 18:42:26 +0200 (CEST)
Received: from [127.0.0.1] by carallon.f9.co.uk (MDaemon PRO v9.6.5)
	with ESMTP id md50000227303.msg
	for <alsa-devel@alsa-project.org>; Fri, 02 May 2008 17:42:23 +0100
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

I have cross compiled alsa-lib & alsa-utils for my arm platform. All 
appears to be working as speaker_test works fine (and have had the 
kernel sound driver working previously).

However when I try to play a wav file with aplay it fails. This is 
because in set_params(), after initialising the hardware (which happens 
with no errors), it then tries to read back the period_size with the call:

	snd_pcm_hw_params_get_period_size(params, &chunk_size, 0);

Which for the file I am playing should return 2048 but instead returns 
zero. After that it reallocs the buffer to zero size and exits. To try 
to work out what's going wrong I have been debugging this and inspecting 
params get the following:

(gdb) p *params
$21 = {flags = 0, masks = {{bits = {8, 0, 0, 0, 0, 0, 0, 0}}, {bits = 
{4, 0,
         0, 0, 0, 0, 0, 0}}, {bits = {1, 0, 0, 0, 0, 0, 0, 0}}}, mres =
{{
       bits = {0, 0, 0, 0, 0, 0, 0, 0}}, {bits = {0, 0, 0, 0, 0, 0, 0,
0}}, {
       bits = {0, 0, 0, 0, 0, 0, 0, 0}}, {bits = {0, 0, 0, 0, 0, 0, 0,
0}}, {
       bits = {0, 0, 0, 0, 0, 0, 0, 0}}}, intervals = {{min = 16, max =
16,
       openmin = 0, openmax = 0, integer = 1, empty = 0}, {min = 32, max
= 32,
       openmin = 0, openmax = 0, integer = 1, empty = 0}, {min = 2, max =
2,
       openmin = 0, openmax = 0, integer = 1, empty = 0}, {min = 22050,
       max = 22050, openmin = 0, openmax = 0, integer = 1, empty = 0}, {
       min = 92879, max = 92880, openmin = 1, openmax = 1, integer = 0,
       empty = 0}, {min = 2048, max = 2048, openmin = 0, openmax = 0,
       integer = 1, empty = 0}, {min = 8192, max = 8192, openmin = 0,
       openmax = 0, integer = 1, empty = 0}, {min = 5, max = 5, openmin =
0,
       openmax = 0, integer = 1, empty = 0}, {min = 464399, max = 464400,
       openmin = 1, openmax = 1, integer = 0, empty = 0}, {min = 10240,
       max = 10240, openmin = 0, openmax = 0, integer = 1, empty = 0}, {
       min = 40960, max = 40960, openmin = 0, openmax = 0, integer = 1,
       empty = 0}, {min = 10000, max = 10000, openmin = 0, openmax = 0,
       integer = 1, empty = 0}}, ires = {{min = 0, max = 0, openmin = 0,
       openmax = 0, integer = 0, empty = 0}, {min = 0, max = 0, openmin =
0,
       openmax = 0, integer = 0, empty = 0}, {min = 0, max = 0, openmin =
0,
       openmax = 0, integer = 0, empty = 0}, {min = 0, max = 0, openmin =
0,
       openmax = 0, integer = 0, empty = 0}, {min = 0, max = 0, openmin =
0,
       openmax = 0, integer = 0, empty = 0}, {min = 0, max = 0, openmin =
0,
       openmax = 0, integer = 0, empty = 0}, {min = 0, max = 0, openmin =
0,
       openmax = 0, integer = 0, empty = 0}, {min = 0, max = 0, openmin =
0,
       openmax = 0, integer = 0, empty = 0}, {min = 0, max = 0, openmin =
0,
       openmax = 0, integer = 0, empty = 0}}, rmask = 0, cmask = 1048327,
   info = 65795, msbits = 16, rate_num = 22050, rate_den = 1, fifo_size =
0,
   reserved = '\0' <repeats 63 times>}


My reading of this is that period_size is correct at 2048, however 
openmin is 0 (dont' know what openmin is all about). So inspecting the 
code I thought this should all work. However it appears that there is 
some magic going on with functions being redirected as a backtrace shows:

(gdb) bt
#0  __snd_pcm_hw_params_get_period_size (params=0xbef44700,
val=0xbef44674,
     dir=0x2166c) at pcm.c:4263
#1  0x4006f1c8 in __old_snd_pcm_hw_params_get_period_size
(params=0xbef44700,
     dir=0x2166c) at pcm.c:6822
#2  0x0000eda0 in set_params () at aplay.c:983
#3  0x00014004 in playback_go (fd=4, loaded=0, count=171008, rtype=2,
     name=0xbef44de7 "/sdcard/sounds/tada.wav") at aplay.c:1950
#4  0x000147b8 in playback (name=0xbef44de7 "/sdcard/sounds/tada.wav")
     at aplay.c:2042
#5  0x0000c8c4 in main (argc=3, argv=0xbef44ce4) at aplay.c:615

It seems the call is somehow being redirected through 
__old_snd_pcm_hw_params_get_period_size and the implementation of this 
means that I end up returning openmin instead of min for period_size.

Can someone explain what is going on here? Why am I being redirected 
through this old function? Is it correct that I should be reading 
openmin here?

Any help much appreciated.

Will.



-- 
------------------------------------------------------------------------
Will Wagner                                     will_wagner@carallon.com
Senior Project Engineer                  Office Tel: +44 (0)20 7371 2032
Carallon Ltd, Studio G20, Shepherds Building, Rockley Rd, London W14 0DA
------------------------------------------------------------------------
