From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH V2] ASoC - Add support for upto 16 channels
 on OMAP MCBSP
Date: Mon, 9 Nov 2009 08:57:22 +0200
Message-ID: <20091109085722.49d40bd8.jhnikula@gmail.com>
References: <1257454808.3576.397.camel@odin>
	<20091106202400.a0ded9c3.jhnikula@gmail.com>
	<6ed0b2680911071211g311e6399va88ff7daff7b8ed1@mail.gmail.com>
	<1257712022.15162.2.camel@vega>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f217.google.com (mail-bw0-f217.google.com
	[209.85.218.217])
	by alsa0.perex.cz (Postfix) with ESMTP id BB22D10383D
	for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2009 07:56:30 +0100 (CET)
Received: by bwz9 with SMTP id 9so11895178bwz.32
	for <alsa-devel@alsa-project.org>; Sun, 08 Nov 2009 22:56:29 -0800 (PST)
In-Reply-To: <1257712022.15162.2.camel@vega>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Mark@alsa-project.org, Graeme Gregory <gg@slimlogic.co.uk>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sun, 08 Nov 2009 20:27:01 +0000
Liam Girdwood <lrg@slimlogic.co.uk> wrote:

> > Seems to be working fine, tried playing several different sample rates
> > and also recording path. FYI pandora has TWL4030 256FS clock connected
> > to OMAP's CLKS pin.
> > 
> > Tested-by: Grazvydas Ignotas <notasas@gmail.com>
> 
> Jarkko, Peter,
> 
> Any chance we could have your Ack before applying.
> 
Definitely. I just sent a patch which must be applied before yours to
the Pandora. It is otherwise the same than I sent before but now with
commit log and 8*32 replaced with 256.

Mark: The omap3pandora.c must be patches before Liam's patch.

http://mailman.alsa-project.org/pipermail/alsa-devel/2009-November/022921.html
http://mailman.alsa-project.org/pipermail/alsa-devel/2009-November/022797.html

Acked-by: Jarkko Nikula <jhnikula@gmail.com>
