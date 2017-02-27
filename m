From: Linus Walleij <linus.walleij@linaro.org>
Subject: dmesg complains with CONFIG_SND_VERBOSE_PROCFS
Date: Mon, 27 Feb 2017 14:49:00 +0100
Message-ID: <CACRpkdYNFEN2DEjwa0fyZ7JK3_5HJODKTGJ_EN1W=fs382HaUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f169.google.com (mail-io0-f169.google.com
 [209.85.223.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DFC0266E02
 for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2017 14:49:02 +0100 (CET)
Received: by mail-io0-f169.google.com with SMTP id j18so31470415ioe.2
 for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2017 05:49:02 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

If CONFIG_SND_VERBOSE_PROCFS is enabled I got a bunch of
nasty messages from duplicate entries when registering the DAIs
like this:

[    3.144805] entry->name == "info"
[    3.148132] entry->name == "info"
[    3.151519] entry->name == "hw_params"
[    3.155273] entry->name == "sw_params"
[    3.159027] entry->name == "status"
[    3.164001] entry->name == "prealloc"
[    3.167663] entry->name == "prealloc_max"
[    3.173034] entry->name == "prealloc"
[    3.176696] ------------[ cut here ]------------
[    3.181335] WARNING: CPU: 0 PID: 95 at ../fs/proc/generic.c:346
proc_register+0xf0/0x110
[    3.189422] proc_dir_entry 'sub0/prealloc' already registered
(...)
[    3.414642] entry->name == "prealloc_max"
[    3.418670] ------------[ cut here ]------------
[    3.423309] WARNING: CPU: 0 PID: 95 at ../fs/proc/generic.c:346
proc_register+0xf0/0x110
[    3.431396] proc_dir_entry 'sub0/prealloc_max' already registered
(...)
[    3.658020] snd-soc-mop500 soc:sound: ab8500-codec-dai.0 <->
80124000.msp mapping ok
[    3.665893] entry->name == "info"
[    3.669219] entry->name == "info"
[    3.672546] entry->name == "hw_params"
[    3.676300] entry->name == "sw_params"
[    3.680053] entry->name == "status"
[    3.684906] entry->name == "prealloc"
[    3.688568] entry->name == "prealloc_max"
[    3.693939] entry->name == "prealloc"
[    3.697601] ------------[ cut here ]------------
[    3.702239] WARNING: CPU: 0 PID: 95 at ../fs/proc/generic.c:346
proc_register+0xf0/0x110
[    3.710296] proc_dir_entry 'sub0/prealloc' already registered
(...)
[    3.936645] entry->name == "prealloc_max"
[    3.940673] ------------[ cut here ]------------
[    3.945281] WARNING: CPU: 0 PID: 95 at ../fs/proc/generic.c:346
proc_register+0xf0/0x110
[    3.953369] proc_dir_entry 'sub0/prealloc_max' already registered
[    4.180023] snd-soc-mop500 soc:sound: ab8500-codec-dai.1 <->
80125000.msp mapping ok

What I can't seem to figure out is whether the DAI in my card
(sound/soc/ux500/mop500.c) is misconfigured some way, or
if CONFIG_SND_VERBOSE_PROCFS is not handling this
the right way?

If I take out the config option everything seems to work smoothly
but I guess it should be possible to have this on?

Any hints?

Yours,
Linus Walleij
