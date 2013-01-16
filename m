From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8978: SND_SOC_DAIFMT_NB_NF become
	default	clock inversion
Date: Wed, 16 Jan 2013 01:04:17 +0000
Message-ID: <20130116010417.GA15503@opensource.wolfsonmicro.com>
References: <877gne6kvh.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 638CB2616B2
 for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2013 02:04:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <877gne6kvh.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 15, 2013 at 04:18:30PM -0800, Kuninori Morimoto wrote:
> Current wm8978 driver return -EINVAL if it doesn't have
> SND_SOC_DAIFMT_INV_MASK flags on snd_soc_dai_ops :: set_fmt.
> But default settings should be treated as
> SND_SOC_DAIFMT_NB_NF (= no clock inversion).

I'd say the fix here is really to change the values of the flags so that
_NB_NF is zero - this is a widespread thing in drivers and it makes
sense from a user point of view too.
