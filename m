From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 0/4] ASoC: fsi: FSI2 device support
Date: Wed, 24 Mar 2010 09:33:12 +0000
Message-ID: <1269423192.3798.17.camel@odin>
References: <u1vfa44ls.wl%morimoto.kuninori@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f195.google.com (mail-iw0-f195.google.com
	[209.85.223.195])
	by alsa0.perex.cz (Postfix) with ESMTP id DA0B410387B
	for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2010 10:33:35 +0100 (CET)
Received: by iwn33 with SMTP id 33so6222190iwn.23
	for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2010 02:33:33 -0700 (PDT)
In-Reply-To: <u1vfa44ls.wl%morimoto.kuninori@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-03-24 at 15:26 +0900, Kuninori Morimoto wrote:
> Dear Mark
> 
> These patches are FSI2 support
> 
> Kuninori Morimoto (4):
>       ASoC: fsi: ensures process inside master lock
>       ASoC: fsi: Add FIFO size calculate
>       ASoC: fsi: IRQ related process had be united
>       ASoC: fsi: Add FSI2 device support
> 
> ARM SH-MOBILE series have FSI2/FMSI device which are
> advance version of FSI.
> Above patches add simple FSI2 support.
> These patches are tested on AP4 board

Btw, your clock appears to be a bit broken, patch 2/4 has a time stamp
from 7 days ago...

Liam 

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
