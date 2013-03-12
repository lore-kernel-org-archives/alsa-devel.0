From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 1/2 v2] ASoC: add
	snd_soc_register_component()
Date: Tue, 12 Mar 2013 15:35:01 -0600
Message-ID: <513F9F85.7050301@wwwdotorg.org>
References: <87fw06ace9.wl%kuninori.morimoto.gx@renesas.com>
 <87k3pdtnlk.wl%kuninori.morimoto.gx@renesas.com>
 <87ip4xtnka.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 93888265DAF
 for <alsa-devel@alsa-project.org>; Tue, 12 Mar 2013 22:35:06 +0100 (CET)
In-Reply-To: <87ip4xtnka.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Simon <horms@verge.net.au>, Liam Girdwood <liam.r.girdwood@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/11/2013 07:27 PM, Kuninori Morimoto wrote:
> Current ASoC has register function for platform/codec/dai/card,
> but doesn't have for cpu.
> It often produces confusion and fault on ASoC.
> 
> As result of ASoC community discussion,
> we consider new struct snd_soc_component for CPU/CODEC,
> and will switch over to use it.
> 
> This patch adds very basic struct snd_soc_component,
> and register function for it.

Perhaps as a separate patch: It'd be nice to add file
/sys/kernel/debug/asoc/components that listed all the registered
components. Anywhere else in debugfs/sysfs/... that CODECs are enumerate
might want to cover components too.
