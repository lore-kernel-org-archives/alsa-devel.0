From: Timur Tabi <b04825@freescale.com>
Subject: Re: [PATCH 2/2] ASoC: DAPM - Make sure DAPM widget IO
 ops hold the component mutex.
Date: Fri, 9 Mar 2012 13:11:26 -0600
Message-ID: <4F5A55DE.8020609@freescale.com>
References: <1331057779-4630-1-git-send-email-lrg@ti.com>
	<1331057779-4630-2-git-send-email-lrg@ti.com>
	<CAOZdJXUy-hCOEk6beBrjv16iknsMWTHc+AxSyw-L8-hLEXQYSw@mail.gmail.com>
	<1331316853.3789.4.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 89206103B3C
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 20:11:43 +0100 (CET)
In-Reply-To: <1331316853.3789.4.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Liam Girdwood wrote:
> Can you switch on the mutex debugging kernel config here.  I've just had
> a quick look and the WM8776 and its not holding the codec mutex or
> calling snd_soc_update_bits_locked() so it must deadlock via another
> path.

Enabling the debug options didn't reveal anything, unfortunately.

When I start playback, here's the code flow:


dapm_seq_run_coalesced:1138
soc_widget_update_bits_locked:244
soc_widget_lock:211 codec=wm8776.1-001a platform=

The numbers are line numbers of the printk statements I added.

What happens is that the thread hangs on:

	mutex_lock(&w->codec->mutex);

in soc_widget_lock().

After a couple minutes, I see this:

INFO: task speaker-test:2624 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
speaker-test    D 0fced718     0  2624   2623 0x00000000
Call Trace:
[e6f27ab0] [c0038d5c] console_unlock+0x22c/0x29c (unreliable)
[e6f27b70] [c0008520] __switch_to+0x70/0x144
[e6f27b90] [c04ab830] __schedule+0x224/0x4ec
[e6f27be0] [c04aa6a8] mutex_lock_nested+0x188/0x394
[e6f27c40] [c0395c40] soc_widget_update_bits_locked+0x2b0/0x2c4
[e6f27c80] [c0397734] dapm_seq_run_coalesced.clone.24+0x1b8/0x1c4
[e6f27cc0] [c03977e4] dapm_seq_run.clone.25+0xa4/0x3c0
[e6f27d10] [c0397eb4] dapm_power_widgets+0x3b4/0x67c
[e6f27d70] [c0399480] snd_soc_dapm_stream_event+0x74/0xdc
[e6f27d90] [c039abb0] soc_pcm_prepare+0x108/0x1dc
[e6f27dc0] [c0378248] snd_pcm_do_prepare+0x24/0x5c
[e6f27dd0] [c0377e3c] snd_pcm_action_single+0x4c/0xb4
[e6f27df0] [c0379218] snd_pcm_action_nonatomic+0x7c/0xa0
[e6f27e10] [c037b678] snd_pcm_common_ioctl1+0x8f8/0x10d8
[e6f27e60] [c037c568] snd_pcm_playback_ioctl1+0x40/0x6cc
[e6f27ea0] [c00f0e20] do_vfs_ioctl+0xa4/0x7d0
[e6f27f10] [c00f158c] sys_ioctl+0x40/0x88
[e6f27f40] [c000f6e4] ret_from_syscall+0x0/0x3c
--- Exception: c01 at 0xfced718
    LR = 0xfd76a24
INFO: lockdep is turned off.




-- 
Timur Tabi
Linux kernel developer at Freescale
