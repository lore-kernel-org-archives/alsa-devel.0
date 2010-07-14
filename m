From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC][PATCH 1/3] ASoC: ak4642: make sure
 snd_soc_codec value for ak4642
Date: Wed, 14 Jul 2010 09:13:12 +0100
Message-ID: <20100714081311.GA17071@rakim.wolfsonmicro.main>
References: <w3pvd8ig9q4.wl%kuninori.morimoto.gx@renesas.com>
	<w3ptyo2g9or.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 464D8103819
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Jul 2010 10:13:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <w3ptyo2g9or.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 14, 2010 at 09:59:31AM +0900, Kuninori Morimoto wrote:
> If snd_soc_card has some dai_link,
> there is a possibility that the snd_coc_codec value
> which came from function is not ak4642's codec.
> This patch make sure it for ak4642

Could you be more specific about what you're trying to do here?  This
patch adds additional uses of the global variable for finding the codec
which is pretty much the opposite direction to where we want to go.  Is
it possible you need multi-codec support?
