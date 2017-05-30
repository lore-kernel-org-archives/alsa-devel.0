From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: ALSA SoC + Hotplug ?
Date: Tue, 30 May 2017 08:29:59 -0500
Message-ID: <0b58a8ba-a35f-2584-a0d7-62c518995dcf@linux.intel.com>
References: <PS1PR0601MB188149580ECBA5618DA981F6D4F00@PS1PR0601MB1881.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id E3866266E30
 for <alsa-devel@alsa-project.org>; Tue, 30 May 2017 15:29:51 +0200 (CEST)
In-Reply-To: <PS1PR0601MB188149580ECBA5618DA981F6D4F00@PS1PR0601MB1881.apcprd06.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 5/30/17 1:42 AM, Kuninori Morimoto wrote:
> Hi ALSA ML
>
> Now, ALSA SoC can support HDMI, then, we want to support Hotplug for it.
> In my quick grep, it seems ALSA SoC doesn't have such support now (?)
> But, is it supported ?

We looked at it a couple of days ago and were indeed surprised that only 
Intel drivers seem to use snd_jack_report() [1]. It'd be good if there 
was a common way of signaling hot plug events to user space...

[1] http://elixir.free-electrons.com/linux/latest/ident/SND_JACK_AVOUT
