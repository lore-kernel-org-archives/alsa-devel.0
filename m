From: Andrey Gusakov <dron0gus@gmail.com>
Subject: Problem with AC97 and WM9714 on S3C6410
Date: Sat, 29 Sep 2012 21:19:15 +0400
Message-ID: <CAA11ShCy9SWmcyrOJB1ZD0_JpcK1XBggOWAuBdtxX-a7-3TOrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 by alsa0.perex.cz (Postfix) with ESMTP id CAB4C2615ED
 for <alsa-devel@alsa-project.org>; Sat, 29 Sep 2012 19:19:16 +0200 (CEST)
Received: by pbbrp16 with SMTP id rp16so6377918pbb.38
 for <alsa-devel@alsa-project.org>; Sat, 29 Sep 2012 10:19:15 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi.

I'm working with mini6410 devkit/demoboard.
Itry to move forward from old kernel to last samsung kernel from git.
I run into interesting problem with ALSA and WM9714 codec.
On kernel boot I see some activity on AC97 bus, but then BCLK and SYNC stops.
As i figure out clock stops after write to WM9714 register 0x00. As I
understand it's a reset comand. But it brokes all communication. No
blayback or control regiter read/write posible after. And there is no
reset or warm_reset commands after it.
If i filter out all writes to register 0x00 in samsung AC97 driver,
everything seems to work corect. But it's a dirty fix.
I use dump_stack() to collect some aditional info. That what i got:
Try to reset codec! (write at 0x00)
[<c0014978>] (unwind_backtrace+0x0/0xf4) from [<c035caf0>]
(ac97_write+0x4c/0x64)
[<c035caf0>] (ac97_write+0x4c/0x64) from [<c034d00c>] (snd_soc_write+0xc/0x10)
[<c034d00c>] (snd_soc_write+0xc/0x10) from [<c035355c>]
(soc_widget_update_bits_locked+0x114/0x190)
[<c035355c>] (soc_widget_update_bits_locked+0x114/0x190) from
[<c0353830>] (dapm_seq_run_coalesced+0x114/0x16c)
[<c0353830>] (dapm_seq_run_coalesced+0x114/0x16c) from [<c0353b88>]
(dapm_seq_run+0x300/0x4a0)
[<c0353b88>] (dapm_seq_run+0x300/0x4a0) from [<c0354be0>]
(dapm_power_widgets+0x404/0x600)
[<c0354be0>] (dapm_power_widgets+0x404/0x600) from [<c03577ec>]
(snd_soc_dapm_new_widgets+0x2ac/0x6ac)
[<c03577ec>] (snd_soc_dapm_new_widgets+0x2ac/0x6ac) from [<c034f940>]
(soc_post_component_init+0x44/0x27c)
[<c034f940>] (soc_post_component_init+0x44/0x27c) from [<c03513f4>]
(snd_soc_register_card+0xc44/0x1a00)
[<c03513f4>] (snd_soc_register_card+0xc44/0x1a00) from [<c03521e8>]
(soc_probe+0x38/0x64)
[<c03521e8>] (soc_probe+0x38/0x64) from [<c025f9d8>]
(platform_drv_probe+0x18/0x1c)
[<c025f9d8>] (platform_drv_probe+0x18/0x1c) from [<c025e518>]
(driver_probe_device+0x78/0x1fc)
[<c025e518>] (driver_probe_device+0x78/0x1fc) from [<c025cd9c>]
(bus_for_each_drv+0x60/0x8c)
[<c025cd9c>] (bus_for_each_drv+0x60/0x8c) from [<c025e810>]
(device_attach+0x80/0x98)
[<c025e810>] (device_attach+0x80/0x98) from [<c025d8bc>]
(bus_probe_device+0x84/0xac)
[<c025d8bc>] (bus_probe_device+0x84/0xac) from [<c025c6ec>]
(device_add+0x5b0/0x67c)
[<c025c6ec>] (device_add+0x5b0/0x67c) from [<c025ffa8>]
(platform_device_add+0xf4/0x20c)
[<c025ffa8>] (platform_device_add+0xf4/0x20c) from [<c060b3a4>]
(mini6410_init+0x60/0xa0)
[<c060b3a4>] (mini6410_init+0x60/0xa0) from [<c00085d0>]
(do_one_initcall+0x34/0x178)
[<c00085d0>] (do_one_initcall+0x34/0x178) from [<c05f3310>]
(kernel_init+0xe0/0x1ac)
[<c05f3310>] (kernel_init+0xe0/0x1ac) from [<c000f848>]
(kernel_thread_exit+0x0/0x8)

I'm begginer in kernel programing and have no enouth experience to
figure what's happening.
Can any one help with this problem?

Thank you.
