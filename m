From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: kernel oops - snd-usb-audio
Date: Tue, 26 Nov 2002 02:24:06 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DE25CB6.9080008@boosthardware.com>
References: <3DE18DA6.3050503@boosthardware.com> <3DE1BB0D.90000@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Advanced Linux Sound Architecture Driver Version 0.9.0rc6.
Compiled on Nov 15 2002 for kernel 2.4.19 with versioned symbols.

I got an oops while playing with jackd. This probably happened while 
trying to do duplex with all four channels at 44100hz. I'm trying to 
figure out how to get capture working for four channels instead of two. 
I was able to get jack to do playback only with them although I haven't 
tested to see if the streams are independant or copied. Last time I 
tried they were copied. ie. channel 1&2=3&4 respectively.

Here's the oops:

--------
dmesg:

ALSA ../alsa-kernel/usb/usbaudio.c:1037: 4:8:4: cannot set freq 44100 to 
ep 0x86
ALSA ../alsa-kernel/usb/usbaudio.c:1037: 4:8:4: cannot set freq 44100 to 
ep 0x86
.
.
.
.
ALSA ../alsa-kernel/usb/usbaudio.c:1037: 4:8:4: cannot set freq 44100 to 
ep 0x86
ALSA ../alsa-kernel/usb/usbaudio.c:1037: 4:8:4: cannot set freq 44100 to 
ep 0x86
Unable to handle kernel NULL pointer dereference at virtual address 00000098
  printing eip:
d8a27614
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<d8a27614>]    Tainted: P
EFLAGS: 00013246
eax: 00000000   ebx: 00000000   ecx: c5427480   edx: c5427480
esi: 00000000   edi: fffffffa   ebp: c5427680   esp: c94e7f30
ds: 0018   es: 0018   ss: 0018
Process jackd (pid: 2743, stackpage=c94e7000)
Stack: d671715c d7290c00 c5427480 00000000 d8a20ec9 c5427480 00000000 
00000000
        c5427680 00004140 bf3ff8e4 00000009 d8a22d3b c5427680 00004140 
bf3ff8e4
        0000002f c01a9d0d d746c000 c94e6000 ca7ca100 c0115ad3 c94e7fbc 
c9fe9b80
Call Trace:    [<d8a20ec9>] [<d8a22d3b>] [<c01a9d0d>] [<c0115ad3>] 
[<c0147553>]
   [<c0109007>]

Code: 8b 93 98 00 00 00 8b 02 83 f8 03 74 56 8b 02 83 f8 05 74 48
  <6>usb.c: USB disconnect on device 4
remove_proc_entry: dev/pcmC2D0p busy, count=1


=====================
cat /proc/ksyms|sort|less:


d8a25e00 snd_pcm_hw_constraint_ratdens_Red85c352        [snd-pcm]
d8a25ec0 snd_pcm_hw_constraint_msbits_Rc5abfad7 [snd-pcm]
d8a25f50 snd_pcm_hw_constraint_step_R88603cc4   [snd-pcm]
d8a25fd0 snd_pcm_hw_constraint_pow2_R61dbf58b   [snd-pcm]
d8a260e0 _snd_pcm_hw_params_any_R6667da40       [snd-pcm]
d8a262a0 snd_pcm_hw_param_value_min_R132c8ec7   [snd-pcm]
d8a26330 snd_pcm_hw_param_value_max_R6d375137   [snd-pcm]
d8a263d0 _snd_pcm_hw_param_setempty_Rb661a635   [snd-pcm]
d8a26450 _snd_pcm_hw_param_setinteger_Rfe98f3f6 [snd-pcm]
d8a26650 snd_pcm_hw_param_first_R07c16536       [snd-pcm]
d8a26810 snd_pcm_hw_param_last_R466fc8c9        [snd-pcm]
d8a268a0 _snd_pcm_hw_param_min_Ra3be0ddb        [snd-pcm]
d8a26cb0 _snd_pcm_hw_param_set_R43ab6d9f        [snd-pcm]
d8a26ff0 snd_pcm_hw_param_mask_R10ab0f83        [snd-pcm]
d8a271e0 snd_pcm_hw_param_near_Rce7de4dd        [snd-pcm]
d8a27720 snd_pcm_lib_ioctl_R73f9a607    [snd-pcm]
d8a27770 snd_pcm_playback_ready_R46350c5e       [snd-pcm]
d8a277d0 snd_pcm_capture_ready_R3d59b3c6        [snd-pcm]
d8a27810 snd_pcm_playback_data_R2f8436e5        [snd-pcm]
d8a278d0 snd_pcm_capture_empty_R21832c9f        [snd-pcm]
d8a27bf0 snd_pcm_period_elapsed_R0bcb3f9f       [snd-pcm]
d8a28170 snd_pcm_lib_write_Rd40be517    [snd-pcm]
d8a28370 snd_pcm_lib_writev_Rc0e2f4bb   [snd-pcm]
d8a28870 snd_pcm_lib_read_R93425d33     [snd-pcm]
d8a28a40 snd_pcm_lib_readv_R5b4bc6ed    [snd-pcm]
d8a28b80 snd_pcm_lib_buffer_bytes_R6065543e     [snd-pcm]
d8a28ba0 snd_pcm_lib_period_bytes_Rca6f41e2     [snd-pcm]
d8a28f10 snd_pcm_format_signed_Re2c5f868        [snd-pcm]
d8a28f40 snd_pcm_format_unsigned_R95a60aa5      [snd-pcm]
d8a28f60 snd_pcm_format_linear_R8733f967        [snd-pcm]
d8a28f80 snd_pcm_format_little_endian_R8bbdc311 [snd-pcm]
d8a28fb0 snd_pcm_format_big_endian_R93878ece    [snd-pcm]

--------

At the moment I cannot unload the modules or access the usb device 
(maudio quattro).

I can still use other cards on my system but the quattro is completely 
unresponsive, even using the direct monitor switch.


-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

Being on stage with the band in front of crowds shouting, "Get off! No! 
We want normal music!", I think that was more like acting than anything 
I've ever done.

Goldie, 8 Nov, 2002
The Scotsman



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
