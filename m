From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: Fix SND_SOC_ALL_CODECS typos for
 alc5623 and jz4740
Date: Mon, 1 Nov 2010 15:31:12 +0200
Message-ID: <20101101153112.13a01f28.jhnikula@gmail.com>
References: <1288360065-9793-1-git-send-email-jhnikula@gmail.com>
	<20101101132253.GA23423@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 60AB5103821
	for <alsa-devel@alsa-project.org>; Mon,  1 Nov 2010 14:31:11 +0100 (CET)
Received: by eyg24 with SMTP id 24so2855463eyg.38
	for <alsa-devel@alsa-project.org>; Mon, 01 Nov 2010 06:31:11 -0700 (PDT)
In-Reply-To: <20101101132253.GA23423@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, 1 Nov 2010 09:22:56 -0400
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Fri, Oct 29, 2010 at 04:47:44PM +0300, Jarkko Nikula wrote:
> 
> >  	select SND_SOC_AK4671 if I2C
> > -	select SND_SOC_ALC562 if I2C
> > +	select SND_SOC_ALC5623 if I2C
> 
> This patch doesn't apply as-is since this CODEC isn't in mainline.  I've
> dropped it from the patch and applied together with the second patch.

Ah, I forgot to point these were for 2.6.38 and thus alc5623 were
here. I thought SND_SOC_ALL_CODECS is useful only to ASoC developers
and didn't consider .37 at all :-)


-- 
Jarkko
