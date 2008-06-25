From: Jerry Geis <geisj@pagestation.com>
Subject: seg fault in libasound
Date: Wed, 25 Jun 2008 13:38:41 -0400
Message-ID: <486282A1.7050308@pagestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from unifiedpaging.messagenetsystems.com
	(mail.emergencycommunicationsystems.com [24.123.23.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E102243DB
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Jun 2008 19:38:58 +0200 (CEST)
Received: from [192.168.1.8] (devcentos5x64 [192.168.1.8])
	by unifiedpaging.messagenetsystems.com (8.13.1/8.13.1) with ESMTP id
	m5PHchl7032704
	for <alsa-devel@alsa-project.org>; Wed, 25 Jun 2008 13:38:43 -0400
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

I am running asterisk on debian Etch , i486 with math emulation in kernel. Verified by /boot/config-file.
I am getting a seg fault in alsa. 
First I ran straight debian with alsa install.  I got the same seg fault.
Second I installed 1.0.16 and I still get the seg fault.
Third I installed 1.0.17rc2 and I still get the seg fault.
Posted to users first and stan suggested I post to devel.

Below is the trace. I am only using the Console/Dsp from asterisk at this point.
Which is the interface to the soundcard and alsa. 

What shall I do?

Jerry

--------------------------

Program received signal SIGABRT, Aborted.
[Switching to Thread -1224033360 (LWP 2440)]
0xb7d77947 in raise () from /lib/tls/libc.so.6
(gdb) where
#0  0xb7d77947 in raise () from /lib/tls/libc.so.6
#1  0xb7d790c9 in abort () from /lib/tls/libc.so.6
#2  0xb7d7105f in __assert_fail () from /lib/tls/libc.so.6
#3  0xb741861f in snd_pcm_area_copy (dst_area=0x81cc62c, dst_offset=0, 
    src_area=0x81cb7ec, src_offset=5223, samples=816, 
    format=SND_PCM_FORMAT_S16_LE) at pcm_local.h:499
#4  0xb744b7b7 in snd_pcm_dsnoop_sync_ptr (pcm=0x81cb930) at pcm_dsnoop.c:77
#5  0xb7410b11 in snd_pcm_hwsync (pcm=0x81cb930) at pcm.c:932
#6  0xb7422b55 in snd1_pcm_generic_hwsync (pcm=0x81cc1c8) at pcm_generic.c:143
#7  0xb7410b11 in snd_pcm_hwsync (pcm=0x81cc1c8) at pcm.c:932
#8  0xb742fb4d in snd_pcm_rate_hwsync (pcm=0x81cc3f8) at pcm_rate.c:624
#9  0xb7410b11 in snd_pcm_hwsync (pcm=0x81cc3f8) at pcm.c:932
#10 0xb7417817 in snd1_pcm_read_areas (pcm=0x81cc3f8, areas=0xb70a5b70, 
    offset=0, size=160, func=0xb7421e10 <snd_pcm_mmap_read_areas>)
    at pcm.c:6376
#11 0xb742111f in snd_pcm_mmap_readi (pcm=0x81cc3f8, buffer=0xb74a5a40, 
    size=160) at pcm_mmap.c:236
#12 0xb740fff4 in snd_pcm_readi (pcm=0x81cc038, buffer=0xb74a5a40, size=2440)
    at pcm_local.h:521
#13 0xb749579b in alsa_read (chan=0x8213f18) at chan_alsa.c:683
#14 0x080855b1 in __ast_read (chan=0x8213f18, dropaudio=0) at channel.c:2100
#15 0x08087725 in ast_channel_bridge (c0=0x8212858, c1=0x817cf68, 
    config=0xb70a6eac, fo=0xb70a5fe8, rc=0xb70a5fe4) at channel.c:2380
#16 0xb7c75592 in ast_bridge_call (chan=0x8212858, peer=0x8213f18, 
    config=0xb70a6eac) at res_features.c:1490
#17 0xb75c38fd in dial_exec_full (chan=0x8212858, data=0xb70a8fd8, 
    peerflags=0xb70a6f84, continue_exec=0x0) at app_dial.c:1773
#18 0xb75c519d in dial_exec (chan=0x8212858, data=0xb70a8fd8)
    at app_dial.c:1827
#19 0x080c6e3f in pbx_extension_helper (c=0x8212858, con=0x0, 
    context=0x82129d8 "smvoice", exten=0x8212a28 "s", 
    priority=3, label=0x0, callerid=0x8215450 "404", action=E_SPAWN)
    at pbx.c:537
#20 0x080c9185 in __ast_pbx_run (c=0x8212858) at pbx.c:2317
#21 0x080c9ebe in pbx_thread (data=0x8212858) at pbx.c:2636
#22 0x080f51d2 in dummy_start (data=0x8213178) at utils.c:909
#23 0xb7eff0bd in start_thread () from /lib/tls/libpthread.so.0
#24 0xb7e1b01e in clone () from /lib/tls/libc.so.6
