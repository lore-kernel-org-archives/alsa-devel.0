From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: ak4642: simultaneous
	playback/recorde support
Date: Tue, 12 Oct 2010 11:00:06 +0100
Message-ID: <20101012100006.GD30933@rakim.wolfsonmicro.main>
References: <w3pbp70rpoq.wl%kuninori.morimoto.gx@renesas.com>
	<w3p8w24rpmr.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D88A31039EA
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Oct 2010 12:00:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <w3p8w24rpmr.wl%kuninori.morimoto.gx@renesas.com>
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

On Tue, Oct 12, 2010 at 01:39:25PM +0900, Kuninori Morimoto wrote:

>  		ak4642_write(codec, 0x09, 0x91);
>  		ak4642_write(codec, 0x0c, 0x91);
> -		ak4642_write(codec, 0x00, 0x64);
> +		snd_soc_update_bits(codec, 0x00, 0x64, 0x64);

Applied, but given all the magic numbers this is pretty much illegible -
it'd be good if when updating the driver you could start to convert the
magic numbers into #defines.
