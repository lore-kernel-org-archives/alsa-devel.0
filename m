From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: EDB93xx machine sound driver with
	CS4271
Date: Mon, 24 Jan 2011 12:08:16 +0000
Message-ID: <20110124120816.GD29925@opensource.wolfsonmicro.com>
References: <1295744475.14515.38.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 49D432447F
	for <alsa-devel@alsa-project.org>; Mon, 24 Jan 2011 13:08:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1295744475.14515.38.camel@r60e>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexander Sverdlin <subaparts@yandex.ru>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 23, 2011 at 04:01:15AM +0300, Alexander Sverdlin wrote:
> From: Alexander Sverdlin <subaparts@yandex.ru>
> 
> Added support for EDB93xx sound with CS4271 CODEC.
> Features:
> - Playback, Capture
> - Sample rates from 8kHz to 96kHz tested

Applied, thanks.

> Limitations:
> - No DAPM support

Looks like there's no DAPM to support in this machine...
