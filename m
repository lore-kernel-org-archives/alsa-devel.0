From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH 1/2] ASoC: Initial WM8996 headphone
	impedance measurement support
Date: Mon, 19 Sep 2011 10:24:08 +0100
Message-ID: <CABS+qY0meCamPfE7Pn5fVxJDqavfX5MK0e7SWh-2U4xKJNdxEw@mail.gmail.com>
References: <1316265291-3758-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog122.obsmtp.com (na3sys009aog122.obsmtp.com
	[74.125.149.147])
	by alsa0.perex.cz (Postfix) with ESMTP id B0A3C2498B
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Sep 2011 11:24:11 +0200 (CEST)
Received: by mail-qw0-f45.google.com with SMTP id 2so5584278qwg.4
	for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2011 02:24:09 -0700 (PDT)
In-Reply-To: <1316265291-3758-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On 17 September 2011 14:14, Mark Brown
<broonie@opensource.wolfsonmicro.com>wrote:

> The WM8996 can measure the impedance of accessories connected to the
> headphone output. Implement initial support for this, measuring the
> left channel impedance when an accessory is detected and using this
> to distinguish between a line load and a headphone load.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8996.c |  137
> ++++++++++++++++++++++++++++++++++++--------
>  1 files changed, 112 insertions(+), 25 deletions(-)
>
>
Both

Acked-by: Liam Girdwood <lrg@ti.com>
