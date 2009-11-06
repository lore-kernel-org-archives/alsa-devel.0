From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH]ASoc:ZOOM2:Add support for DSP rendering.
Date: Fri, 6 Nov 2009 14:03:07 +0000
Message-ID: <20091106140306.GD10371@rakim.wolfsonmicro.main>
References: <1257459691-12411-1-git-send-email-jwang@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 09865246DA
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2009 15:03:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1257459691-12411-1-git-send-email-jwang@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jane Wang <jwang@ti.com>
Cc: alsa-devel@alsa-project.org, peter.ujfalusi@nokia.com
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 05, 2009 at 04:21:31PM -0600, Jane Wang wrote:

> New mixer controls added to send dapm stream events to power up/down TWL4030
> DAPM widgets along playback and capture paths. In case of DSP rendering,
> use the corresponding mixer control to power up widgets before stream starts
> and power down the widges after stream stops.

What does the hardware look like and what is the problem you're trying
to solve here?  Sending stream events into the core is a definite
layering violation and is likely to fail with some use case transitions
but without knowing what the patch is trying to achieve it's hard to
offer much advice.

> +static const char *path_control[] = {"Off", "On"};

> +static const struct soc_enum zoom2_enum[] = {
> +	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(path_control), path_control),
> +};

Why is this an enumerated control and not a switch?
