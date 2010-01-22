From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] add simplified versions of widget macros
Date: Fri, 22 Jan 2010 09:56:07 +0000
Message-ID: <1264154167.3094.28.camel@odin>
References: <Pine.LNX.4.64.1001212046320.9137@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f213.google.com (mail-ew0-f213.google.com
	[209.85.219.213])
	by alsa0.perex.cz (Postfix) with ESMTP id CEC9724393
	for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2010 10:56:11 +0100 (CET)
Received: by ewy5 with SMTP id 5so1232246ewy.32
	for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2010 01:56:11 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1001212046320.9137@axis700.grange>
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

On Thu, 2010-01-21 at 21:10 +0100, Guennadi Liakhovetski wrote:
> Many macros from include/sound/soc-dapm.h take an array and a number of 
> elements in it as arguments, whereas most users use static arrays and use 
> "x, ARRAY_SIZE(x)" as arguments. This patch adds simplified versions of 
> those macros, calling ARRAY_SIZE() internally.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Both macro patches :-

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
