From: Giovanni Maruzzelli <gmaruzz.lists@gmail.com>
Subject: Re: snd_dummy on Centos - Redhat
Date: Thu, 3 Sep 2009 17:03:16 +0200
Message-ID: <7c5010d60909030803h1c354c79ob774683d764ea062@mail.gmail.com>
References: <7c5010d60909020912k1b9b64bdsab2363c4762e8c5c@mail.gmail.com>
	<4A9E9CB7.8040809@ladisch.de>
	<7c5010d60909020933n47381069uacadd656aa98e8e8@mail.gmail.com>
	<4A9FAD82.3050207@ladisch.de> <s5heiqoqfh4.wl%tiwai@suse.de>
	<7c5010d60909030723l44055b5au84a487d78ef6252f@mail.gmail.com>
	<s5hbplsqeye.wl%tiwai@suse.de>
	<7c5010d60909030747n55b6f48r2322aabf47f17171@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 83F7E24153
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Sep 2009 17:08:30 +0200 (CEST)
Received: by bwz25 with SMTP id 25so1624153bwz.32
	for <alsa-devel@alsa-project.org>; Thu, 03 Sep 2009 08:08:30 -0700 (PDT)
In-Reply-To: <7c5010d60909030747n55b6f48r2322aabf47f17171@mail.gmail.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 3, 2009 at 4:47 PM, Giovanni
Maruzzelli<gmaruzz.lists@gmail.com> wrote:
> On Thu, Sep 3, 2009 at 4:29 PM, Takashi Iwai<tiwai@suse.de> wrote:
>> Or, just copy alsa-kernel/drivers/dummy.c to your tree.
>> There is no other changes except for documentation.
> I will now try to compile from it's own snapshot tree, doing the ./configure.

I'm sorry to say that actually it was worst than before for me, so
maybe centos kernel is "non collaborative" (eg: no high res timers).

Following is some excerpts from the kernel config (grepping for
obvious words), if useful I can attach the entire kernel config, or
find other informations:

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_BKL=y
CONFIG_PREEMPT_NOTIFIERS=y

# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000

CONFIG_GENERIC_TIME=y
CONFIG_X86_CYCLONE_TIMER=y
CONFIG_HPET_TIMER=y
CONFIG_X86_PM_TIMER=y
CONFIG_NET_SCH_CLK_GETTIMEOFDAY=y
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_HANGCHECK_TIMER=m
CONFIG_SND_TIMER=m
CONFIG_SND_RTCTIMER=m
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_JFFS2_RTIME=y
# CONFIG_PRINTK_TIME is not set
CONFIG_KTIME_SCALAR=y

CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_IOSCHED="cfq"
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_NET_SCHED=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_SCHEDSTATS=y

-giovanni
