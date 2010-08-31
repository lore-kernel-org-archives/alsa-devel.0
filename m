From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/2] ASoC: fsi: modify bug fix
Date: Tue, 31 Aug 2010 13:31:44 +0100
Message-ID: <20100831123144.GK20849@rakim.wolfsonmicro.main>
References: <w3ppqx0jpbk.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 091D110381C
	for <alsa-devel@alsa-project.org>;
	Tue, 31 Aug 2010 14:31:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <w3ppqx0jpbk.wl%kuninori.morimoto.gx@renesas.com>
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

On Mon, Aug 30, 2010 at 08:46:20PM +0900, Kuninori Morimoto wrote:
> 
> Dear Mark, Liam
> 
> These are bug fix for FSI
> 
>       ASoC: fsi: modify compile error
>       ASoC: fsi-ak4642/fsi-da7210: modify dai link settings for card detect

Applied both, thanks.

> 2nd patch is quick hack for now.
> I will modify it more wisely in future. but no idea now

For this we probably want to support wildcard matches that don't specify
the address for the CODEC.  Otherwise you probably want to do
machine_is_() checks when probing the driver and assign the codec name
based on those.
