From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Question about device recovery when under/over run
	error case
Date: Wed, 20 Jan 2016 12:19:32 +0900
Message-ID: <569EFCC4.3040407@sakamocchi.jp>
References: <87twmbfqio.wl%kuninori.morimoto.gx@renesas.com>
 <569C7215.2000801@sakamocchi.jp>
 <87si1vfmv6.wl%kuninori.morimoto.gx@renesas.com>
 <s5h4mebs33a.wl-tiwai@suse.de>
 <87vb6q4ev2.wl%kuninori.morimoto.gx@renesas.com>
 <569D8E35.4010306@sakamocchi.jp>
 <87si1u46d9.wl%kuninori.morimoto.gx@renesas.com>
 <569DABD3.4080707@sakamocchi.jp>
 <87powy4207.wl%kuninori.morimoto.gx@renesas.com>
 <569E2D25.4070205@sakamocchi.jp>
 <87bn8h3ve7.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B8F3260599
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2016 04:19:36 +0100 (CET)
In-Reply-To: <87bn8h3ve7.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, shiiba <naoya.shiiba.nx@renesas.com>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, komatsu <toshiaki.komatsu.ud@renesas.com>, Mark Brown <broonie@kernel.org>, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Jan 20 2016 10:17, Kuninori Morimoto wrote:
>> Could I request you to explain about usage of this lock primitive in SoC
>> with a few cores (i.e. 2) when dts allows the driver to handle several
>> PCM substreams and userspace applications try to use the PCM substreams
>> almost the same time?
>> http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/sound/soc/sh/rcar/core.c#n501
>
> Your concern is that my driver is using "trigger", and it will be called
> from several context.
> Indeed, one side might be locked if few substreams are used in same time,
> because it is using shared lock.

Background: current Linux kernel don't execute kernel preemption in 
interrupt contexts. For further information, please follow to 
CONFIG_PREEMPT_RT patchset project.
https://rt.wiki.kernel.org/

When using spin_lock_irqsave() in any context, processor core local is 
under:
  * kernel preemption disable
  * software IRQ disable
  * hardware IRQ disable

When the process context is in the critical section of the code, the 
other process contexts can spin over each core with the state.

In a processor with a few cores, which cores can handle _any_ hardware 
interrupts? It may be quite a short time in your case but...

Althogh I don't know exactly how your SoC controls hardware interrupts, 
I'm concern about this situation based on my understanding of typical 
embedded platform. If I misunderstand anything, please inform it to me 
to update my knowledgement.

> But, I think I need to use it since it is using shared register.
> And, I'm confusing that what is the problem in this case ?
> Do you mean I shoudn't use "trigger" ?

I don't exactly know about for which purpose the SoC is used and what 
constitution the SoC actually have. Here, I suggest a possible 
scenarioin of your future:

The snd-rcar-soc gets more 'struct rsnd_mod' to use IPs in the SoC and 
some operations are executed the .trigger(). The .trigger() takes a bit 
long. During the time, the local CPU cannot handle any hardware 
interrupts. In this situation, the other process context enters the 
critical section by userspace applications. These contexts spin over 
cores, and all of cores cannot handle hardware interrupts. As a result, 
no hardware interrupts cannot be handled. This causes a response latency 
of the system in a certain situation which is hard to be identified.


Well, I think it better to do it in 'struct snd_pcm_ops.prepare()' 
callback, because it runs in process contexts and any lock primitives 
with interrupts-enabled state are available (i.e. mutex). It's better 
for cheap embedded platforms.


Takashi Sakamoto
