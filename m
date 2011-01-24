From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: EDB93xx machine sound driver with
	CS4271
Date: Mon, 24 Jan 2011 11:18:16 +0000
Message-ID: <1295867896.3419.7.camel@odin>
References: <1295744475.14515.38.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 0ACAD24464
	for <alsa-devel@alsa-project.org>; Mon, 24 Jan 2011 12:18:20 +0100 (CET)
Received: by wyi11 with SMTP id 11so3995531wyi.38
	for <alsa-devel@alsa-project.org>; Mon, 24 Jan 2011 03:18:19 -0800 (PST)
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Sun, 2011-01-23 at 04:01 +0300, Alexander Sverdlin wrote:
> From: Alexander Sverdlin <subaparts@yandex.ru>
> 
> Added support for EDB93xx sound with CS4271 CODEC.
> Features:
> - Playback, Capture
> - Sample rates from 8kHz to 96kHz tested
> Limitations:
> - No DAPM support
>        
> Signed-off-by: Alexander Sverdlin <subaparts@yandex.ru>
> ---
>  sound/soc/ep93xx/Kconfig   |    9 +++
>  sound/soc/ep93xx/Makefile  |    2 +
>  sound/soc/ep93xx/edb93xx.c |  142 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 153 insertions(+), 0 deletions(-)

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
