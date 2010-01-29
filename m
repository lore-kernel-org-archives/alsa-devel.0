From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: remove bogus SLEEP mode from wm8978
	driver
Date: Fri, 29 Jan 2010 11:04:35 +0000
Message-ID: <1264763075.3080.24.camel@odin>
References: <Pine.LNX.4.64.1001281627540.4356@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f213.google.com (mail-ew0-f213.google.com
	[209.85.219.213])
	by alsa0.perex.cz (Postfix) with ESMTP id 34DCE1038E8
	for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2010 12:04:38 +0100 (CET)
Received: by ewy5 with SMTP id 5so3578613ewy.32
	for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2010 03:04:38 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1001281627540.4356@axis700.grange>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-01-28 at 16:28 +0100, Guennadi Liakhovetski wrote:
> Tests showed, that bit 6 of the WM8978_POWER_MANAGEMENT_2 register of wm8978
> affects codec clocks. Being useless for suspend / resume, it cannot be used in
> bias-level control either. Remove this bit handling.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---

Both Wm8978 patches :-

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
