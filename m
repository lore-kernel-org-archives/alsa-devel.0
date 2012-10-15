From: Matthieu CASTET <matthieu.castet-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org>
Subject: Re: usb audio race at disconnect time
Date: Mon, 15 Oct 2012 19:41:40 +0200
Message-ID: <507C4AD4.2090400@parrot.com>
References: <5076E327.5030503@parrot.com>	<s5hvceh9d0v.wl%tiwai@suse.de>	<50783A5B.9090009@parrot.com> <s5h626eixid.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------050001070404060303080703"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <s5h626eixid.wl%tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ALSA devel <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

--------------050001070404060303080703
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi Takashi,

Takashi Iwai a écrit :
> At Fri, 12 Oct 2012 17:42:19 +0200,
> Matthieu CASTET wrote:
>> Hi,
>>
>>
>> Takashi Iwai a écrit :
>>> [Added Daniel and Clemens in the loop]
>>>
>>>
>>> I don't think this is needed.
>>>
>>> So... the below is a quick hack I did without testing at all.
>>> Hopefully this can give some advance.
>> Thanks for the quick patch.
>>
>> The patch didn't apply cleany of linus tree, of which tree is based your patch ?
> 
> Did you try the second one?
> The second one covers races in more places.
> 
> The only uncovered place is the autosuspend stuff in mixer.c (for PCM,
> it's used only in open/close, so it's no problem).  I'll fix it later.
> 
> 
I didn't have time to test your latest patches : I will test them tomorrow.
On which git tree are they based ? gregkh/usb.git ?


But I believe I found other races in the alsa char device handling. With the
attached patch, if you disconnect the usb audio device between "msleep o" and
"msleep o+", you will free the card resource (snd_card_do_free) and then use it [1].

I did in in snd_ctl_open, but the same thing could be done in snd_pcm_open, ...

Matthieu


[1]
[   30.768341] Alignment trap: not handling instruction e1960f9f at [<c0087ba4>]
[   30.775878] Unhandled fault: alignment exception (0x001) at 0x6b6b6c6f
[   30.782775] Internal error: : 1 [#1] SMP ARM
[   30.787292] Modules linked in:
[   30.790557] CPU: 0    Tainted: G        W     (3.6.0-03888-g9c0226d-dirty #25)
[   30.798187] PC is at __lock_acquire.clone.19+0x164/0xd40
[   30.803802] LR is at lock_acquire+0x5c/0x70
[   30.808227] pc : [<c0087ba8>]    lr : [<c0088d54>]    psr: 20000093
[   30.808227] sp : cd727c70  ip : 00000001  fp : cd727ccc
[   30.820343] r10: c05c3994  r9 : c328c218  r8 : 6b6b6b6b
[   30.825866] r7 : cd74f640  r6 : 6b6b6c6f  r5 : c05a4d5c  r4 : cd726000
[   30.832763] r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : c328c218
[   30.839660] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
[   30.847290] Control: 10c5387d  Table: 8329c019  DAC: 00000015
[   30.853363] Process arecord (pid: 635, stack limit = 0xcd7262f8)
[   30.859680] Stack: (0xcd727c70 to 0xcd728000)
[   30.864288] 7c60:                                     000000ec 00000000
c059ce68 00000001
[   30.872955] 7c80: 00000000 c05c2cc0 00000009 c059ce38 60000013 00000004
cd727d14 cd727ca8
[   30.881591] 7ca0: c00455b0 00000000 cd726000 60000013 cd74f640 c09c7d70
00000024 c3297440
[   30.890228] 7cc0: cd727cfc cd727cd0 c0088d54 c0087a50 00000000 00000000
c02e3984 00000000
[   30.898864] 7ce0: c328c208 00000001 c318cf40 c328c208 cd727d24 cd727d00
c03d8274 c0088d04
[   30.907501] 7d00: 00000001 00000000 c02e3984 c32c7a48 c328c000 c32c7a48
cd727d44 cd727d28
[   30.916107] 7d20: c02e3984 c03d824c c32c7a48 c328c000 00000000 07400000
cd727d64 cd727d48
[   30.924774] 7d40: c02e68cc c02e3940 c04042d0 c32c7a48 c3291b20 07400000
cd727d8c cd727d68
[   30.933380] 7d60: c02e3494 c02e6868 c3291b20 c32c7a48 cf9f83c0 00000000
c00f18c8 00000000
[   30.942047] 7d80: cd727db4 cd727d90 c00f1960 c02e33f8 c00eedcc 00000000
c32c7a48 c3291b20
[   30.950683] 7da0: c32c7a50 00000001 cd727ddc cd727db8 c00eb8b0 c00f18d4
cd727ea0 cd727f60
[   30.959320] 7dc0: 00000000 00000000 cd727e98 00000000 cd727df4 cd727de0
c00eb96c c00eb6ec
[   30.967956] 7de0: cd727ea0 cd727ee0 cd727e6c cd727df8 c00fb974 c00eb950
cd727e6c cd727e08
[   30.976593] 7e00: c00f8bd4 c00f8b1c c00f97fc 00000000 cd727ee0 00000001
00000000 cd727ee8
[   30.985229] 7e20: 00000000 00000000 cf737178 c32c7a48 00000000 00000000
c3291b20 cd67f848
[   30.993865] 7e40: 00000020 cd727ee0 c32c7a48 cd727f60 cd727e98 00000000
cd727ea0 cd726000
[   31.002502] 7e60: cd727ed4 cd727e70 c00fc028 c00fb39c cd727ea0 cd727e80
00000000 c32cad64
[   31.011138] 7e80: cd74f640 00000000 cd74f968 00000000 00000004 00000000
cf815e58 cf74a8f8
[   31.019775] 7ea0: 00000000 00000000 cd726000 cd727f60 00000001 ffffff9c
cfb07000 ffffff9c
[   31.028411] 7ec0: cd726000 00000000 cd727f54 cd727ed8 c00fc730 c00fbf84
00000041 00000000
[   31.037048] 7ee0: cf815e58 cf74a8f8 35c12985 00000009 cfb07009 cd727e30
00000000 cf4fcb38
[   31.045684] 7f00: c3291b20 00000101 00000008 00000000 00000000 cd773e98
cd727f54 cd727f28
[   31.054321] 7f20: c0109814 c03d8818 00000000 cfb07000 00000000 00026150
cfb07000 00000000
[   31.062957] 7f40: 00000003 00000001 cd727f94 cd727f58 c00ec7bc c00fc708
00000000 cd726000
[   31.071594] 7f60: 00000000 00000000 00000024 00000100 becb28da b6eef8a0
00026150 00000005
[   31.080261] 7f80: c0014728 00000000 cd727fa4 cd727f98 c00ec880 c00ec6d8
00000000 cd727fa8
[   31.088897] 7fa0: c00145a0 c00ec864 becb28da b6eef8a0 becb28da 00000000
becb28ec ffffffff
[   31.097534] 7fc0: becb28da b6eef8a0 00026150 00000005 00000001 0001c3b8
000260b8 ffffffff
[   31.106170] 7fe0: 00000000 becb28d8 b6ea8c10 b6dc078c 60000010 becb28da
de10c4ff be918a5f
[   31.114807] Backtrace:
[   31.117401] [<c0087a44>] (__lock_acquire.clone.19+0x0/0xd40) from
[<c0088d54>] (lock_acquire+0x5c/0x70)
[   31.127349] [<c0088cf8>] (lock_acquire+0x0/0x70) from [<c03d8274>]
(_raw_spin_lock+0x34/0x44)
[   31.136322]  r7:c328c208 r6:c318cf40 r5:00000001 r4:c328c208
[   31.142364] [<c03d8240>] (_raw_spin_lock+0x0/0x44) from [<c02e3984>]
(snd_card_file_add+0x50/0xc0)
[   31.151824]  r5:c32c7a48 r4:c328c000
[   31.155639] [<c02e3934>] (snd_card_file_add+0x0/0xc0) from [<c02e68cc>]
(snd_ctl_open+0x70/0x190)
[   31.164978]  r7:07400000 r6:00000000 r5:c328c000 r4:c32c7a48
[   31.170989] [<c02e685c>] (snd_ctl_open+0x0/0x190) from [<c02e3494>]
(snd_open+0xa8/0x1a0)
[   31.179595]  r7:07400000 r6:c3291b20 r5:c32c7a48 r4:c04042d0
[   31.185638] [<c02e33ec>] (snd_open+0x0/0x1a0) from [<c00f1960>]
(chrdev_open+0x98/0x160)
[   31.194183] [<c00f18c8>] (chrdev_open+0x0/0x160) from [<c00eb8b0>]
(do_dentry_open.clone.18+0x1d0/0x264)
[   31.204193]  r7:00000001 r6:c32c7a50 r5:c3291b20 r4:c32c7a48
[   31.210205] [<c00eb6e0>] (do_dentry_open.clone.18+0x0/0x264) from
[<c00eb96c>] (finish_open+0x28/0x40)
[   31.220062] [<c00eb944>] (finish_open+0x0/0x40) from [<c00fb974>]
(do_last.clone.40+0x5e4/0xbe8)
[   31.229309]  r4:cd727ee0 r3:cd727ea0
[   31.233123] [<c00fb390>] (do_last.clone.40+0x0/0xbe8) from [<c00fc028>]
(path_openat+0xb0/0x488)
[   31.242401] [<c00fbf78>] (path_openat+0x0/0x488) from [<c00fc730>]
(do_filp_open+0x34/0x88)
[   31.251190] [<c00fc6fc>] (do_filp_open+0x0/0x88) from [<c00ec7bc>]
(do_sys_open+0xf0/0x18c)
[   31.260009]  r7:00000001 r6:00000003 r5:00000000 r4:cfb07000
[   31.266021] [<c00ec6cc>] (do_sys_open+0x0/0x18c) from [<c00ec880>]
(sys_open+0x28/0x2c)
[   31.274475] [<c00ec858>] (sys_open+0x0/0x2c) from [<c00145a0>]
(ret_fast_syscall+0x0/0x30)
[   31.283203] Code: e3580000 0affffbe e2886f41 e1960f9f (e2800001)
[   31.289642] ---[ end trace e749a1146c99522c ]---
[   31.294525] Kernel panic - not syncing: Fatal exception

--------------050001070404060303080703
Content-Type: text/plain; name="diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline; filename="diff"

ZGlmZiAtLWdpdCBhL3NvdW5kL2NvcmUvY29udHJvbC5jIGIvc291bmQvY29yZS9jb250cm9s
LmMKaW5kZXggMjQ4N2E2Yi4uMzRjODBkNCAxMDA2NDQKLS0tIGEvc291bmQvY29yZS9jb250
cm9sLmMKKysrIGIvc291bmQvY29yZS9jb250cm9sLmMKQEAgLTQ1LDYgKzQ1LDcgQEAgc3Rh
dGljIExJU1RfSEVBRChzbmRfY29udHJvbF9pb2N0bHMpOwogc3RhdGljIExJU1RfSEVBRChz
bmRfY29udHJvbF9jb21wYXRfaW9jdGxzKTsKICNlbmRpZgogCisjaW5jbHVkZSA8bGludXgv
ZGVsYXkuaD4KIHN0YXRpYyBpbnQgc25kX2N0bF9vcGVuKHN0cnVjdCBpbm9kZSAqaW5vZGUs
IHN0cnVjdCBmaWxlICpmaWxlKQogewogCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CkBAIC02MSw2
ICs2MiwxMCBAQCBzdGF0aWMgaW50IHNuZF9jdGxfb3BlbihzdHJ1Y3QgaW5vZGUgKmlub2Rl
LCBzdHJ1Y3QgZmlsZSAqZmlsZSkKIAkJZXJyID0gLUVOT0RFVjsKIAkJZ290byBfX2Vycm9y
MTsKIAl9CisgICAgICAgcHJpbnRrKCJtc2xlZXAgbyAlcFxuIiwgY2FyZCk7CisgICAgICAg
bXNsZWVwKDUwMDApOworICAgICAgIHByaW50aygibXNsZWVwIG8rXG4iKTsKKwogCWVyciA9
IHNuZF9jYXJkX2ZpbGVfYWRkKGNhcmQsIGZpbGUpOwogCWlmIChlcnIgPCAwKSB7CiAJCWVy
ciA9IC1FTk9ERVY7Cg==
--------------050001070404060303080703--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
