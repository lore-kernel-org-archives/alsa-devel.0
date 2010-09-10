From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: fsi codecs: modify menu attribute on
	Kconfig
Date: Fri, 10 Sep 2010 12:20:04 +0100
Message-ID: <1284117604.3088.229.camel@odin>
References: <w3pvd6enzyv.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D5F8B103982
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 13:20:07 +0200 (CEST)
Received: by wyb32 with SMTP id 32so2576902wyb.38
	for <alsa-devel@alsa-project.org>; Fri, 10 Sep 2010 04:20:07 -0700 (PDT)
In-Reply-To: <w3pvd6enzyv.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Guennadi <g.liakhovetski@gmx.de>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-09-10 at 10:34 +0900, Kuninori Morimoto wrote:
> Current SND_FSI_xxx menu attributes were bool,
> but it should be tristate.
> This patch solve below report from Guennadi
> 
> "bool" means, if someone is linking the whole ASoC into the kernel, they
> will not be able to build this as a module. Not a big deal, but you're
> stealing some freedom from the user.
> 
> Reported-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
