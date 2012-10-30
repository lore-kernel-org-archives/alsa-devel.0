From: Matthieu CASTET <matthieu.castet-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org>
Subject: Re: usb audio race at disconnect time
Date: Tue, 30 Oct 2012 11:52:33 +0100
Message-ID: <508FB171.7030007@parrot.com>
References: <5076E327.5030503@parrot.com>	<s5hvceh9d0v.wl%tiwai@suse.de>	<50783A5B.9090009@parrot.com>	<s5h626eixid.wl%tiwai@suse.de>	<507C4AD4.2090400@parrot.com>	<s5hwqyrh8vb.wl%tiwai@suse.de>	<507D84C9.9070405@parrot.com>	<s5ha9vm4d46.wl%tiwai@suse.de>	<50802299.9080004@parrot.com> <s5h4nlduzvc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <s5h4nlduzvc.wl%tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ALSA devel <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


Takashi Iwai a =C3=A9crit :
>> Thanks,
>>
>> the first tests seems ok.
>> We will do more strees test.
>=20
> Do you have any good/bad test result?
> If no regression is seen, I'm going to apply the patches for 3.7-rc4.
The patches fix the races.

But I saw a failure I didn't saw before during stress test [1].
It is hard to say if it is related to your patches :
- we test on a older kernel version and I backported usbaudio from 3.7 =
with your
patches
- the start of the trace is missing and it is difficult to understand t=
he list
corruption.

Matthieu

[1]
<4>[  570.313385] bf40: c06ae6a0 c06ae684 00000003 00000003 8012bd80 41=
3fc082
00000000 00000000
<4>[  570.313385] bf60: 3b9ac9ff c065bf78 c014f224 c014f230 60000053 ff=
ffffff
<4>[  570.313415] [<c0138ac8>] (__irq_svc+0x48/0xa8) from [<c014f230>]
(omap3_enter_idle+0x104/0x134)
<4>[  570.313446] [<c014f230>] (omap3_enter_idle+0x104/0x134) from [<c0=
3ef4f4>]
(cpuidle_idle_call+0xa4/0x108)
<4>[  570.313476] [<c03ef4f4>] (cpuidle_idle_call+0xa4/0x108) from [<c0=
139cf0>]
(cpu_idle+0x40/0x94)
<4>[  570.313476] [<c0139cf0>] (cpu_idle+0x40/0x94) from [<c0108984>]
(start_kernel+0x280/0x2e0)
<4>[  570.313507] unwind: Unknown symbol address c0108984
<4>[  570.313507] unwind: Index not found c0108984
<4>[  570.313507] ---[ end trace 069f4a4f8aedac20 ]---
<4>[  570.324859] ------------[ cut here ]------------
<4>[  570.324890] WARNING: at /kernel/omap/lib/list_debug.c:30
__list_add+0x60/0x80()
<4>[  570.324920] Process swapper (0)
<4>[  570.324920] list_add corruption. prev->next should be next (d76f3=
e50), but
was ced0bd98. (prev=3Dced0bb18).
<4>[  570.324951] Modules linked in: blackberry cdc_acm sierra option u=
sb_wwan
hso omap3_isp tnx_mxt_ts cp210x pl2303 usbserial 88w8688_wlan tun omap_=
hsmmc
<4>[  570.325012] [<c013e608>] (unwind_backtrace+0x0/0xf0) from [<c016f=
828>]
(warn_slowpath_common+0x6c/0x88)
<4>[  570.325012] [<c016f828>] (warn_slowpath_common+0x6c/0x88) from
[<c016f8c4>] (warn_slowpath_fmt+0x2c/0x3c)
<4>[  570.325042] [<c016f8c4>] (warn_slowpath_fmt+0x2c/0x3c) from [<c02=
983fc>]
(__list_add+0x60/0x80)
<4>[  570.325073] [<c02983fc>] (__list_add+0x60/0x80) from [<c034e8d0>]
(usb_hcd_link_urb_to_ep+0x88/0xb8)
<4>[  570.325103] [<c034e8d0>] (usb_hcd_link_urb_to_ep+0x88/0xb8) from
[<c0365cc0>] (ehci_urb_enqueue+0x584/0xee0)
<4>[  570.325103] [<c0365cc0>] (ehci_urb_enqueue+0x584/0xee0) from [<c0=
3509b4>]
(usb_hcd_submit_urb+0x92c/0x960)
<4>[  570.325134] [<c03509b4>] (usb_hcd_submit_urb+0x92c/0x960) from
[<c042403c>] (snd_complete_urb+0x204/0x258)
<4>[  570.325164] [<c042403c>] (snd_complete_urb+0x204/0x258) from [<c0=
34f494>]
(usb_hcd_giveback_urb+0xa0/0xec)
<4>[  570.325195] [<c034f494>] (usb_hcd_giveback_urb+0xa0/0xec) from
[<c0360728>] (ehci_urb_done+0x100/0x120)
<4>[  570.325195] [<c0360728>] (ehci_urb_done+0x100/0x120) from [<c0362=
600>]
(ehci_work+0x550/0x9b4)
<4>[  570.325225] [<c0362600>] (ehci_work+0x550/0x9b4) from [<c0364b88>=
]
(ehci_irq+0x218/0x260)
<4>[  570.325256] [<c0364b88>] (ehci_irq+0x218/0x260) from [<c034ebd0>]
(usb_hcd_irq+0x38/0x90)
<4>[  570.325256] [<c034ebd0>] (usb_hcd_irq+0x38/0x90) from [<c01a8e38>=
]
(handle_IRQ_event+0x24/0xe4)
<4>[  570.325286] [<c01a8e38>] (handle_IRQ_event+0x24/0xe4) from [<c01a=
b034>]
(handle_level_irq+0xdc/0x188)
<4>[  570.325317] [<c01ab034>] (handle_level_irq+0xdc/0x188) from [<c01=
3806c>]
(asm_do_IRQ+0x6c/0x8c)
<4>[  570.325347] [<c013806c>] (asm_do_IRQ+0x6c/0x8c) from [<c0138ac8>]
(__irq_svc+0x48/0xa8)
<4>[  570.325347] Exception stack(0xc065bf30 to 0xc065bf78)
<4>[  570.325347] bf20:                                     000e4e42 00=
000000
000e4e42 00000000
<4>[  570.325378] bf40: c06ae684 c06ae684 00000003 00000003 8012bd80 41=
3fc082
00000000 00000000
<4>[  570.325408] bf60: 3b9ac9ff c065bf78 c014f224 c014f230 60000053 ff=
ffffff
<4>[  570.325408] [<c0138ac8>] (__irq_svc+0x48/0xa8) from [<c014f230>]
(omap3_enter_idle+0x104/0x134)
<4>[  570.325439] [<c014f230>] (omap3_enter_idle+0x104/0x134) from [<c0=
3ef4f4>]
(cpuidle_idle_call+0xa4/0x108)
<4>[  570.325469] [<c03ef4f4>] (cpuidle_idle_call+0xa4/0x108) from [<c0=
139cf0>]
(cpu_idle+0x40/0x94)
<4>[  570.325469] [<c0139cf0>] (cpu_idle+0x40/0x94) from [<c0108984>]
(start_kernel+0x280/0x2e0)
<4>[  570.325500] unwind: Unknown symbol address c0108984
<4>[  570.325500] unwind: Index not found c0108984
<4>[  570.325500] ---[ end trace 069f4a4f8aedac21 ]---
<4>[  570.336883] ------------[ cut here ]------------
<4>[  570.336914] WARNING: at /kernel/omap/lib/list_debug.c:30
__list_add+0x60/0x80()
<4>[  570.336914] Process swapper (0)
<4>[  570.336944] list_add corruption. prev->next should be next (d76f3=
e50), but
was ced0bd98. (prev=3Dced0bb18).
<4>[  570.336944] Modules linked in: blackberry cdc_acm sierra option u=
sb_wwan
hso omap3_isp tnx_mxt_ts cp210x pl2303 usbserial 88w8688_wlan tun omap_=
hsmmc
<4>[  570.337005] [<c013e608>] (unwind_backtrace+0x0/0xf0) from [<c016f=
828>]
(warn_slowpath_common+0x6c/0x88)
<4>[  570.337036] [<c016f828>] (warn_slowpath_common+0x6c/0x88) from
[<c016f8c4>] (warn_slowpath_fmt+0x2c/0x3c)
<4>[  570.337066] [<c016f8c4>] (warn_slowpath_fmt+0x2c/0x3c) from [<c02=
983fc>]
(__list_add+0x60/0x80)
<4>[  570.337066] [<c02983fc>] (__list_add+0x60/0x80) from [<c034e8d0>]
(usb_hcd_link_urb_to_ep+0x88/0xb8)
<4>[  570.337097] [<c034e8d0>] (usb_hcd_link_urb_to_ep+0x88/0xb8) from
[<c0365cc0>] (ehci_urb_enqueue+0x584/0xee0)
<4>[  570.337127] [<c0365cc0>] (ehci_urb_enqueue+0x584/0xee0) from [<c0=
3509b4>]
(usb_hcd_submit_urb+0x92c/0x960)
<4>[  570.337158] [<c03509b4>] (usb_hcd_submit_urb+0x92c/0x960) from
[<c042403c>] (snd_complete_urb+0x204/0x258)
<4>[  570.337158] [<c042403c>] (snd_complete_urb+0x204/0x258) from [<c0=
34f494>]
(usb_hcd_giveback_urb+0xa0/0xec)
<4>[  570.337188] [<c034f494>] (usb_hcd_giveback_urb+0xa0/0xec) from
[<c0360728>] (ehci_urb_done+0x100/0x120)
<4>[  570.337219] [<c0360728>] (ehci_urb_done+0x100/0x120) from [<c0362=
600>]
(ehci_work+0x550/0x9b4)
<4>[  570.337219] [<c0362600>] (ehci_work+0x550/0x9b4) from [<c0364b88>=
]
(ehci_irq+0x218/0x260)
<4>[  570.337249] [<c0364b88>] (ehci_irq+0x218/0x260) from [<c034ebd0>]
(usb_hcd_irq+0x38/0x90)
<4>[  570.337280] [<c034ebd0>] (usb_hcd_irq+0x38/0x90) from [<c01a8e38>=
]
(handle_IRQ_event+0x24/0xe4)
<4>[  570.337310] [<c01a8e38>] (handle_IRQ_event+0x24/0xe4) from [<c01a=
b034>]
(handle_level_irq+0xdc/0x188)
<4>[  570.337310] [<c01ab034>] (handle_level_irq+0xdc/0x188) from [<c01=
3806c>]
(asm_do_IRQ+0x6c/0x8c)
<4>[  570.337341] [<c013806c>] (asm_do_IRQ+0x6c/0x8c) from [<c0138ac8>]
(__irq_svc+0x48/0xa8)
<4>[  570.337341] Exception stack(0xc065bf30 to 0xc065bf78)
<4>[  570.337371] bf20:                                     0008fe22 00=
000000
0008fe22 00000000
<4>[  570.337371] bf40: c06ae6a0 c06ae684 00000003 00000003 8012bd80 41=
3fc082
00000000 00000000
<4>[  570.337402] bf60: 3b9ac9ff c065bf78 c014f224 c014f230 60000053 ff=
ffffff
<4>[  570.337402] [<c0138ac8>] (__irq_svc+0x48/0xa8) from [<c014f230>]
(omap3_enter_idle+0x104/0x134)
<4>[  570.337432] [<c014f230>] (omap3_enter_idle+0x104/0x134) from [<c0=
3ef4f4>]
(cpuidle_idle_call+0xa4/0x108)
<4>[  570.337463] [<c03ef4f4>] (cpuidle_idle_call+0xa4/0x108) from [<c0=
139cf0>]
(cpu_idle+0x40/0x94)
<4>[  570.337493] [<c0139cf0>] (cpu_idle+0x40/0x94) from [<c0108984>]
(start_kernel+0x280/0x2e0)
<4>[  570.337493] unwind: Unknown symbol address c0108984
<4>[  570.337493] unwind: Index not found c0108984
<4>[  570.337524] ---[ end trace 069f4a4f8aedac22 ]---
<4>[  570.348876] ------------[ cut here ]------------
<4>[  570.348907] WARNING: at /kernel/omap/lib/list_debug.c:30
__list_add+0x60/0x80()
<4>[  570.348937] Process swapper (0)
<4>[  570.348937] list_add corruption. prev->next should be next (d76f3=
e50), but
was ced0bd98. (prev=3Dced0bb18).
<4>[  570.348968] Modules linked in: blackberry cdc_acm sierra option u=
sb_wwan
hso omap3_isp tnx_mxt_ts cp210x pl2303 usbserial 88w8688_wlan tun omap_=
hsmmc
<4>[  570.349029] [<c013e608>] (unwind_backtrace+0x0/0xf0) from [<c016f=
828>]
(warn_slowpath_common+0x6c/0x88)
<4>[  570.349060] [<c016f828>] (warn_slowpath_common+0x6c/0x88) from
[<c016f8c4>] (warn_slowpath_fmt+0x2c/0x3c)
<4>[  570.349060] [<c016f8c4>] (warn_slowpath_fmt+0x2c/0x3c) from [<c02=
983fc>]
(__list_add+0x60/0x80)
<4>[  570.349090] [<c02983fc>] (__list_add+0x60/0x80) from [<c034e8d0>]
(usb_hcd_link_urb_to_ep+0x88/0xb8)
<4>[  570.349121] [<c034e8d0>] (usb_hcd_link_urb_to_ep+0x88/0xb8) from
[<c0365cc0>] (ehci_urb_enqueue+0x584/0xee0)
<4>[  570.349151] [<c0365cc0>] (ehci_urb_enqueue+0x584/0xee0) from [<c0=
3509b4>]
(usb_hcd_submit_urb+0x92c/0x960)
<4>[  570.349182] [<c03509b4>] (usb_hcd_submit_urb+0x92c/0x960) from
[<c042403c>] (snd_complete_urb+0x204/0x258)
<4>[  570.349212] [<c042403c>] (snd_complete_urb+0x204/0x258) from [<c0=
34f494>]
(usb_hcd_giveback_urb+0xa0/0xec)
<4>[  570.349212] [<c034f494>] (usb_hcd_giveback_urb+0xa0/0xec) from
[<c0360728>] (ehci_urb_done+0x100/0x120)
<4>[  570.349243] [<c0360728>] (ehci_urb_done+0x100/0x120) from [<c0362=
600>]
(ehci_work+0x550/0x9b4)
<4>[  570.349273] [<c0362600>] (ehci_work+0x550/0x9b4) from [<c0364b88>=
]
(ehci_irq+0x218/0x260)
<4>[  570.349273] [<c0364b88>] (ehci_irq+0x218/0x260) from [<c034ebd0>]
(usb_hcd_irq+0x38/0x90)
<4>[  570.349304] [<c034ebd0>] (usb_hcd_irq+0x38/0x90) from [<c01a8e38>=
]
(handle_IRQ_event+0x24/0xe4)
<4>[  570.349334] [<c01a8e38>] (handle_IRQ_event+0x24/0xe4) from [<c01a=
b034>]
(handle_level_irq+0xdc/0x188)
<4>[  570.349365] [<c01ab034>] (handle_level_irq+0xdc/0x188) from [<c01=
3806c>]
(asm_do_IRQ+0x6c/0x8c)
<4>[  570.349365] [<c013806c>] (asm_do_IRQ+0x6c/0x8c) from [<c0138ac8>]
(__irq_svc+0x48/0xa8)
<4>[  570.349395] Exception stack(0xc065bf30 to 0xc065bf78)
<4>[  570.349395] bf20:                                     0007ad24 00=
000000
0007ad24 00000000
<4>[  570.349426] bf40: c06ae684 c06ae684 00000003 00000003 8012bd80 41=
3fc082
00000000 00000000
<4>[  570.349426] bf60: 3b9ac9ff c065bf78 c014f224 c014f230 60000053 ff=
ffffff
<4>[  570.349456] [<c0138ac8>] (__irq_svc+0x48/0xa8) from [<c014f230>]
(omap3_enter_idle+0x104/0x134)
<4>[  570.349487] [<c014f230>] (omap3_enter_idle+0x104/0x134) from [<c0=
3ef4f4>]
(cpuidle_idle_call+0xa4/0x108)
<4>[  570.349487] [<c03ef4f4>] (cpuidle_idle_call+0xa4/0x108) from [<c0=
139cf0>]
(cpu_idle+0x40/0x94)
<4>[  570.349517] [<c0139cf0>] (cpu_idle+0x40/0x94) from [<c0108984>]
(start_kernel+0x280/0x2e0)
<4>[  570.349548] unwind: Unknown symbol address c0108984
<4>[  570.349548] unwind: Index not found c0108984
<4>[  570.349548] ---[ end trace 069f4a4f8aedac23 ]---
<4>[  570.360900] ------------[ cut here ]------------
<4>[  570.360931] WARNING: at /kernel/omap/lib/list_debug.c:30
__list_add+0x60/0x80()
<4>[  570.360931] Process swapper (0)
<4>[  570.360961] list_add corruption. prev->next should be next (d76f3=
e50), but
was ced0bd98. (prev=3Dced0bb18).
<4>[  570.360961] Modules linked in: blackberry cdc_acm sierra option u=
sb_wwan
hso omap3_isp tnx_mxt_ts cp210x pl2303 usbserial 88w8688_wlan tun omap_=
hsmmc
<4>[  570.361053] [<c013e608>] (unwind_backtrace+0x0/0xf0) from [<c016f=
828>]
(warn_slowpath_common+0x6c/0x88)
<4>[  570.361053] [<c016f828>] (warn_slowpath_common+0x6c/0x88) from
[<c016f8c4>] (warn_slowpath_fmt+0x2c/0x3c)
<4>[  570.361083] [<c016f8c4>] (warn_slowpath_fmt+0x2c/0x3c) from [<c02=
983fc>]
(__list_add+0x60/0x80)
<4>[  570.361114] [<c02983fc>] (__list_add+0x60/0x80) from [<c034e8d0>]
(usb_hcd_link_urb_to_ep+0x88/0xb8)
<4>[  570.361145] [<c034e8d0>] (usb_hcd_link_urb_to_ep+0x88/0xb8) from
[<c0365cc0>] (ehci_urb_enqueue+0x584/0xee0)
<4>[  570.361175] [<c0365cc0>] (ehci_urb_enqueue+0x584/0xee0) from [<c0=
3509b4>]
(usb_hcd_submit_urb+0x92c/0x960)
<4>[  570.361175] [<c03509b4>] (usb_hcd_submit_urb+0x92c/0x960) from
[<c042403c>] (snd_complete_urb+0x204/0x258)
<4>[  570.361206] [<c042403c>] (snd_complete_urb+0x204/0x258) from [<c0=
34f494>]
(usb_hcd_giveback_urb+0xa0/0xec)
<4>[  570.361236] [<c034f494>] (usb_hcd_giveback_urb+0xa0/0xec) from
[<c0360728>] (ehci_urb_done+0x100/0x120)
<4>[  570.361267] [<c0360728>] (ehci_urb_done+0x100/0x120) from [<c0362=
600>]
(ehci_work+0x550/0x9b4)
<4>[  570.361267] [<c0362600>] (ehci_work+0x550/0x9b4) from [<c0364b88>=
]
(ehci_irq+0x218/0x260)
<4>[  570.361297] [<c0364b88>] (ehci_irq+0x218/0x260) from [<c034ebd0>]
(usb_hcd_irq+0x38/0x90)
<4>[  570.361328] [<c034ebd0>] (usb_hcd_irq+0x38/0x90) from [<c01a8e38>=
]
(handle_IRQ_event+0x24/0xe4)
<4>[  570.361358] [<c01a8e38>] (handle_IRQ_event+0x24/0xe4) from [<c01a=
b034>]
(handle_level_irq+0xdc/0x188)
<4>[  570.361358] [<c01ab034>] (handle_level_irq+0xdc/0x188) from [<c01=
3806c>]
(asm_do_IRQ+0x6c/0x8c)
<4>[  570.361389] [<c013806c>] (asm_do_IRQ+0x6c/0x8c) from [<c0138ac8>]
(__irq_svc+0x48/0xa8)
<4>[  570.361389] Exception stack(0xc065bf30 to 0xc065bf78)
<4>[  570.361419] bf20:                                     000198f4 00=
000000
000198f4 00000000
<4>[  570.361419] bf40: c06ae6a0 c06ae684 00000003 00000003 8012bd80 41=
3fc082
00000000 00000000
<4>[  570.361450] bf60: 3b9ac9ff c065bf78 c014f224 c014f230 60000053 ff=
ffffff
<4>[  570.361480] [<c0138ac8>] (__irq_svc+0x48/0xa8) from [<c014f230>]
(omap3_enter_idle+0x104/0x134)
<4>[  570.361480] [<c014f230>] (omap3_enter_idle+0x104/0x134) from [<c0=
3ef4f4>]
(cpuidle_idle_call+0xa4/0x108)
<4>[  570.361511] [<c03ef4f4>] (cpuidle_idle_call+0xa4/0x108) from [<c0=
139cf0>]
(cpu_idle+0x40/0x94)
<4>[  570.361541] [<c0139cf0>] (cpu_idle+0x40/0x94) from [<c0108984>]
(start_kernel+0x280/0x2e0)
<4>[  570.361541] unwind: Unknown symbol address c0108984
<4>[  570.361541] unwind: Index not found c0108984
<4>[  570.361572] ---[ end trace 069f4a4f8aedac24 ]---
<4>[  570.372894] ------------[ cut here ]------------
<4>[  570.372924] WARNING: at /kernel/omap/lib/list_debug.c:30
__list_add+0x60/0x80()
<4>[  570.372924] Process swapper (0)
<4>[  570.372955] list_add corruption. prev->next should be next (d76f3=
e50), but
was ced0bd98. (prev=3Dced0bb18).
<4>[  570.372955] Modules linked in: blackberry cdc_acm sierra option u=
sb_wwan
hso omap3_isp tnx_mxt_ts cp210x pl2303 usbserial 88w8688_wlan tun omap_=
hsmmc
<4>[  570.373016] [<c013e608>] (unwind_backtrace+0x0/0xf0) from [<c016f=
828>]
(warn_slowpath_common+0x6c/0x88)
<4>[  570.373046] [<c016f828>] (warn_slowpath_common+0x6c/0x88) from
[<c016f8c4>] (warn_slowpath_fmt+0x2c/0x3c)
<4>[  570.373077] [<c016f8c4>] (warn_slowpath_fmt+0x2c/0x3c) from [<c02=
983fc>]
(__list_add+0x60/0x80)
<4>[  570.373107] [<c02983fc>] (__list_add+0x60/0x80) from [<c034e8d0>]
(usb_hcd_link_urb_to_ep+0x88/0xb8)
<4>[  570.373138] [<c034e8d0>] (usb_hcd_link_urb_to_ep+0x88/0xb8) from
[<c0365cc0>] (ehci_urb_enqueue+0x584/0xee0)
<4>[  570.373138] [<c0365cc0>] (ehci_urb_enqueue+0x584/0xee0) from [<c0=
3509b4>]
(usb_hcd_submit_urb+0x92c/0x960)
<4>[  570.373168] [<c03509b4>] (usb_hcd_submit_urb+0x92c/0x960) from
[<c042403c>] (snd_complete_urb+0x204/0x258)
<4>[  570.373199] [<c042403c>] (snd_complete_urb+0x204/0x258) from [<c0=
34f494>]
(usb_hcd_giveback_urb+0xa0/0xec)
<4>[  570.373229] [<c034f494>] (usb_hcd_giveback_urb+0xa0/0xec) from
[<c0360728>] (ehci_urb_done+0x100/0x120)
<4>[  570.373229] [<c0360728>] (ehci_urb_done+0x100/0x120) from [<c0362=
600>]
(ehci_work+0x550/0x9b4)
<4>[  570.373260] [<c0362600>] (ehci_work+0x550/0x9b4) from [<c0364b88>=
]
(ehci_irq+0x218/0x260)
<4>[  570.373260] [<c0364b88>] (ehci_irq+0x218/0x260) from [<c034ebd0>]
(usb_hcd_irq+0x38/0x90)
<4>[  570.373291] [<c034ebd0>] (usb_hcd_irq+0x38/0x90) from [<c01a8e38>=
]
(handle_IRQ_event+0x24/0xe4)
<4>[  570.373321] [<c01a8e38>] (handle_IRQ_event+0x24/0xe4) from [<c01a=
b034>]
(handle_level_irq+0xdc/0x188)
<4>[  570.373352] [<c01ab034>] (handle_level_irq+0xdc/0x188) from [<c01=
3806c>]
(asm_do_IRQ+0x6c/0x8c)
<4>[  570.373382] [<c013806c>] (asm_do_IRQ+0x6c/0x8c) from [<c0138ac8>]
(__irq_svc+0x48/0xa8)
<4>[  570.373382] Exception stack(0xc065bf30 to 0xc065bf78)
<4>[  570.373382] bf20:                                     0004747a 00=
000000
0004747a 00000000
<4>[  570.373413] bf40: c06ae684 c06ae684 00000003 00000003 8012bd80 41=
3fc082
00000000 00000000
<4>[  570.373443] bf60: 3b9ac9ff c065bf78 c014f224 c014f230 60000053 ff=
ffffff
<4>[  570.373443] [<c0138ac8>] (__irq_svc+0x48/0xa8) from [<c014f230>]
(omap3_enter_idle+0x104/0x134)
<4>[  570.373474] [<c014f230>] (omap3_enter_idle+0x104/0x134) from [<c0=
3ef4f4>]
(cpuidle_idle_call+0xa4/0x108)
<4>[  570.373504] [<c03ef4f4>] (cpuidle_idle_call+0xa4/0x108) from [<c0=
139cf0>]
(cpu_idle+0x40/0x94)
<4>[  570.373504] [<c0139cf0>] (cpu_idle+0x40/0x94) from [<c0108984>]
(start_kernel+0x280/0x2e0)
<4>[  570.373535] unwind: Unknown symbol address c0108984
<4>[  570.373535] unwind: Index not found c0108984
<4>[  570.373535] ---[ end trace 069f4a4f8aedac25 ]---
<4>[  570.384857] ------------[ cut here ]------------
<4>[  570.384887] WARNING: at /kernel/omap/lib/list_debug.c:30
__list_add+0x60/0x80()
<4>[  570.384918] Process swapper (0)
<4>[  570.384918] list_add corruption. prev->next should be next (d76f3=
e50), but
was ced0bd98. (prev=3Dced0bb18).
<4>[  570.384948] Modules linked in: blackberry cdc_acm sierra option u=
sb_wwan
hso omap3_isp tnx_mxt_ts cp210x pl2303 usbserial 88w8688_wlan tun omap_=
hsmmc
<4>[  570.385009] [<c013e608>] (unwind_backtrace+0x0/0xf0) from [<c016f=
828>]
(warn_slowpath_common+0x6c/0x88)
<4>[  570.385009] [<c016f828>] (warn_slowpath_common+0x6c/0x88) from
[<c016f8c4>] (warn_slowpath_fmt+0x2c/0x3c)
<4>[  570.385040] [<c016f8c4>] (warn_slowpath_fmt+0x2c/0x3c) from [<c02=
983fc>]
(__list_add+0x60/0x80)
<4>[  570.385070] [<c02983fc>] (__list_add+0x60/0x80) from [<c034e8d0>]
(usb_hcd_link_urb_to_ep+0x88/0xb8)
<4>[  570.385101] [<c034e8d0>] (usb_hcd_link_urb_to_ep+0x88/0xb8) from
[<c0365cc0>] (ehci_urb_enqueue+0x584/0xee0)
<4>[  570.385101] [<c0365cc0>] (ehci_urb_enqueue+0x584/0xee0) from [<c0=
3509b4>]
(usb_hcd_submit_urb+0x92c/0x960)
<4>[  570.385131] [<c03509b4>] (usb_hcd_submit_urb+0x92c/0x960) from
[<c042403c>] (snd_complete_urb+0x204/0x258)
<4>[  570.385162] [<c042403c>] (snd_complete_urb+0x204/0x258) from [<c0=
34f494>]
(usb_hcd_giveback_urb+0xa0/0xec)
<4>[  570.385192] [<c034f494>] (usb_hcd_giveback_urb+0xa0/0xec) from
[<c0360728>] (ehci_urb_done+0x100/0x120)
<4>[  570.385192] [<c0360728>] (ehci_urb_done+0x100/0x120) from [<c0362=
600>]
(ehci_work+0x550/0x9b4)
<4>[  570.385223] [<c0362600>] (ehci_work+0x550/0x9b4) from [<c0364b88>=
]
(ehci_irq+0x218/0x260)
<4>[  570.385253] [<c0364b88>] (ehci_irq+0x218/0x260) from [<c034ebd0>]
(usb_hcd_irq+0x38/0x90)
<4>[  570.385253] [<c034ebd0>] (usb_hcd_irq+0x38/0x90) from [<c01a8e38>=
]
(handle_IRQ_event+0x24/0xe4)
<4>[  570.385284] [<c01a8e38>] (handle_IRQ_event+0x24/0xe4) from [<c01a=
b034>]
(handle_level_irq+0xdc/0x188)
<4>[  570.385314] [<c01ab034>] (handle_level_irq+0xdc/0x188) from [<c01=
3806c>]
(asm_do_IRQ+0x6c/0x8c)
<4>[  570.385314] [<c013806c>] (asm_do_IRQ+0x6c/0x8c) from [<c0138ac8>]
(__irq_svc+0x48/0xa8)
<4>[  570.385345] Exception stack(0xc065bf30 to 0xc065bf78)
<4>[  570.385345] bf20:                                     000e8cc2 00=
000000
000e8cc2 00000000
<4>[  570.385375] bf40: c06ae684 c06ae684 00000003 00000003 8012bd80 41=
3fc082
00000000 00000000
<4>[  570.385375] bf60: 3b9ac9ff c065bf78 c014f224 c014f230 60000053 ff=
ffffff
<4>[  570.385406] [<c0138ac8>] (__irq_svc+0x48/0xa8) from [<c014f230>]
(omap3_enter_idle+0x104/0x134)
<4>[  570.385437] [<c014f230>] (omap3_enter_idle+0x104/0x134) from [<c0=
3ef4f4>]
(cpuidle_idle_call+0xa4/0x108)
<4>[  570.385437] [<c03ef4f4>] (cpuidle_idle_call+0xa4/0x108) from [<c0=
139cf0>]
(cpu_idle+0x40/0x94)
<4>[  570.385467] [<c0139cf0>] (cpu_idle+0x40/0x94) from [<c0108984>]
(start_kernel+0x280/0x2e0)
<4>[  570.385498] unwind: Unknown symbol address c0108984
<4>[  570.385498] unwind: Index not found c0108984
<4>[  570.385498] ---[ end trace 069f4a4f8aedac26 ]---
<4>[  570.396881] ------------[ cut here ]------------
<4>[  570.396911] WARNING: at /kernel/omap/lib/list_debug.c:30
__list_add+0x60/0x80()
<4>[  570.396942] Process swapper (0)
<4>[  570.396942] list_add corruption. prev->next should be next (d76f3=
e50), but
was ced0bd98. (prev=3Dced0bb18).
<4>[  570.396942] Modules linked in: blackberry cdc_acm sierra option u=
sb_wwan
hso omap3_isp tnx_mxt_ts cp210x pl2303 usbserial 88w8688_wlan tun omap_=
hsmmc
<4>[  570.397003] [<c013e608>] (unwind_backtrace+0x0/0xf0) from [<c016f=
828>]
(warn_slowpath_common+0x6c/0x88)
<4>[  570.397033] [<c016f828>] (warn_slowpath_common+0x6c/0x88) from
[<c016f8c4>] (warn_slowpath_fmt+0x2c/0x3c)
<4>[  570.397064] [<c016f8c4>] (warn_slowpath_fmt+0x2c/0x3c) from [<c02=
983fc>]
(__list_add+0x60/0x80)
<4>[  570.397094] [<c02983fc>] (__list_add+0x60/0x80) from [<c034e8d0>]
(usb_hcd_link_urb_to_ep+0x88/0xb8)
<4>[  570.397094] [<c034e8d0>] (usb_hcd_link_urb_to_ep+0x88/0xb8) from
[<c0365cc0>] (ehci_urb_enqueue+0x584/0xee0)
<4>[  570.397125] [<c0365cc0>] (ehci_urb_enqueue+0x584/0xee0) from [<c0=
3509b4>]
(usb_hcd_submit_urb+0x92c/0x960)
<4>[  570.397155] [<c03509b4>] (usb_hcd_submit_urb+0x92c/0x960) from
[<c042403c>] (snd_complete_urb+0x204/0x258)
<4>[  570.397186] [<c042403c>] (snd_complete_urb+0x204/0x258) from [<c0=
34f494>]
(usb_hcd_giveback_urb+0xa0/0xec)
<4>[  570.397186] [<c034f494>] (usb_hcd_giveback_urb+0xa0/0xec) from
[<c0360728>] (ehci_urb_done+0x100/0x120)
<4>[  570.397216] [<c0360728>] (ehci_urb_done+0x100/0x120) from [<c0362=
600>]
(ehci_work+0x550/0x9b4)
<4>[  570.397247] [<c0362600>] (ehci_work+0x550/0x9b4) from [<c0364b88>=
]
(ehci_irq+0x218/0x260)
<4>[  570.397247] [<c0364b88>] (ehci_irq+0x218/0x260) from [<c034ebd0>]
(usb_hcd_irq+0x38/0x90)
<4>[  570.397277] [<c034ebd0>] (usb_hcd_irq+0x38/0x90) from [<c01a8e38>=
]
(handle_IRQ_event+0x24/0xe4)
<4>[  570.397308] [<c01a8e38>] (handle_IRQ_event+0x24/0xe4) from [<c01a=
b034>]
(handle_level_irq+0xdc/0x188)
<4>[  570.397308] [<c01ab034>] (handle_level_irq+0xdc/0x188) from [<c01=
3806c>]
(asm_do_IRQ+0x6c/0x8c)
<4>[  570.397338] [<c013806c>] (asm_do_IRQ+0x6c/0x8c) from [<c0138ac8>]
(__irq_svc+0x48/0xa8)
<4>[  570.397369] Exception stack(0xc065bf30 to 0xc065bf78)
<4>[  570.397369] bf20:                                     00018d63 00=
000000
00018d63 00000000
<4>[  570.397399] bf40: c06ae684 c06ae684 00000003 00000003 8012bd80 41=
3fc082
00000000 00000000
<4>[  570.397399] bf60: 3b9ac9ff c065bf78 c014f224 c014f230 60000053 ff=
ffffff
<4>[  570.397430] [<c0138ac8>] (__irq_svc+0x48/0xa8) from [<c014f230>]
(omap3_enter_idle+0x104/0x134)
<4>[  570.397430] [<c014f230>] (omap3_enter_idle+0x104/0x134) from [<c0=
3ef4f4>]
(cpuidle_idle_call+0xa4/0x108)
<4>[  570.397460] [<c03ef4f4>] (cpuidle_idle_call+0xa4/0x108) from [<c0=
139cf0>]
(cpu_idle+0x40/0x94)
<4>[  570.397491] [<c0139cf0>] (cpu_idle+0x40/0x94) from [<c0108984>]
(start_kernel+0x280/0x2e0)
<4>[  570.397491] unwind: Unknown symbol address c0108984
<4>[  570.397521] unwind: Index not found c0108984
<4>[  570.397521] ---[ end trace 069f4a4f8aedac27 ]---
<4>[  570.408874] ------------[ cut here ]------------
<4>[  570.408905] WARNING: at /kernel/omap/lib/list_debug.c:30
__list_add+0x60/0x80()
<4>[  570.408905] Process swapper (0)
<4>[  570.408935] list_add corruption. prev->next should be next (d76f3=
e50), but
was ced0bd98. (prev=3Dced0bb18).
<4>[  570.408935] Modules linked in: blackberry cdc_acm sierra option u=
sb_wwan
hso omap3_isp tnx_mxt_ts cp210x pl2303 usbserial 88w8688_wlan tun omap_=
hsmmc
<4>[  570.408996] [<c013e608>] (unwind_backtrace+0x0/0xf0) from [<c016f=
828>]
(warn_slowpath_common+0x6c/0x88)
<4>[  570.409027] [<c016f828>] (warn_slowpath_common+0x6c/0x88) from
[<c016f8c4>] (warn_slowpath_fmt+0x2c/0x3c)
<4>[  570.409057] [<c016f8c4>] (warn_slowpath_fmt+0x2c/0x3c) from [<c02=
983fc>]
(__list_add+0x60/0x80)
<4>[  570.409057] [<c02983fc>] (__list_add+0x60/0x80) from [<c034e8d0>]
(usb_hcd_link_urb_to_ep+0x88/0xb8)
<4>[  570.409088] [<c034e8d0>] (usb_hcd_link_urb_to_ep+0x88/0xb8) from
[<c0365cc0>] (ehci_urb_enqueue+0x584/0xee0)
<4>[  570.409118] [<c0365cc0>] (ehci_urb_enqueue+0x584/0xee0) from [<c0=
3509b4>]
(usb_hcd_submit_urb+0x92c/0x960)
<4>[  570.409149] [<c03509b4>] (usb_hcd_submit_urb+0x92c/0x960) from
[<c042403c>] (snd_complete_urb+0x204/0x258)
<4>[  570.409179] [<c042403c>] (snd_complete_urb+0x204/0x258) from [<c0=
34f494>]
(usb_hcd_giveback_urb+0xa0/0xec)
<4>[  570.409179] [<c034f494>] (usb_hcd_giveback_urb+0xa0/0xec) from
[<c0360728>] (ehci_urb_done+0x100/0x120)
<4>[  570.409210] [<c0360728>] (ehci_urb_done+0x100/0x120) from [<c0362=
600>]
(ehci_work+0x550/0x9b4)
<4>[  570.409210] [<c0362600>] (ehci_work+0x550/0x9b4) from [<c0364b88>=
]
(ehci_irq+0x218/0x260)
<4>[  570.409240] [<c0364b88>] (ehci_irq+0x218/0x260) from [<c034ebd0>]
(usb_hcd_irq+0x38/0x90)
<4>[  570.409271] [<c034ebd0>] (usb_hcd_irq+0x38/0x90) from [<c01a8e38>=
]
(handle_IRQ_event+0x24/0xe4)
<4>[  570.409301] [<c01a8e38>] (handle_IRQ_event+0x24/0xe4) from [<c01a=
b034>]
(handle_level_irq+0xdc/0x188)
<4>[  570.409301] [<c01ab034>] (handle_level_irq+0xdc/0x188) from [<c01=
3806c>]
(asm_do_IRQ+0x6c/0x8c)
<4>[  570.409332] [<c013806c>] (asm_do_IRQ+0x6c/0x8c) from [<c0138ac8>]
(__irq_svc+0x48/0xa8)
<4>[  570.409332] Exception stack(0xc065bf30 to 0xc065bf78)
<4>[  570.409362] bf20:                                     00019941 00=
000000
00019941 00000000
<4>[  570.409362] bf40: c06ae684 c06ae684 00000003 00000003 8012bd80 41=
3fc082
00000000 00000000
<4>[  570.409393] bf60: 3b9ac9ff c065bf78 c014f224 c014f230 60000053 ff=
ffffff
<4>[  570.409423] [<c0138ac8>] (__irq_svc+0x48/0xa8) from [<c014f230>]
(omap3_enter_idle+0x104/0x134)
<4>[  570.409423] [<c014f230>] (omap3_enter_idle+0x104/0x134) from [<c0=
3ef4f4>]
(cpuidle_idle_call+0xa4/0x108)
<4>[  570.409454] [<c03ef4f4>] (cpuidle_idle_call+0xa4/0x108) from [<c0=
139cf0>]
(cpu_idle+0x40/0x94)
<4>[  570.409484] [<c0139cf0>] (cpu_idle+0x40/0x94) from [<c0108984>]
(start_kernel+0x280/0x2e0)
<4>[  570.409484] unwind: Unknown symbol address c0108984
<4>[  570.409484] unwind: Index not found c0108984
<4>[  570.409515] ---[ end trace 069f4a4f8aedac28 ]---
<4>[  570.420837] ------------[ cut here ]------------
<4>[  570.420867] WARNING: at /kernel/omap/lib/list_debug.c:30
__list_add+0x60/0x80()
<4>[  570.420898] Process swapper (0)
<4>[  570.420898] list_add corruption. prev->next should be next (d76f3=
e50), but
was ced0bd98. (prev=3Dced0bb18).
<4>[  570.420898] Modules linked in: blackberry cdc_acm sierra option u=
sb_wwan
hso omap3_isp tnx_mxt_ts cp210x pl2303 usbserial 88w8688_wlan tun omap_=
hsmmc
<4>[  570.420989] [<c013e608>] (unwind_backtrace+0x0/0xf0) from [<c016f=
828>]
(warn_slowpath_common+0x6c/0x88)
<4>[  570.421020] [<c016f828>] (warn_slowpath_common+0x6c/0x88) from
[<c016f8c4>] (warn_slowpath_fmt+0x2c/0x3c)
<4>[  570.421020] [<c016f8c4>] (warn_slowpath_fmt+0x2c/0x3c) from [<c02=
983fc>]
(__list_add+0x60/0x80)
<4>[  570.421051] [<c02983fc>] (__list_add+0x60/0x80) from [<c034e8d0>]
(usb_hcd_link_urb_to_ep+0x88/0xb8)
<4>[  570.421081] [<c034e8d0>] (usb_hcd_link_urb_to_ep+0x88/0xb8) from
[<c0365cc0>] (ehci_urb_enqueue+0x584/0xee0)
<4>[  570.421112] [<c0365cc0>] (ehci_urb_enqueue+0x584/0xee0) from [<c0=
3509b4>]
(usb_hcd_submit_urb+0x92c/0x960)
<4>[  570.421142] [<c03509b4>] (usb_hcd_submit_urb+0x92c/0x960) from
[<c042403c>] (snd_complete_urb+0x204/0x258)
<4>[  570.421142] [<c042403c>] (snd_complete_urb+0x204/0x258) from [<c0=
34f494>]
(usb_hcd_giveback_urb+0xa0/0xec)
<4>[  570.421173] [<c034f494>] (usb_hcd_giveback_urb+0xa0/0xec) from
[<c0360728>] (ehci_urb_done+0x100/0x120)
<4>[  570.421203] [<c0360728>] (ehci_urb_done+0x100/0x120) from [<c0362=
600>]
(ehci_work+0x550/0x9b4)
<4>[  570.421203] [<c0362600>] (ehci_work+0x550/0x9b4) from [<c0364b88>=
]
(ehci_irq+0x218/0x260)
<4>[  570.421234] [<c0364b88>] (ehci_irq+0x218/0x260) from [<c034ebd0>]
(usb_hcd_irq+0x38/0x90)
<4>[  570.421264] [<c034ebd0>] (usb_hcd_irq+0x38/0x90) from [<c01a8e38>=
]
(handle_IRQ_event+0x24/0xe4)
<4>[  570.421295] [<c01a8e38>] (handle_IRQ_event+0x24/0xe4) from [<c01a=
b034>]
(handle_level_irq+0xdc/0x188)
<4>[  570.421295] [<c01ab034>] (handle_level_irq+0xdc/0x188) from [<c01=
3806c>]
(asm_do_IRQ+0x6c/0x8c)
<4>[  570.421325] [<c013806c>] (asm_do_IRQ+0x6c/0x8c) from [<c0138ac8>]
(__irq_svc+0x48/0xa8)
<4>[  570.421325] Exception stack(0xc065bf30 to 0xc065bf78)
<4>[  570.421356] bf20:                                     0002af59 00=
000000
0002af59 00000000
<4>[  570.421356] bf40: c06ae684 c06ae684 00000003 00000003 8012bd80 41=
3fc082
00000000 00000000
<4>[  570.421386] bf60: 3b9ac9ff c065bf78 c014f224 c014f230 60000053 ff=
ffffff
<4>[  570.421417] [<c0138ac8>] (__irq_svc+0x48/0xa8) from [<c014f230>]
(omap3_enter_idle+0x104/0x134)
<4>[  570.421417] [<c014f230>] (omap3_enter_idle+0x104/0x134) from [<c0=
3ef4f4>]
(cpuidle_idle_call+0xa4/0x108)
<4>[  570.421447] [<c03ef4f4>] (cpuidle_idle_call+0xa4/0x108) from [<c0=
139cf0>]
(cpu_idle+0x40/0x94)
<4>[  570.421478] [<c0139cf0>] (cpu_idle+0x40/0x94) from [<c0108984>]
(start_kernel+0x280/0x2e0)
<4>[  570.421478] unwind: Unknown symbol address c0108984
<4>[  570.421478] unwind: Index not found c0108984
<4>[  570.421508] ---[ end trace 069f4a4f8aedac29 ]---
<4>[  570.432861] ------------[ cut here ]------------
<4>[  570.432891] WARNING: at /kernel/omap/lib/list_debug.c:30
__list_add+0x60/0x80()
<4>[  570.432922] Process swapper (0)
<4>[  570.432922] list_add corruption. prev->next should be next (d76f3=
e50), but
was ced0bd98. (prev=3Dced0bb18).
<4>[  570.432922] Modules linked in: blackberry cdc_acm sierra option u=
sb_wwan
hso omap3_isp tnx_mxt_ts cp210x pl2303 usbserial 88w8688_wlan tun omap_=
hsmmc
<4>[  570.433013] [<c013e608>] (unwind_backtrace+0x0/0xf0) from [<c016f=
828>]
(warn_slowpath_common+0x6c/0x88)
<4>[  570.433013] [<c016f828>] (warn_slowpath_common+0x6c/0x88) from
[<c016f8c4>] (warn_slowpath_fmt+0x2c/0x3c)
<4>[  570.433044] [<c016f8c4>] (warn_slowpath_fmt+0x2c/0x3c) from [<c02=
983fc>]
(__list_add+0x60/0x80)
<4>[  570.433074] [<c02983fc>] (__list_add+0x60/0x80) from [<c034e8d0>]
(usb_hcd_link_urb_to_ep+0x88/0xb8)
<4>[  570.433074] [<c034e8d0>] (usb_hcd_link_urb_to_ep+0x88/0xb8) from
[<c0365cc0>] (ehci_urb_enqueue+0x584/0xee0)
<4>[  570.433105] [<c0365cc0>] (ehci_urb_enqueue+0x584/0xee0) from [<c0=
3509b4>]
(usb_hcd_submit_urb+0x92c/0x960)
<4>[  570.433135] [<c03509b4>] (usb_hcd_submit_urb+0x92c/0x960) from
[<c042403c>] (snd_complete_urb+0x204/0x258)
<4>[  570.433166] [<c042403c>] (snd_complete_urb+0x204/0x258) from [<c0=
34f494>]
(usb_hcd_giveback_urb+0xa0/0xec)
<4>[  570.433197] [<c034f494>] (usb_hcd_giveback_urb+0xa0/0xec) from
[<c0360728>] (ehci_urb_done+0x100/0x120)
<4>[  570.433197] [<c0360728>] (ehci_urb_done+0x100/0x120) from [<c0362=
600>]
(ehci_work+0x550/0x9b4)
<4>[  570.433227] [<c0362600>] (ehci_work+0x550/0x9b4) from [<c0364b88>=
]
(ehci_irq+0x218/0x260)
<4>[  570.433227] [<c0364b88>] (ehci_irq+0x218/0x260) from [<c034ebd0>]
(usb_hcd_irq+0x38/0x90)
<4>[  570.433258] [<c034ebd0>] (usb_hcd_irq+0x38/0x90) from [<c01a8e38>=
]
(handle_IRQ_event+0x24/0xe4)
<4>[  570.433288] [<c01a8e38>] (handle_IRQ_event+0x24/0xe4) from [<c01a=
b034>]
(handle_level_irq+0xdc/0x188)
<4>[  570.433319] [<c01ab034>] (handle_level_irq+0xdc/0x188) from [<c01=
3806c>]
(asm_do_IRQ+0x6c/0x8c)
<4>[  570.433319] [<c013806c>] (asm_do_IRQ+0x6c/0x8c) from [<c0138ac8>]
(__irq_svc+0x48/0xa8)
<4>[  570.433349] Exception stack(0xc065bf30 to 0xc065bf78)
<4>[  570.433349] bf20:                                     0007764f 00=
000000
0007764f 00000000
<4>[  570.433380] bf40: c06ae684 c06ae684 00000003 00000003 8012bd80 41=
3fc082
00000000 00000000
<4>[  570.433380] bf60: 3b9ac9ff c065bf78 c014f224 c014f230 60000053 ff=
ffffff
<4>[  570.433410] [<c0138ac8>] (__irq_svc+0x48/0xa8) from [<c014f230>]
(omap3_enter_idle+0x104/0x134)
<4>[  570.433441] [<c014f230>] (omap3_enter_idle+0x104/0x134) from [<c0=
3ef4f4>]
(cpuidle_idle_call+0xa4/0x108)
<4>[  570.433441] [<c03ef4f4>] (cpuidle_idle_call+0xa4/0x108) from [<c0=
139cf0>]
(cpu_idle+0x40/0x94)
<4>[  570.433471] [<c0139cf0>] (cpu_idle+0x40/0x94) from [<c0108984>]
(start_kernel+0x280/0x2e0)
<4>[  570.433471] unwind: Unknown symbol address c0108984
<4>[  570.433502] unwind: Index not found c0108984
<4>[  570.433502] ---[ end trace 069f4a4f8aedac2a ]---
<6>[  570.442962] usb 1-2.4: USB disconnect, address 8
<1>[  570.453521] Unable to handle kernel paging request at virtual add=
ress 6b6b6b6b
<1>[  570.461120] pgd =3D c0104000
<1>[  570.463958] [6b6b6b6b] *pgd=3D00000000
<0>[  570.467712] Internal error: Oops: 5 [#1] PREEMPT
<0>[  570.472534] last sysfs file:
/sys/devices/platform/ehci-omap.0/usb1/1-2/1-2.4/idProduct
<4>[  570.480926] Modules linked in: blackberry cdc_acm sierra option u=
sb_wwan
hso omap3_isp tnx_mxt_ts cp210x pl2303 usbserial 88w8688_wlan tun omap_=
hsmmc
<4>[  570.495025] CPU: 0    Tainted: G        W    (2.6.35.13-02836-g76=
4dcf5 #12)
<4>[  570.502349] PC is at usb_hcd_flush_endpoint+0x9c/0x160
<4>[  570.507751] LR is at usb_disable_endpoint+0x6c/0x84
<4>[  570.512847] pc : [<c034f6b4>]    lr : [<c03518b0>]    psr: 200000=
93
<4>[  570.512878] sp : dfd89e38  ip : 00000002  fp : d7691280
<4>[  570.524902] r10: 6b6b6b53  r9 : 00000100  r8 : df42a100
<4>[  570.530395] r7 : d76f3e50  r6 : d76f3e40  r5 : 6b6b6b53  r4 : dfd=
88000
<4>[  570.537231] r3 : 6b6b6b6b  r2 : 6b6b6b6b  r1 : d76f3e40  r0 : d76=
91280
<4>[  570.544067] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM =
 Segment
kernel
<4>[  570.551818] Control: 10c5387d  Table: 9f7a4019  DAC: 00000015
<4>[  570.557861]
<4>[  570.557861] PC: 0xc034f634:
<4>[  570.562316] f634  e3c4403f e5943004 e2833001 e5843004 e2867010 e5=
965010
e2455018 ea000016
<4>[  570.570953] f654  e5952010 e3520000 12435018 1a000012 e1a00005 eb=
000664
e5943004 e2433001
<4>[  570.579559] f674  e5843004 e5943000 e3130002 0a000000 eb06adc2 e1=
a01005
e3e0206b e1a00008
<4>[  570.588165] f694  ebffff91 e1a00005 eb000687 e5943004 e2833001 e5=
843004
eaffffe5 e1a0a005
<4>[  570.596771] f6b4  e5ba3018 f5d3f000 e15a0007 1affffe3 f1080080 e1=
a0200d
e3c23d7f e3c3303f
<4>[  570.605377] f6d4  e5932004 e2422001 e5832004 e5933000 e3130002 0a=
000000
eb06ada8 e1a0300d
<4>[  570.613983] f6f4  e3c34d7f e3c4403f ea000019 f10c0080 e5943004 e2=
833001
e5843004 e5963010
<4>[  570.622589] f714  e153000a 03a05000 0a000003 e5965014 e2455018 e1=
a00005
eb000633 f1080080
<4>[  570.631195]
<4>[  570.631195] LR: 0xc0351830:
<4>[  570.635681] 1830  059111c4 15911184 e3510000 012fff1e eafff28e e9=
2d4070
e2504000 e1a06002
<4>[  570.644287] 1850  08bd8070 e2113080 e201100f 1a000005 e2811070 e3=
520000
e0841101 e5915004
<4>[  570.652893] 1870  0a000007 ea000005 e2811060 e3520000 e0841101 e5=
915004
0a000001 e3a03000
<4>[  570.661499] 1890  e5813004 e3550000 08bd8070 e3a03000 e1a00004 e5=
853028
e1a01005 ebfff759
<4>[  570.670104] 18b0  e3560000 08bd8070 e1a00004 e1a01005 e8bd4070 ea=
fff265
e92d41f0 e5903180
<4>[  570.678710] 18d0  e1a04000 e1a05001 e3530000 13a07000 1a00000b ea=
00002d
e7936101 e5d63048
<4>[  570.687316] 18f0  e3130002 0a000006 e5d63018 e1a00006 e3833004 e5=
c63018
ebffff85 e2860020
<4>[  570.695922] 1910  ebfecade e5943180 e2871014 e5d32004 e1570002 e2=
877001
baffffee e3a06000
<4>[  570.704528]
<4>[  570.704528] SP: 0xdfd89db8:
<4>[  570.709014] 9db8  dfc00080 dfc02e40 0000000f c01e2060 ceca0258 df=
c05c10
00000010 dfc0010c
<4>[  570.717620] 9dd8  ceca0000 ffffffff dfd89e24 d76f3e40 d76f3e50 c0=
138a6c
d7691280 d76f3e40
<4>[  570.726226] 9df8  6b6b6b6b 6b6b6b6b dfd88000 6b6b6b53 d76f3e40 d7=
6f3e50
df42a100 00000100
<4>[  570.734832] 9e18  6b6b6b53 d7691280 00000002 dfd89e38 c03518b0 c0=
34f6b4
20000093 ffffffff
<4>[  570.743438] 9e38  d7691280 d76f3e40 00000000 00000000 d7691280 00=
000100
c069ac48 c03518b0
<4>[  570.752044] 9e58  0000002c 00000001 d76f30e4 c03519e8 d57c9aa0 d5=
7c9a80
d7691280 00000000
<4>[  570.760650] 9e78  c069ac18 c0354750 d57c9aa0 c069ac48 c068d208 00=
000002
df5902bc 00000100
<4>[  570.769256] 9e98  0000001f c0306708 d57c9ad4 d57c9aa0 c068d208 c0=
306858
d57c9aa0 d76912e8
<4>[  570.777862]
<4>[  570.777893] FP: 0xd7691200:
<4>[  570.782348] 1200  4468ffff 00074409 4468ffff 0007441c 46a00b02 08=
074439
c0000000 00a00000
<4>[  570.790954] 1220  00004000 80080080 00000000 00000022 635688c0 d8=
4156c5
00000021 c0406b78
<4>[  570.799560] 1240  4468ffff 00074409 4468ffff 0007441c 46a00b02 08=
074439
c0000000 0800c000
<4>[  570.808166] 1260  00000001 0a200000 00a00008 40000028 84004000 00=
000000
635688c0 d84156c5
<4>[  570.816772] 1280  00000008 00342e32 00000000 00000000 00000000 00=
000004
00000000 00000003
<4>[  570.825378] 12a0  00000000 00000000 00000009 00000008 df590080 df=
42a100
00000507 00000040
<4>[  570.833984] 12c0  00000000 00000000 d76912c8 d76912c8 d76f3240 d7=
545d80
00000000 00000000
<4>[  570.842590] 12e0  00000001 00000000 df5900e8 d76ae7c0 d72e0300 d5=
7c9aac
dc5ec35c df5900f0
<4>[  570.851196]
<4>[  570.851196] R0: 0xd7691200:
<4>[  570.855682] 1200  4468ffff 00074409 4468ffff 0007441c 46a00b02 08=
074439
c0000000 00a00000
<4>[  570.864288] 1220  00004000 80080080 00000000 00000022 635688c0 d8=
4156c5
00000021 c0406b78
<4>[  570.872894] 1240  4468ffff 00074409 4468ffff 0007441c 46a00b02 08=
074439
c0000000 0800c000
<4>[  570.881500] 1260  00000001 0a200000 00a00008 40000028 84004000 00=
000000
635688c0 d84156c5
<4>[  570.890106] 1280  00000008 00342e32 00000000 00000000 00000000 00=
000004
00000000 00000003
<4>[  570.898712] 12a0  00000000 00000000 00000009 00000008 df590080 df=
42a100
00000507 00000040
<4>[  570.907318] 12c0  00000000 00000000 d76912c8 d76912c8 d76f3240 d7=
545d80
00000000 00000000
<4>[  570.915924] 12e0  00000001 00000000 df5900e8 d76ae7c0 d72e0300 d5=
7c9aac
dc5ec35c df5900f0
<4>[  570.924530]
<4>[  570.924530] R1: 0xd76f3dc0:
<4>[  570.929016] 3dc0  4468ffff 00092409 4468ffff 0009241c 46a00701 08=
092439
c0000000 00040080
<4>[  570.937622] 3de0  00008000 00000000 00000001 00000000 635688c0 d8=
4156c5
00808040 c03558d0
<4>[  570.946228] 3e00  4468ffff 00092409 4468ffff 0009241c 46a8ffff 08=
092439
c0000000 01000080
<4>[  570.954833] 3e20  00000020 00190020 00000500 05800000 50800000 00=
200000
635688c0 d84156c5
<4>[  570.963439] 3e40  01810509 000400c0 00000000 00000000 ced0b758 ce=
d0bb18
cf9ee0c0 00000000
<4>[  570.972045] 3e60  d7259175 00000007 00000000 00000000 00000000 00=
000000
00000000 00000000
<4>[  570.980651] 3e80  4468ffff 00092409 4468ffff 0009241c 46a00b02 08=
092439
c0000000 00400080
<4>[  570.989257] 3ea0  00002000 80004000 01000000 00810000 635688c0 d8=
4156c5
00a80002 c03558d0
<4>[  570.997894]
<4>[  570.997894] R4: 0xdfd87f80:
<4>[  571.002349] 7f80  635688c0 d84156c5 dfd65180 c023041c 635688c0 d8=
4156c5
00000001 00000000
<4>[  571.010955] 7fa0  dfd87a40 dfd87f08 c05c3c7c 00000000 c068a894 00=
000000
00000002 00008124
<4>[  571.019561] 7fc0  0000073c 00000000 635688c0 d84156c5 00000013 c0=
23041c
00000000 00000000
<4>[  571.028167] 7fe0  00000000 c01813f8 dfd63400 c0181354 c01399a0 c0=
1399a0
ffeffdfa fffffb5e
<4>[  571.036773] 8000  00000000 00000003 00000000 dfd68c40 c0670c70 00=
000000
00000015 dfd68c40
<4>[  571.045379] 8020  dfd88000 c06707d8 dc9fdb40 c0670bd4 de3a9690 d7=
4c81c0
dfd89e54 dfd89e28
<4>[  571.053985] 8040  c04fab54 00000000 00000000 00000000 00000000 00=
000000
00000000 00000000
<4>[  571.062591] 8060  00000000 00000000 00000000 00000000 00000000 00=
000000
00000000 00000000
<4>[  571.071228]
<4>[  571.071228] R6: 0xd76f3dc0:
<4>[  571.075683] 3dc0  4468ffff 00092409 4468ffff 0009241c 46a00701 08=
092439
c0000000 00040080
<4>[  571.084289] 3de0  00008000 00000000 00000001 00000000 635688c0 d8=
4156c5
00808040 c03558d0
<4>[  571.092895] 3e00  4468ffff 00092409 4468ffff 0009241c 46a8ffff 08=
092439
c0000000 01000080
<4>[  571.101531] 3e20  00000020 00190020 00000500 05800000 50800000 00=
200000
635688c0 d84156c5
<4>[  571.110137] 3e40  01810509 000400c0 00000000 00000000 ced0b758 ce=
d0bb18
cf9ee0c0 00000000
<4>[  571.118743] 3e60  d7259175 00000007 00000000 00000000 00000000 00=
000000
00000000 00000000
<4>[  571.127349] 3e80  4468ffff 00092409 4468ffff 0009241c 46a00b02 08=
092439
c0000000 00400080
<4>[  571.135955] 3ea0  00002000 80004000 01000000 00810000 635688c0 d8=
4156c5
00a80002 c03558d0
<4>[  571.144561]
<4>[  571.144561] R7: 0xd76f3dd0:
<4>[  571.149017] 3dd0  46a00701 08092439 c0000000 00040080 00008000 00=
000000
00000001 00000000
<4>[  571.157623] 3df0  635688c0 d84156c5 00808040 c03558d0 4468ffff 00=
092409
4468ffff 0009241c
<4>[  571.166259] 3e10  46a8ffff 08092439 c0000000 01000080 00000020 00=
190020
00000500 05800000
<4>[  571.174865] 3e30  50800000 00200000 635688c0 d84156c5 01810509 00=
0400c0
00000000 00000000
<4>[  571.183471] 3e50  ced0b758 ced0bb18 cf9ee0c0 00000000 d7259175 00=
000007
00000000 00000000
<4>[  571.192077] 3e70  00000000 00000000 00000000 00000000 4468ffff 00=
092409
4468ffff 0009241c
<4>[  571.200683] 3e90  46a00b02 08092439 c0000000 00400080 00002000 80=
004000
01000000 00810000
<4>[  571.209289] 3eb0  635688c0 d84156c5 00a80002 c03558d0 4468ffff 00=
092409
4468ffff 0009241c
<4>[  571.217895]
<4>[  571.217895] R8: 0xdf42a080:
<4>[  571.222351] a080  dfffd040 df510000 000000c0 df42a0c0 00000006 ff=
ffffff
00000000 fffffffe
<4>[  571.230957] a0a0  fffffffe fffffffe fffffffe fffffffe fffffffe 00=
000000
00000000 00000000
<4>[  571.239562] a0c0  00000000 00000000 00000000 00000000 00000000 00=
000000
00000000 00000000
<4>[  571.248168] a0e0  00000000 00000000 00000000 00000000 00000000 00=
000000
635688c0 d84156c5
<4>[  571.256774] a100  c066f5d8 00000001 dfcf1d00 00000001 ffffffff 00=
00000f
000059de 00000000
<4>[  571.265380] a120  00000000 00000000 df522080 00000000 c068d19c df=
c73030
00000005 00000005
<4>[  571.273986] a140  00000002 df806aa8 00000000 00000000 0000000c c0=
5f06a6
69636865 6463685f
<4>[  571.282592] a160  6273753a 00000031 00000000 00000000 00000000 00=
200200
ffff8c07 c06efd80
<0>[  571.291229] Process khubd (pid: 269, stack limit =3D 0xdfd882e8)
<0>[  571.297332] Stack: (0xdfd89e38 to 0xdfd8a000)
<0>[  571.301910] 9e20:
d7691280 d76f3e40
<0>[  571.310485] 9e40: 00000000 00000000 d7691280 00000100 c069ac48 c0=
3518b0
0000002c 00000001
<0>[  571.319061] 9e60: d76f30e4 c03519e8 d57c9aa0 d57c9a80 d7691280 00=
000000
c069ac18 c0354750
<0>[  571.327636] 9e80: d57c9aa0 c069ac48 c068d208 00000002 df5902bc 00=
000100
0000001f c0306708
<0>[  571.336242] 9ea0: d57c9ad4 d57c9aa0 c068d208 c0306858 d57c9aa0 d7=
6912e8
c068d208 c0305d80
<0>[  571.344818] 9ec0: d57c9aa0 d76912e8 d57c9a80 c03045a0 d7691280 00=
000000
d57c9a80 c0351914
<0>[  571.353393] 9ee0: d7691280 d769131c d76912e8 d76912fc df5902bc c0=
34c780
dfc91700 00000001
<0>[  571.361968] 9f00: 00000004 dfd88000 df590080 00000100 c068d044 c0=
34d630
dfc1db30 dfc1db00
<0>[  571.370574] 9f20: dfc1db30 dfc1db00 00000001 dfd68c70 df42a118 da=
ff45a0
00000000 daff45a0
<0>[  571.379150] 9f40: df42a100 df590080 00000004 df60d280 df59008c df=
c91703
dfc91738 daff4580
<0>[  571.387725] 9f60: 00000000 00000003 dfc91740 dfc91790 dfc91708 df=
59011c
00000009 dfc9173c
<0>[  571.396301] 9f80: dfc91734 dfd89f94 00000000 dfd68c40 c0185954 df=
d89f94
dfd89f94 00000101
<0>[  571.404876] 9fa0: 01000001 c018560c 00000000 dfc31f68 dfd89fd4 c0=
34d1c4
00000000 00000000
<0>[  571.413452] 9fc0: 00000000 00000000 00000000 c0185624 00000000 00=
000000
dfd89fd8 dfd89fd8
<0>[  571.422058] 9fe0: 00000000 dfc31f68 c01855ac c01399a0 00000013 c0=
1399a0
feefff7b ffffd9ef
<4>[  571.430633] [<c034f6b4>] (usb_hcd_flush_endpoint+0x9c/0x160) from
[<c03518b0>] (usb_disable_endpoint+0x6c/0x84)
<4>[  571.441223] [<c03518b0>] (usb_disable_endpoint+0x6c/0x84) from
[<c03519e8>] (usb_disable_interface+0x30/0x4c)
<4>[  571.451629] [<c03519e8>] (usb_disable_interface+0x30/0x4c) from
[<c0354750>] (usb_unbind_interface+0x50/0x1a8)
<4>[  571.462158] [<c0354750>] (usb_unbind_interface+0x50/0x1a8) from
[<c0306708>] (__device_release_driver+0x84/0xd0)
<4>[  571.472839] [<c0306708>] (__device_release_driver+0x84/0xd0) from
[<c0306858>] (device_release_driver+0x1c/0x28)
<4>[  571.483520] [<c0306858>] (device_release_driver+0x1c/0x28) from
[<c0305d80>] (bus_remove_device+0xa4/0xb4)
<4>[  571.493621] [<c0305d80>] (bus_remove_device+0xa4/0xb4) from [<c03=
045a0>]
(device_del+0x110/0x16c)
<4>[  571.502960] [<c03045a0>] (device_del+0x110/0x16c) from [<c0351914=
>]
(usb_disable_device+0x4c/0xf0)
<4>[  571.512359] [<c0351914>] (usb_disable_device+0x4c/0xf0) from [<c0=
34c780>]
(usb_disconnect+0x90/0x134)
<4>[  571.522033] [<c034c780>] (usb_disconnect+0x90/0x134) from [<c034d=
630>]
(hub_thread+0x46c/0xf00)
<4>[  571.531158] [<c034d630>] (hub_thread+0x46c/0xf00) from [<c0185624=
>]
(kthread+0x78/0x80)
<4>[  571.539581] [<c0185624>] (kthread+0x78/0x80) from [<c01399a0>]
(kernel_thread_exit+0x0/0x8)
<0>[  571.548339] Code: e2833001 e5843004 eaffffe5 e1a0a005 (e5ba3018)
<1>[  571.554748] Unable to handle kernel paging request at virtual add=
ress 6b6b6b6b
<1>[  571.562316] pgd =3D c0104000
<1>[  571.565155] [6b6b6b6b] *pgd=3D00000000
<0>[  571.568908] Internal error: Oops: 5 [#2] PREEMPT
<0>[  571.573760] last sysfs file:
/sys/devices/platform/ehci-omap.0/usb1/1-2/1-2.4/idProduct
<4>[  571.582122] Modules linked in: blackberry cdc_acm sierra option u=
sb_wwan
hso omap3_isp tnx_mxt_ts cp210x pl2303 usbserial 88w8688_wlan tun omap_=
hsmmc
<4>[  571.596252] CPU: 0    Tainted: G      D W    (2.6.35.13-02836-g76=
4dcf5 #12)
<4>[  571.603546] PC is at snd_complete_urb+0x230/0x258
<4>[  571.608489] LR is at usb_hcd_giveback_urb+0xa0/0xec
<4>[  571.613616] pc : [<c0424068>]    lr : [<c034f494>]    psr: 000001=
93
<4>[  571.613616] sp : dfd89b38  ip : ced0b898  fp : ffffffb9
<4>[  571.625640] r10: 00000000  r9 : df4d3670  r8 : 00000000
<4>[  571.631134] r7 : df42a100  r6 : ced0b880  r5 : cf9202c8  r4 : 6b6=
b6b6b
<4>[  571.637969] r3 : 00000000  r2 : ced0b880  r1 : 00000000  r0 : ced=
0b880
<4>[  571.644805] Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM =
 Segment
kernel
<4>[  571.652587] Control: 10c5387d  Table: 9f7a4019  DAC: 00000015
<4>[  571.658599]
<4>[  571.658599] PC: 0xc0423fe8:
<4>[  571.663085] 3fe8  e794e00c e082200e e595e014 e2811010 e150000e e2=
800001
bafffff5 e5832054
<4>[  571.671691] 4008  e5952014 e5832068 ea000006 e3022994 e3a01000 e7=
942002
e583107c e3520004
<4>[  571.680297] 4028  23a02004 e5832080 e3a01020 e1a00006 ebfcb34f e2=
501000
08bd81f0 e59f0040
<4>[  571.688903] 4048  eb0359bb e2841da5 e5950010 e281101c e8bd41f0 ea=
f9992a
e373006c 0afffff8
<4>[  571.697509] 4068  e5943000 e5d3302c e3130001 0affff7a eafffff3 e1=
a00004
e1a01005 ebfffad9
<4>[  571.706115] 4088  eaffffe8 c060bb8c e92d4ff8 e1a06000 e2807014 e1=
a04000
e1a00007 e1a05001
<4>[  571.714721] 40a8  e1a0b003 e1a0a002 e59d9028 eb035dcc e5b63040 e3=
0209ac
e30219b0 ea00000d
<4>[  571.723327] 40c8  e2433da6 e2438038 e5133030 e153000a 1a000007 e5=
d53002
e798c000 e15c0003
<4>[  571.731933]
<4>[  571.731933] LR: 0xc034f414:
<4>[  571.736419] f414  11a05003 1a00000a e5913040 e3130001 0a000007 e5=
911058
e2753001 33a03000
<4>[  571.745025] f434  e5942054 e1510002 23a03000 e3530000 13e05078 e1=
a00006
e1a01004 ebffff97
<4>[  571.753631] f454  e596304c e3530000 0a000006 e59f3070 e1a00006 e1=
a01004
e1a02005 e5933000
<4>[  571.762237] f474  e1a0e00f e593f008 e1a00004 eb00076c e584503c e1=
a00004
e1a0e00f e594f078
<4>[  571.770843] f494  e2843008 e1932f9f e2422001 e1831f92 e3310000 1a=
fffffa
e594300c e3530000
<4>[  571.779449] f4b4  0a000004 e59f001c e3a01003 e3a02001 e3a03000 eb=
f86e03
e1a00004 e8bd4070
<4>[  571.788055] f4d4  ea0006f9 c0707b34 c068d194 e92d41f0 e591302c e1=
a05001
e1a04000 e1a08002
<4>[  571.796661] f4f4  e5933030 e3530000 1a00003f e10f6000 f10c0080 e1=
a0c00d
e3cc3d7f e3c3303f
<4>[  571.805267]
<4>[  571.805267] SP: 0xdfd89ab8:
<4>[  571.809753] 9ab8  c06b3534 dffe4d00 0000005d 0000005c c0300f4c 00=
000010
c06af6a8 c02fd7b0
<4>[  571.818359] 9ad8  c06bca8c ffffffff dfd89b24 ced0b880 df42a100 c0=
138a6c
ced0b880 00000000
<4>[  571.826965] 9af8  ced0b880 00000000 6b6b6b6b cf9202c8 ced0b880 df=
42a100
00000000 df4d3670
<4>[  571.835571] 9b18  00000000 ffffffb9 ced0b898 dfd89b38 c034f494 c0=
424068
00000193 ffffffff
<4>[  571.844177] 9b38  ced0b880 00000000 df42a100 df42a100 00000000 c0=
34f494
00000000 00000000
<4>[  571.852783] 9b58  ced0b880 c0360728 df42a1ec ffcea500 df42a100 cf=
9ee0c0
00000000 c0362600
<4>[  571.861389] 9b78  7268746b 00000acf 00000159 00000430 0000010c ff=
c02430
ffcea520 00000fff
<4>[  571.869995] 9b98  00000000 00000860 df42a224 df42a22c 352e3137 df=
42a1ec
df42a100 0000c00b
<4>[  571.878601]
<4>[  571.878601] IP: 0xced0b818:
<4>[  571.883087] b818  f47ffd50 fbedd122 0c5d7d8b e8a18eab c9edf871 fa=
42458e
9d74e35b 09f91102
<4>[  571.891693] b838  9f7b67b6 c028f924 be7374ea 76cfeff7 3dedf6eb b3=
bdafca
efeb3cb9 48b9b393
<4>[  571.900299] b858  71e79e75 ff27ed31 ef4af61b edffffc3 7dbafefa c4=
fff7fd
eefbeff7 e686ee2b
<4>[  571.908905] b878  635688c0 d84156c5 00000001 00000000 00000001 00=
000000
00000000 00000000
<4>[  571.917510] b898  ced0b898 ced0b898 ced0b8a0 ced0b8a0 00000000 d7=
691280
d76f3e40 00008880
<4>[  571.926116] b8b8  00000000 00000000 00000206 ffce9200 8ed0c200 00=
000000
00000000 000000c0
<4>[  571.934722] b8d8  00000000 00000000 00000000 00000867 00000001 00=
000008
00000002 cf9202c8
<4>[  571.943328] b8f8  c0423e38 00000000 000000c0 00000000 ffffffb9 5a=
5a5a5a
5a5a5a5a 5a5a5a5a
<4>[  571.951934]
<4>[  571.951934] R0: 0xced0b800:
<4>[  571.956420] b800  e2238576 a5e97707 5bcd6f77 875e9294 feeba4be d0=
cc4a11
f47ffd50 fbedd122
<4>[  571.965026] b820  0c5d7d8b e8a18eab c9edf871 fa42458e 9d74e35b 09=
f91102
9f7b67b6 c028f924
<4>[  571.973632] b840  be7374ea 76cfeff7 3dedf6eb b3bdafca efeb3cb9 48=
b9b393
71e79e75 ff27ed31
<4>[  571.982238] b860  ef4af61b edffffc3 7dbafefa c4fff7fd eefbeff7 e6=
86ee2b
635688c0 d84156c5
<4>[  571.990844] b880  00000001 00000000 00000001 00000000 00000000 00=
000000
ced0b898 ced0b898
<4>[  571.999450] b8a0  ced0b8a0 ced0b8a0 00000000 d7691280 d76f3e40 00=
008880
00000000 00000000
<4>[  572.008056] b8c0  00000206 ffce9200 8ed0c200 00000000 00000000 00=
0000c0
00000000 00000000
<4>[  572.016662] b8e0  00000000 00000867 00000001 00000008 00000002 cf=
9202c8
c0423e38 00000000
<4>[  572.025268]
<4>[  572.025268] R2: 0xced0b800:
<4>[  572.029754] b800  e2238576 a5e97707 5bcd6f77 875e9294 feeba4be d0=
cc4a11
f47ffd50 fbedd122
<4>[  572.038360] b820  0c5d7d8b e8a18eab c9edf871 fa42458e 9d74e35b 09=
f91102
9f7b67b6 c028f924
<4>[  572.046966] b840  be7374ea 76cfeff7 3dedf6eb b3bdafca efeb3cb9 48=
b9b393
71e79e75 ff27ed31
<4>[  572.055572] b860  ef4af61b edffffc3 7dbafefa c4fff7fd eefbeff7 e6=
86ee2b
635688c0 d84156c5
<4>[  572.064178] b880  00000001 00000000 00000001 00000000 00000000 00=
000000
ced0b898 ced0b898
<4>[  572.072784] b8a0  ced0b8a0 ced0b8a0 00000000 d7691280 d76f3e40 00=
008880
00000000 00000000
<4>[  572.081390] b8c0  00000206 ffce9200 8ed0c200 00000000 00000000 00=
0000c0
00000000 00000000
<4>[  572.089996] b8e0  00000000 00000867 00000001 00000008 00000002 cf=
9202c8
c0423e38 00000000
<4>[  572.098602]
<4>[  572.098602] R5: 0xcf920248:
<4>[  572.103088] 0248  6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b=
6b6b6b
6b6b6b6b 6b6b6b6b
<4>[  572.111694] 0268  6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b=
6b6b6b
6b6b6b6b 6b6b6b6b
<4>[  572.120300] 0288  6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b=
6b6b6b
6b6b6b6b 6b6b6b6b
<4>[  572.128906] 02a8  6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b=
6b6b6b
6b6b6b6b 6b6b6b6b
<4>[  572.137512] 02c8  6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b=
6b6b6b
6b6b6b6b 6b6b6b6b
<4>[  572.146118] 02e8  6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b=
6b6b6b
6b6b6b6b 6b6b6b6b
<4>[  572.154724] 0308  6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b=
6b6b6b
6b6b6b6b 6b6b6b6b
<4>[  572.163330] 0328  6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b=
6b6b6b
6b6b6b6b 6b6b6b6b
<4>[  572.171936]
<4>[  572.171936] R6: 0xced0b800:
<4>[  572.176422] b800  e2238576 a5e97707 5bcd6f77 875e9294 feeba4be d0=
cc4a11
f47ffd50 fbedd122
<4>[  572.185028] b820  0c5d7d8b e8a18eab c9edf871 fa42458e 9d74e35b 09=
f91102
9f7b67b6 c028f924
<4>[  572.193634] b840  be7374ea 76cfeff7 3dedf6eb b3bdafca efeb3cb9 48=
b9b393
71e79e75 ff27ed31
<4>[  572.202239] b860  ef4af61b edffffc3 7dbafefa c4fff7fd eefbeff7 e6=
86ee2b
635688c0 d84156c5
<4>[  572.210845] b880  00000001 00000000 00000001 00000000 00000000 00=
000000
ced0b898 ced0b898
<4>[  572.219451] b8a0  ced0b8a0 ced0b8a0 00000000 d7691280 d76f3e40 00=
008880
00000000 00000000
<4>[  572.228057] b8c0  00000206 ffce9200 8ed0c200 00000000 00000000 00=
0000c0
00000000 00000000
<4>[  572.236663] b8e0  00000000 00000867 00000001 00000008 00000002 cf=
9202c8
c0423e38 00000000
<4>[  572.245269]
<4>[  572.245269] R7: 0xdf42a080:
<4>[  572.249755] a080  dfffd040 df510000 000000c0 df42a0c0 00000006 ff=
ffffff
00000000 fffffffe
<4>[  572.258361] a0a0  fffffffe fffffffe fffffffe fffffffe fffffffe 00=
000000
00000000 00000000
<4>[  572.266967] a0c0  00000000 00000000 00000000 00000000 00000000 00=
000000
00000000 00000000
<4>[  572.275573] a0e0  00000000 00000000 00000000 00000000 00000000 00=
000000
635688c0 d84156c5
<4>[  572.284179] a100  c066f5d8 00000001 dfcf1d00 00000001 ffffffff 00=
00000f
000059de 00000000
<4>[  572.292785] a120  00000000 00000000 df522080 00000000 c068d19c df=
c73030
00000005 00000005
<4>[  572.301391] a140  00000002 df806aa8 00000000 00000000 0000000c c0=
5f06a6
69636865 6463685f
<4>[  572.309997] a160  6273753a 00000031 00000000 00000000 00000000 00=
200200
ffff8c07 c06efd80
<4>[  572.318603]
<4>[  572.318603] R9: 0xdf4d35f0:
<4>[  572.323089] 35f0  00000000 00000000 d685a300 00000000 00000000 00=
000000
d685a300 00000000
<4>[  572.331695] 3610  00000000 00000000 d685a300 00000000 00000000 00=
000000
d685a300 00000000
<4>[  572.340301] 3630  00000000 00000000 d685a300 00000000 00000000 df=
c8c6c0
defc6d00 dedc8dc0
<4>[  572.348907] 3650  d6a42540 00000000 d685a300 00000000 00000000 00=
000000
d685a300 00000000
<4>[  572.357513] 3670  00000000 ffcea000 d685a300 00000000 00000000 00=
000000
d685a300 00000000
<4>[  572.366119] 3690  00000000 00000000 d685a300 00000000 00000000 00=
000000
d685a300 00000000
<4>[  572.374725] 36b0  00000000 00000000 d685a300 00000000 00000000 00=
000000
d685a300 00000000
<4>[  572.383331] 36d0  00000000 00000000 d685a300 00000000 00000000 00=
000000
d685a300 00000000
<0>[  572.391937] Process khubd (pid: 269, stack limit =3D 0xdfd882e8)
<0>[  572.398040] Stack: (0xdfd89b38 to 0xdfd8a000)
<0>[  572.402618] 9b20:
ced0b880 00000000
<0>[  572.411193] 9b40: df42a100 df42a100 00000000 c034f494 00000000 00=
000000
ced0b880 c0360728
<0>[  572.419769] 9b60: df42a1ec ffcea500 df42a100 cf9ee0c0 00000000 c0=
362600
7268746b 00000acf
<0>[  572.428375] 9b80: 00000159 00000430 0000010c ffc02430 ffcea520 00=
000fff
00000000 00000860
<0>[  572.436950] 9ba0: df42a224 df42a22c 352e3137 df42a1ec df42a100 00=
00c00b
00000000 00010035
<0>[  572.445526] 9bc0: dfd88000 6b6b6b53 d7691280 c0364b88 df42a100 df=
42a100
00010003 df42a100
<0>[  572.454101] 9be0: 40000193 00000000 0000004d 00000002 dfd88000 6b=
6b6b53
d7691280 c034ebd0
<0>[  572.462707] 9c00: df508c40 00000000 00000000 c01a8e38 c0674ec8 00=
00004d
df508c40 00000003
<0>[  572.471282] 9c20: 00000002 c01ab034 0000004d 00000000 dfd68c40 c0=
13806c
ffffffff fa200000
<0>[  572.479858] 9c40: dfd68c40 c0138ac8 00000000 c06af260 00000080 00=
000080
dfd89df0 dfd882e8
<0>[  572.488433] 9c60: dfd68c40 00000000 00000005 00000005 6b6b6b53 d7=
691280
00000000 dfd89c90
<0>[  572.497009] 9c80: c013c7fc c013c800 60000113 ffffffff dfd882e8 00=
00000b
6b6b6b6b dfd89df0
<0>[  572.505615] 9ca0: 00000000 00000005 00000000 c0141754 dfd89df0 c0=
65e988
6b6b6b6b dfd68c40
<0>[  572.514190] 9cc0: 00000000 c0141a08 dfd89d0c 00000000 0000054a d6=
a790f4
d6a79884 c0138314
<0>[  572.522766] 9ce0: d6a790f4 d6a79884 0000ffff 00000000 db3c9bf4 00=
0000c1
dfd68c40 c0670808
<0>[  572.531341] 9d00: 002d4f8a d1ab29ff dfd89d4c c0169994 0000004d d1=
66b63b
dfd68c40 c0670808
<0>[  572.539916] 9d20: dfd46cb0 00000001 c0670808 00000005 c065e988 6b=
6b6b6b
dfd89df0 df42a100
<0>[  572.548522] 9d40: 20000193 6b6b6b53 d7691280 c0138314 dfd68c40 c0=
6707d8
00000003 dfd46cb0
<0>[  572.557098] 9d60: dfd68c70 dfd68c40 dfd89d8c c0169ca8 dfd46c80 c0=
6707d8
00000001 40000093
<0>[  572.565673] 9d80: d751d000 dc3ac000 dfc0bd80 dfc10e40 0000000f c0=
1e2060
dfd89db4 dfc11ad0
<0>[  572.574249] 9da0: 00000010 dfc0be0c dfd89e0c dfc0bd80 d751f000 d7=
22f000
dfc00080 dfc02e40
<0>[  572.582824] 9dc0: 0000000f c01e2060 ceca0258 dfc05c10 00000010 df=
c0010c
ceca0000 ffffffff
<0>[  572.591430] 9de0: dfd89e24 d76f3e40 d76f3e50 c0138a6c d7691280 d7=
6f3e40
6b6b6b6b 6b6b6b6b
<0>[  572.600006] 9e00: dfd88000 6b6b6b53 d76f3e40 d76f3e50 df42a100 00=
000100
6b6b6b53 d7691280
<0>[  572.608581] 9e20: 00000002 dfd89e38 c03518b0 c034f6b4 20000093 ff=
ffffff
d7691280 d76f3e40
<0>[  572.617156] 9e40: 00000000 00000000 d7691280 00000100 c069ac48 c0=
3518b0
0000002c 00000001
<0>[  572.625732] 9e60: d76f30e4 c03519e8 d57c9aa0 d57c9a80 d7691280 00=
000000
c069ac18 c0354750
<0>[  572.634338] 9e80: d57c9aa0 c069ac48 c068d208 00000002 df5902bc 00=
000100
0000001f c0306708
<0>[  572.642913] 9ea0: d57c9ad4 d57c9aa0 c068d208 c0306858 d57c9aa0 d7=
6912e8
c068d208 c0305d80
<0>[  572.651489] 9ec0: d57c9aa0 d76912e8 d57c9a80 c03045a0 d7691280 00=
000000
d57c9a80 c0351914
<0>[  572.660064] 9ee0: d7691280 d769131c d76912e8 d76912fc df5902bc c0=
34c780
dfc91700 00000001
<0>[  572.668670] 9f00: 00000004 dfd88000 df590080 00000100 c068d044 c0=
34d630
dfc1db30 dfc1db00
<0>[  572.677246] 9f20: dfc1db30 dfc1db00 00000001 dfd68c70 df42a118 da=
ff45a0
00000000 daff45a0
<0>[  572.685821] 9f40: df42a100 df590080 00000004 df60d280 df59008c df=
c91703
dfc91738 daff4580
<0>[  572.694396] 9f60: 00000000 00000003 dfc91740 dfc91790 dfc91708 df=
59011c
00000009 dfc9173c
<0>[  572.702972] 9f80: dfc91734 dfd89f94 00000000 dfd68c40 c0185954 df=
d89f94
dfd89f94 00000101
<0>[  572.711547] 9fa0: 01000001 c018560c 00000000 dfc31f68 dfd89fd4 c0=
34d1c4
00000000 00000000
<0>[  572.720123] 9fc0: 00000000 00000000 00000000 c0185624 00000000 00=
000000
dfd89fd8 dfd89fd8
<0>[  572.728729] 9fe0: 00000000 dfc31f68 c01855ac c01399a0 00000013 c0=
1399a0
feefff7b ffffd9ef
<4>[  572.737304] [<c0424068>] (snd_complete_urb+0x230/0x258) from [<c0=
34f494>]
(usb_hcd_giveback_urb+0xa0/0xec)
<4>[  572.747436] [<c034f494>] (usb_hcd_giveback_urb+0xa0/0xec) from
[<c0360728>] (ehci_urb_done+0x100/0x120)
<4>[  572.757293] [<c0360728>] (ehci_urb_done+0x100/0x120) from [<c0362=
600>]
(ehci_work+0x550/0x9b4)
<4>[  572.766326] [<c0362600>] (ehci_work+0x550/0x9b4) from [<c0364b88>=
]
(ehci_irq+0x218/0x260)
<4>[  572.774932] [<c0364b88>] (ehci_irq+0x218/0x260) from [<c034ebd0>]
(usb_hcd_irq+0x38/0x90)
<4>[  572.783508] [<c034ebd0>] (usb_hcd_irq+0x38/0x90) from [<c01a8e38>=
]
(handle_IRQ_event+0x24/0xe4)
<4>[  572.792663] [<c01a8e38>] (handle_IRQ_event+0x24/0xe4) from [<c01a=
b034>]
(handle_level_irq+0xdc/0x188)
<4>[  572.802337] [<c01ab034>] (handle_level_irq+0xdc/0x188) from [<c01=
3806c>]
(asm_do_IRQ+0x6c/0x8c)
<4>[  572.811462] [<c013806c>] (asm_do_IRQ+0x6c/0x8c) from [<c0138ac8>]
(__irq_svc+0x48/0xa8)
<4>[  572.819854] Exception stack(0xdfd89c48 to 0xdfd89c90)
<4>[  572.825164] 9c40:                   00000000 c06af260 00000080 00=
000080
dfd89df0 dfd882e8
<4>[  572.833740] 9c60: dfd68c40 00000000 00000005 00000005 6b6b6b53 d7=
691280
00000000 dfd89c90
<4>[  572.842315] 9c80: c013c7fc c013c800 60000113 ffffffff
<4>[  572.847625] [<c0138ac8>] (__irq_svc+0x48/0xa8) from [<c013c800>]
(die+0x140/0x1e4)
<4>[  572.855560] [<c013c800>] (die+0x140/0x1e4) from [<c0141754>]
(__do_kernel_fault+0x64/0x84)
<4>[  572.864227] [<c0141754>] (__do_kernel_fault+0x64/0x84) from [<c01=
41a08>]
(do_page_fault+0x294/0x2b4)
<4>[  572.873809] [<c0141a08>] (do_page_fault+0x294/0x2b4) from [<c0138=
314>]
(do_DataAbort+0x34/0x94)
<4>[  572.882965] [<c0138314>] (do_DataAbort+0x34/0x94) from [<c0138a6c=
>]
(__dabt_svc+0x4c/0x60)
<4>[  572.891601] Exception stack(0xdfd89df0 to 0xdfd89e38)
<4>[  572.896911] 9de0:                                     d7691280 d7=
6f3e40
6b6b6b6b 6b6b6b6b
<4>[  572.905487] 9e00: dfd88000 6b6b6b53 d76f3e40 d76f3e50 df42a100 00=
000100
6b6b6b53 d7691280
<4>[  572.914062] 9e20: 00000002 dfd89e38 c03518b0 c034f6b4 20000093 ff=
ffffff
<4>[  572.921020] [<c0138a6c>] (__dabt_svc+0x4c/0x60) from [<c034f6b4>]
(usb_hcd_flush_endpoint+0x9c/0x160)
<4>[  572.930694] [<c034f6b4>] (usb_hcd_flush_endpoint+0x9c/0x160) from
[<c03518b0>] (usb_disable_endpoint+0x6c/0x84)
<4>[  572.941284] [<c03518b0>] (usb_disable_endpoint+0x6c/0x84) from
[<c03519e8>] (usb_disable_interface+0x30/0x4c)
<4>[  572.951690] [<c03519e8>] (usb_disable_interface+0x30/0x4c) from
[<c0354750>] (usb_unbind_interface+0x50/0x1a8)
<4>[  572.962188] [<c0354750>] (usb_unbind_interface+0x50/0x1a8) from
[<c0306708>] (__device_release_driver+0x84/0xd0)
<4>[  572.972869] [<c0306708>] (__device_release_driver+0x84/0xd0) from
[<c0306858>] (device_release_driver+0x1c/0x28)
<4>[  572.983551] [<c0306858>] (device_release_driver+0x1c/0x28) from
[<c0305d80>] (bus_remove_device+0xa4/0xb4)
<4>[  572.993682] [<c0305d80>] (bus_remove_device+0xa4/0xb4) from [<c03=
045a0>]
(device_del+0x110/0x16c)
<4>[  573.002990] [<c03045a0>] (device_del+0x110/0x16c) from [<c0351914=
>]
(usb_disable_device+0x4c/0xf0)
<4>[  573.012390] [<c0351914>] (usb_disable_device+0x4c/0xf0) from [<c0=
34c780>]
(usb_disconnect+0x90/0x134)
<4>[  573.022064] [<c034c780>] (usb_disconnect+0x90/0x134) from [<c034d=
630>]
(hub_thread+0x46c/0xf00)
<4>[  573.031219] [<c034d630>] (hub_thread+0x46c/0xf00) from [<c0185624=
>]
(kthread+0x78/0x80)
<4>[  573.039611] [<c0185624>] (kthread+0x78/0x80) from [<c01399a0>]
(kernel_thread_exit+0x0/0x8)
<0>[  573.048370] Code: e8bd41f0 eaf9992a e373006c 0afffff8 (e5943000)
<4>[  573.055084] ---[ end trace 069f4a4f8aedac2b ]---
<0>[  573.060180] Kernel panic - not syncing: Fatal exception in interr=
upt
<4>[  573.066864] [<c013e608>] (unwind_backtrace+0x0/0xf0) from [<c04fa=
6c0>]
(panic+0x6c/0xe8)
<4>[  573.075408] [<c04fa6c0>] (panic+0x6c/0xe8) from [<c013c868>] (die=
+0x1a8/0x1e4)
<4>[  573.083007] [<c013c868>] (die+0x1a8/0x1e4) from [<c0141754>]
(__do_kernel_fault+0x64/0x84)
<4>[  573.091674] [<c0141754>] (__do_kernel_fault+0x64/0x84) from [<c01=
41a08>]
(do_page_fault+0x294/0x2b4)
<4>[  573.101287] [<c0141a08>] (do_page_fault+0x294/0x2b4) from [<c0138=
314>]
(do_DataAbort+0x34/0x94)
<4>[  573.110443] [<c0138314>] (do_DataAbort+0x34/0x94) from [<c0138a6c=
>]
(__dabt_svc+0x4c/0x60)
<4>[  573.119110] Exception stack(0xdfd89af0 to 0xdfd89b38)
<4>[  573.124420] 9ae0:                                     ced0b880 00=
000000
ced0b880 00000000
<4>[  573.133026] 9b00: 6b6b6b6b cf9202c8 ced0b880 df42a100 00000000 df=
4d3670
00000000 ffffffb9
<4>[  573.141601] 9b20: ced0b898 dfd89b38 c034f494 c0424068 00000193 ff=
ffffff
<4>[  573.148559] [<c0138a6c>] (__dabt_svc+0x4c/0x60) from [<c0424068>]
(snd_complete_urb+0x230/0x258)
<4>[  573.157806] [<c0424068>] (snd_complete_urb+0x230/0x258) from [<c0=
34f494>]
(usb_hcd_giveback_urb+0xa0/0xec)
<4>[  573.167938] [<c034f494>] (usb_hcd_giveback_urb+0xa0/0xec) from
[<c0360728>] (ehci_urb_done+0x100/0x120)
<4>[  573.177825] [<c0360728>] (ehci_urb_done+0x100/0x120) from [<c0362=
600>]
(ehci_work+0x550/0x9b4)
<4>[  573.186889] [<c0362600>] (ehci_work+0x550/0x9b4) from [<c0364b88>=
]
(ehci_irq+0x218/0x260)
<4>[  573.195465] [<c0364b88>] (ehci_irq+0x218/0x260) from [<c034ebd0>]
(usb_hcd_irq+0x38/0x90)
<4>[  573.204071] [<c034ebd0>] (usb_hcd_irq+0x38/0x90) from [<c01a8e38>=
]
(handle_IRQ_event+0x24/0xe4)
<4>[  573.213226] [<c01a8e38>] (handle_IRQ_event+0x24/0xe4) from [<c01a=
b034>]
(handle_level_irq+0xdc/0x188)
<4>[  573.222930] [<c01ab034>] (handle_level_irq+0xdc/0x188) from [<c01=
3806c>]
(asm_do_IRQ+0x6c/0x8c)
<4>[  573.232086] [<c013806c>] (asm_do_IRQ+0x6c/0x8c) from [<c0138ac8>]
(__irq_svc+0x48/0xa8)
<4>[  573.240478] Exception stack(0xdfd89c48 to 0xdfd89c90)
<4>[  573.245788] 9c40:                   00000000 c06af260 00000080 00=
000080
dfd89df0 dfd882e8
<4>[  573.254364] 9c60: dfd68c40 00000000 00000005 00000005 6b6b6b53 d7=
691280
00000000 dfd89c90
<4>[  573.262969] 9c80: c013c7fc c013c800 60000113 ffffffff
<4>[  573.268280] [<c0138ac8>] (__irq_svc+0x48/0xa8) from [<c013c800>]
(die+0x140/0x1e4)
<4>[  573.276245] [<c013c800>] (die+0x140/0x1e4) from [<c0141754>]
(__do_kernel_fault+0x64/0x84)
<4>[  573.284912] [<c0141754>] (__do_kernel_fault+0x64/0x84) from [<c01=
41a08>]
(do_page_fault+0x294/0x2b4)
<4>[  573.294525] [<c0141a08>] (do_page_fault+0x294/0x2b4) from [<c0138=
314>]
(do_DataAbort+0x34/0x94)
<4>[  573.303680] [<c0138314>] (do_DataAbort+0x34/0x94) from [<c0138a6c=
>]
(__dabt_svc+0x4c/0x60)
<4>[  573.312377] Exception stack(0xdfd89df0 to 0xdfd89e38)
<4>[  573.317657] 9de0:                                     d7691280 d7=
6f3e40
6b6b6b6b 6b6b6b6b
<4>[  573.326263] 9e00: dfd88000 6b6b6b53 d76f3e40 d76f3e50 df42a100 00=
000100
6b6b6b53 d7691280
<4>[  573.334869] 9e20: 00000002 dfd89e38 c03518b0 c034f6b4 20000093 ff=
ffffff
<4>[  573.341827] [<c0138a6c>] (__dabt_svc+0x4c/0x60) from [<c034f6b4>]
(usb_hcd_flush_endpoint+0x9c/0x160)
<4>[  573.351531] [<c034f6b4>] (usb_hcd_flush_endpoint+0x9c/0x160) from
[<c03518b0>] (usb_disable_endpoint+0x6c/0x84)
<4>[  573.362121] [<c03518b0>] (usb_disable_endpoint+0x6c/0x84) from
[<c03519e8>] (usb_disable_interface+0x30/0x4c)
<4>[  573.372558] [<c03519e8>] (usb_disable_interface+0x30/0x4c) from
[<c0354750>] (usb_unbind_interface+0x50/0x1a8)
<4>[  573.383056] [<c0354750>] (usb_unbind_interface+0x50/0x1a8) from
[<c0306708>] (__device_release_driver+0x84/0xd0)
<4>[  573.393768] [<c0306708>] (__device_release_driver+0x84/0xd0) from
[<c0306858>] (device_release_driver+0x1c/0x28)
<4>[  573.404449] [<c0306858>] (device_release_driver+0x1c/0x28) from
[<c0305d80>] (bus_remove_device+0xa4/0xb4)
<4>[  573.414611] [<c0305d80>] (bus_remove_device+0xa4/0xb4) from [<c03=
045a0>]
(device_del+0x110/0x16c)
<4>[  573.423919] [<c03045a0>] (device_del+0x110/0x16c) from [<c0351914=
>]
(usb_disable_device+0x4c/0xf0)
<4>[  573.433349] [<c0351914>] (usb_disable_device+0x4c/0xf0) from [<c0=
34c780>]
(usb_disconnect+0x90/0x134)
<4>[  573.443054] [<c034c780>] (usb_disconnect+0x90/0x134) from [<c034d=
630>]
(hub_thread+0x46c/0xf00)
<4>[  573.452178] [<c034d630>] (hub_thread+0x46c/0xf00) from [<c0185624=
>]
(kthread+0x78/0x80)
<4>[  573.460601] [<c0185624>] (kthread+0x78/0x80) from [<c01399a0>]
(kernel_thread_exit+0x0/0x8)

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
