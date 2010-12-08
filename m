From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: EDB93xx machine sound driver
Date: Wed, 8 Dec 2010 13:36:23 +0000
Message-ID: <20101208133622.GG16418@rakim.wolfsonmicro.main>
References: <1291809834.31916.5.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4F5ED244C9
	for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2010 14:36:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1291809834.31916.5.camel@r60e>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexander <subaparts@yandex.ru>
Cc: alsa-devel@alsa-project.org, ryan@bluewatersys.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 08, 2010 at 03:03:54PM +0300, Alexander wrote:
> From: Alexander Sverdlin <subaparts@yandex.ru>
> 
> Added support for EDB93xx sound with CS4271 codec.
> Features:
> - Playback, Capture
> - Sample rates from 8kHz to 96kHz tested
> Limitations:
> - Depends on ALSA auto sample format conversion
> - No DAPM support

This looks good.
