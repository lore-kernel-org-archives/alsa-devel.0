From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Query regarding snd_pcm_lib_preallocate_pages_for_all()
Date: Wed, 14 Nov 2007 00:12:07 +0530
Message-ID: <61445c750711131042qed654b8s17454534fdaa68e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 82D94245A5
	for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2007 19:42:10 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so2247647wag
	for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2007 10:42:08 -0800 (PST)
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

Hi,

I am trying to use snd_pcm_lib_preallocate_pages_for_all() on an arm based
platform for preallocating the DMA buffer.
I am using it as

snd_pcm_lib_preallocate_pages_for_all(pcm,
            SNDRV_DMA_TYPE_DEV,
            NULL,
            64 * 1024, 64 * 1024);

since I dont know what should be passed as the 3'rd param. I tried passing
my device pointer i.e. card->dev after
correctly populating it but I get an error as 'DMA coherent mask in not set'
and buffer is not allocated.

If I pass NULL as shown above, which I think is appropriate, the allocation
is done well and I can play some samples too
using aplay, but when I do a rmmod all hell breaks free.

I am thinking this is corrupting memory some where, since when I preallocate
using SNDRV_DMA_TYPE_CONTINUOUS,
everything works well but I since I need to mmap the buffer I dont use it.

I get following:

c001f7e0 c001f7e0 c001f814 c03b3040 0000000b c34c1c98 c34c1c88
1c80: c003642c c0071978 c34c0000 c34c1cb8 c34c1c9c c003b780 c00363fc
c34c0000
1ca0: c34c0000 c03b3040 00000001 c34c1cd4 c34c1cbc c003bd94 c003b690
c34c1ce8
1cc0: 60000093 00000001 c34c1ce8 c34c1cd8 c002908c c003bbe8 bf000000
c34c1d08
1ce0: c34c1cec c002b2ac c0028d84 ffffffec c03b3040 c34733c8 c001f7e0
c34c1d40
1d00: c34c1d0c c002b588 c002b250 c03a7060 c34c1d94 00000017 ffffffff
c026dd40
1d20: 00000017 c34c1dec 00000004 00000093 40130000 c34c1de8 c34c1d44
c002b688
1d40: c002b3a0 0000007e 00000000 00000000 00000000 00000000 00000000
00000000
1d60: 00000000 c03a7060 c34c1e14 c03b3040 c022eef4 c34c1f14 00000000
00000a00
1d80: c34c1e80 c34c1d90 c019ee84 c01bb390 00000000 7a035438 00000005
00000000
1da0: 00000a00 c03a7060 c0271cdc c34c1d50 00000000 c34c1e08 c34c1dc4
c0063a94
1dc0: c0063984 00000044 ffffffff c34c1e20 00000000 c02eabe0 c347317c
c34c1e44
1de0: c34c1dec c00249a0 c002b65c c02eabe0 00000000 00000013 00000093
c34c0000
1e00: c0306200 00000000 c02eabe0 c347317c c001f7e0 40130000 c34c1e44
c02eabe0
1e20: c34c1e34 c02c0bfc c0067478 00000093 ffffffff 10d5f0ff c34c1e7c
c34c1e48
1e40: c006d658 c0067444 c3541cc0 00000000 00000002 11b100df 000004c0
c347317c
1e60: c34c0000 00000001 c001f7e0 40130000 c34c1ecc c34c1e80 c006e61c
c006d1b8
1e80: c3545000 c001f820 11b100df 0000007e 00000000 00000010 c3545000
00000800
1ea0: c34c0000 ffffffeb c03b3040 c347317c c001f7e0 c001f814 c34c1fb0
40130958
1ec0: c34c1f04 c34c1ed0 c002b470 c006dedc c004822c c03b307c 0000081f
ffffffff
1ee0: c026ddc0 0000081f c34c1fb0 40130958 00000055 4012f000 c34c1fac
c34c1f08
1f00: c002b688 c002b3a0 c34c1f14 c0222148 c0221a50 c34c1e94 0000000c
c34c1e84
1f20: 00000001 00000000 00000000 c1b01040 00000000 00000009 0001d2b4
00000066
1f40: c0024fe4 00000001 c34c1f6c c34c1f58 c01a02c0 c01a01c0 00000000
00000000
1f60: c34c1fa4 c34c1f70 c01a09d0 c01a02b0 c34c1e70 c34c1e74 00000004
0001d2b4
1f80: 00000a00 00000000 0000008e ffffffff 00000115 0001d2dd 00000000
00000000
1fa0: 00000000 c34c1fb0 c0024de8 c002b65c 00000000 0000b05c 54434100
00000001
1fc0: 40130958 00000115 0001d2dd 00000000 00000000 00000055 4012f000
00000007
1fe0: 0001d150 be8ba5ec 0000b05c 40082fbc 60000010 ffffffff 00000000
00000000
Backtrace:
[<c0073880>] (page_remove_rmap+0x0/0x118) from [<c006c628>]
(unmap_vmas+0x3c4/0x60c)
 r4 = C02EABE0
[<c006c264>] (unmap_vmas+0x0/0x60c) from [<c00719e8>] (exit_mmap+0x80/0x150)
[<c0071968>] (exit_mmap+0x0/0x150) from [<c003642c>] (mmput+0x40/0xe4)
 r8 = 0000000B  r7 = C03B3040  r6 = C001F814  r5 = C001F7E0
 r4 = C001F7E0
[<c00363ec>] (mmput+0x0/0xe4) from [<c003b780>] (exit_mm+0x100/0x10c)
 r4 = C34C0000
[<c003b680>] (exit_mm+0x0/0x10c) from [<c003bd94>] (do_exit+0x1bc/0x9c4)
 r7 = 00000001  r6 = C03B3040  r5 = C34C0000  r4 = C34C0000
[<c003bbd8>] (do_exit+0x0/0x9c4) from [<c002908c>] (die+0x318/0x36c)
[<c0028d74>] (die+0x0/0x36c) from [<c002b2ac>] (__do_kernel_fault+0x6c/0x7c)
[<c002b240>] (__do_kernel_fault+0x0/0x7c) from [<c002b588>]
(do_page_fault+0x1f8/0x210)
 r7 = C001F7E0  r6 = C34733C8  r5 = C03B3040  r4 = FFFFFFEC
[<c002b390>] (do_page_fault+0x0/0x210) from [<c002b688>]
(do_DataAbort+0x3c/0xa0)
[<c002b64c>] (do_DataAbort+0x0/0xa0) from [<c00249a0>]
(__dabt_svc+0x40/0x60)
 r8 = C347317C  r7 = C02EABE0  r6 = 00000000  r5 = C34C1E20
 r4 = FFFFFFFF
[<c0067434>] (lru_cache_add_active+0x0/0xa0) from [<c006d658>]
(do_wp_page+0x4b0/0x574)
 r4 = 10D5F0FF
[<c006d1a8>] (do_wp_page+0x0/0x574) from [<c006e61c>]
(__handle_mm_fault+0x750/0x824)
[<c006decc>] (__handle_mm_fault+0x0/0x824) from [<c002b470>]
(do_page_fault+0xe0/0x210)
[<c002b390>] (do_page_fault+0x0/0x210) from [<c002b688>]
(do_DataAbort+0x3c/0xa0)
[<c002b64c>] (do_DataAbort+0x0/0xa0) from [<c0024de8>]
(ret_from_exception+0x0/0x10)
 r8 = 00000000  r7 = 00000000  r6 = 0001D2DD  r5 = 00000115
 r4 = FFFFFFFF
Code: e3130901 e1a03004 1594300c e59f008c (e5931004)
 <1>Fixing recursive fault but reboot is needed!
BUG: scheduling while atomic: udevd/0x00000004/245
Bad page state in process 'exe'
page:c02eaa60 flags:0x00004000 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
Bad page state in process 'exe'
page:c02eaa60 flags:0x00004000 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
Bad page state in process 'exe'
page:c02eaa80 flags:0x00004000 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
Bad page state in process 'exe'
page:c02eaa80 flags:0x00004000 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
Bad page state in process 'exe'
page:c02eaaa0 flags:0x00004000 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
Bad page state in process 'exe'
page:c02eaaa0 flags:0x00004000 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
Bad page state in process 'exe'
page:c02eaac0 flags:0x00004000 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
Bad page state in process 'exe'
page:c02eaac0 flags:0x00004000 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
Bad page state in process 'exe'
page:c02eaae0 flags:0x00004000 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
Bad page state in process 'exe'
page:c02eaae0 flags:0x00004000 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
Bad page state in process 'exe'
page:c02eab00 flags:0x00004000 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
Bad page state in process 'exe'
page:c02eab00 flags:0x00004000 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
Bad page state in process 'exe'
page:c02eab20 flags:0x00004000 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
Bad page state in process 'exe'
page:c02eab20 flags:0x00004000 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
Bad page state in process 'exe'
page:c02eab40 flags:0x00004000 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
Bad page state in process 'exe'
page:c02eab40 flags:0x00004000 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
Bad page state in process 'exe'
page:c02eab60 flags:0x00004000 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
Bad page state in process 'exe'
page:c02eab60 flags:0x00004000 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
Bad page state in process 'exe'
page:c02eab80 flags:0x00004000 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
Bad page state in process 'exe'
page:c02eab80 flags:0x00004000 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
Bad page state in process 'exe'
page:c02eaba0 flags:0x00004000 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
Bad page state in process 'exe'
page:c02eaba0 flags:0x00004000 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
Bad page state in process 'exe'
page:c02eabc0 flags:0x00004000 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
Bad page state in process 'exe'
page:c02eabc0 flags:0x00004000 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:


so on
