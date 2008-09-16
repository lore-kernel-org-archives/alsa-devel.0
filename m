From: "vasudha rao" <vasudha.jrao@gmail.com>
Subject: Re: Unable to play aplay
Date: Tue, 16 Sep 2008 17:08:30 +0530
Message-ID: <eeb9eca50809160438y786936d0m4376e4cc146477fb@mail.gmail.com>
References: <eeb9eca50809100546w5475ebffqafd3d1e8224206c0@mail.gmail.com>
	<2ee9e08d0809101124t76b0aca9n314185c989a50019@mail.gmail.com>
	<eeb9eca50809102137s6047fb36pe49bb47cf973f208@mail.gmail.com>
	<eeb9eca50809102216x3d2e2d9ayafa1aa979e6dd228@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.246])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F443243A6
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Sep 2008 13:38:32 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so2568206rvb.32
	for <alsa-devel@alsa-project.org>; Tue, 16 Sep 2008 04:38:30 -0700 (PDT)
In-Reply-To: <eeb9eca50809102216x3d2e2d9ayafa1aa979e6dd228@mail.gmail.com>
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
To: aggarwal <anuj.aggarwal@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I inserted modules to my linux kernel (2.6.20)like..

$insmod snd.ko
$insmod snd-timer.ko
$insmod snd-page-alloc.ko
$insmod snd-pcm.ko
$insmod ac97_bus.ko
$insmod snd-ac97-codec.ko
$insmod snd-at91-ac97.ko

After this, I am getting,

$aplay

No error messages..

$aplay laughter.wav
Playing WAVE 'laughter.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
Bad pte = 5fc3e05f, process = aplay, vm_flags = 800fb, vaddr = 4032c000
Bad pte = 5fc3f05f, process = aplay, vm_flags = 800fb, vaddr = 4032d000
Unable to handle kernel paging request at virtual address ff800001
pgd = c346c000
[ff800001] *pgd=00000000
Internal error: Oops: 1 [#1]
Modules linked in: snd_at91_ac97 snd_ac97_codec ac97_bus snd_pcm
snd_page_alloc snd_timer snd
CPU: 0
PC is at snd_pcm_mmap_data_nopage+0xc4/0xe8 [snd_pcm]
LR is at 0x4032e000
pc : [<bf0190e4>]    lr : [<4032e000>]    Not tainted
sp : c3bb3e6c  ip : ff7ffffd  fp : c3bb3e80
r10: 4032e000  r9 : c001f380  r8 : c3bb2000
r7 : c3449764  r6 : 00000000  r5 : c3bb3ea0  r4 : c34a8c00
r3 : 00000093  r2 : 00000013  r1 : 00006000  r0 : c0aa3800
Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  Segment user
Control: 5317F
Table: 2346C000  DAC: 00000015
Process aplay (pid: 916, stack limit = 0xc3bb2250)
Stack: (0xc3bb3e6c to 0xc3bb4000)
3e60:                            00000000 c3e192ec c3bb3ecc c3bb3e84
c0067c58
3e80: bf019030 c346d008 c001f3c0 5fc3f05f 00000000 00000000 c346d008
00000000
3ea0: 00000002 ffffffeb c3d2b040 c3449764 c001f380 c001f3b4 c3bb3fb0
4032e000
3ec0: c3bb3f04 c3bb3ed0 c00293a4 c0067b2c 00022b70 00000000 00000017
ffffffff
3ee0: c027900c 00000017 c3bb3fb0 4032e000 40388000 400cb5fc c3bb3fac
c3bb3f08
3f00: c00295c0 c00292dc c3bb3f2c c0377f20 ffffffe7 c0844123 00000000
c0023ec4
3f20: 400cb5fc c3bb3f40 c3bb3f34 bf018af4 bf018194 c3bb3f5c c3bb3f44
c00823d0
3f40: bf018ad0 c0377f20 00022b70 00000004 c3bb3f84 c3bb3f60 c00826ac
c00823a4
3f60: 000014c2 ffffffff c3bb3fac c3bb3f78 c01f7ee0 c00275a8 c3d2b080
c3d2b154
3f80: 0082ca24 ffffffff 40388734 ffffffff 40389734 00000008 00000004
00000004
3fa0: 00000000 c3bb3fb0 c0023cc8 c0029594 00000000 4032e000 40354000
00000100
3fc0: 00006800 40389734 00000008 00000004 00000004 40388000 400cb5fc
00006dcd
3fe0: 00000100 bea539d0 00000100 4008ce20 20000010 ffffffff 00000000
00000029
Backtrace:
[<bf019020>] (snd_pcm_mmap_data_nopage+0x0/0xe8 [snd_pcm]) from [<c0067c58>]
(__handle_mm_fault+0x13c/0x760)
 r5 = C3E192EC  r4 = 00000000
[<c0067b1c>] (__handle_mm_fault+0x0/0x760) from [<c00293a4>]
(do_page_fault+0xd8/0x20c)
[<c00292cc>] (do_page_fault+0x0/0x20c) from [<c00295c0>]
(do_DataAbort+0x3c/0xa0)
[<c0029584>] (do_DataAbort+0x0/0xa0) from [<c0023cc8>]
(ret_from_exception+0x0/0x10)
 r8 = 00000004  r7 = 00000004  r6 = 00000008  r5 = 40389734
 r4 = FFFFFFFF
Code: 1590c00c e10f2000 e3823080 e121f003 (e59c3004)
 Segmentation fault


$aplay -l
card 0: AC97 [Atmel AC97], device 0: Atmel AC97 [Atmel AC97]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

$arecord
ALSA lib pcm_dmix.c:812:(snd_pcm_dmix_open) The dmix plugin supports only
playback stream
arecord: main:446: audio open error: Invalid argument

$arecord -l

No message here..

$cat /proc/asound/pcm
00-00: Atmel AC97 : Atmel AC97 : playback 1

Why I am not able to here or record sound..??
Where I am doing wrong...??

Thank you..












On Thu, Sep 11, 2008 at 10:46 AM, vasudha rao <vasudha.jrao@gmail.com>wrote:

> Hi anuj ,
>
> Sorry my mistake..that time I hav not loaded conf files in /usr/share/ .. I
> loaded now..
> So now when I give command like,
>
> -------------------------------------------------
> $aplay -l
> **** List of PLAYBACK Hardware Devices ****
> card 0: AC97 [Atmel AC97], device 0: Atmel AC97 [Atmel AC97]
> Subdevices: 1/1
> Subdevice #0: subdevice #0
> ---------------------------------------------------
>
> but,aplay not proper,,
> ----------------------------
> $aplay
> aplay: main:508: audio open error: Inappropriate ioctl for device
> ----------------------------
>
> Where I am doing wrong..??
>
> Thank you..
>
> On Thu, Sep 11, 2008 at 10:07 AM, vasudha rao <vasudha.jrao@gmail.com>wrote:
>
>>
>>
>>
>> Hi Anuj,
>>
>> Nodes were not there before..I created now..
>>
>> Now when I did $aplay -l ,
>> I got,
>>
>>  **** List of PLAYBACK Hardware Devices ***
>> *ALSA lib control.c:739:(snd_ctl_open_noupdate) Invalid CTL hw:0
>> aplay: device_list:208: control open (0): No such file or directory
>> aplay: conf.c:3083: snd_config_update_free: Assertion `update->count > 0
>> && update->finfo' failed.Aborted
>>
>> Where I am doing wrong..??
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>> Thank you..
>>
>>
>>
>>
>>
>>
>>
>>
>> On Wed, Sep 10, 2008 at 11:54 PM, anuj aggarwal <anuj.aggarwal@gmail.com>wrote:
>>
>>> Vasudha,
>>>
>>> Could you please check the device nodes in /dev/snd folder? The
>>> desired output is:
>>>
>>> [root@ /home]# ls -l /dev/snd/
>>> crw-rw----    1 root     root     116,   5 Jan  1 00:00 controlC0
>>> crw-rw----    1 root     root     116,   4 Jan  1 00:00 pcmC0D0c
>>> crw-rw----    1 root     root     116,   3 Jan  1 00:00 pcmC0D0p
>>>
>>> If the nodes are not there, you have to create them first before trying
>>> aplay.
>>>
>>> Regards,
>>> Anuj
>>>
>>>
>>> On Wed, Sep 10, 2008 at 6:16 PM, vasudha rao <vasudha.jrao@gmail.com>
>>> wrote:
>>> >
>>> > Hi ,
>>> >
>>> > I want to play and record audio file in my custom atmel 9263 board
>>> running
>>> > with linux(2.6.20).
>>> > when I tried to play aplay for a wave file, I got
>>> >
>>> > $aplay /home/alarm.wav
>>> > ALSA lib pcm.c:1707:(snd_pcm_open_noupdate) Unknown PCM default
>>> > aplay: main:446: audio open error: No such file or directory
>>> >
>>> > $aplay -l
>>> > aplay: device_list:187: no soundcards found...
>>> >
>>> > $cat /proc/asound/devices
>>> >  2:        : timer
>>> >  3:        : sequencer
>>> >  4: [ 0- 0]: digital audio playback
>>> >  5: [ 0]   : control
>>> >
>>> > Can you tel me where I am doing wrong..??
>>> >
>>> > Thanks in advance..
>>> > _______________________________________________
>>> > Alsa-devel mailing list
>>> > Alsa-devel@alsa-project.org
>>> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>>
>>>
>>>
>>> --
>>> Best Regards,
>>> Anuj Aggarwal
>>>
>>
>>
>
