From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: sgtl5000: only check VDDD-supply,
	not revision
Date: Sun, 5 Jun 2016 22:22:55 -0300
Message-ID: <CAOMZO5Bvtpc0umHLDa_kE_a0tfMPZJK-pgUevcTx1RYi_oXphw@mail.gmail.com>
References: <20160602124724.7725-1-clemens.gruber@pqgruber.com>
 <CAOMZO5B20n7Tu3r+BsU2R5BbYj41tf7qBsMLRWxChdWMkHxLNQ@mail.gmail.com>
 <5751AEF6.40200@nelint.com> <575264A4.2070709@nelint.com>
 <20160604090324.GA867@archie.localdomain>
 <20160604171525.GA29266@archie.localdomain>
 <20160605231626.GA4076@archie.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f195.google.com (mail-io0-f195.google.com
 [209.85.223.195])
 by alsa0.perex.cz (Postfix) with ESMTP id B992626573D
 for <alsa-devel@alsa-project.org>; Mon,  6 Jun 2016 03:22:56 +0200 (CEST)
Received: by mail-io0-f195.google.com with SMTP id 5so674726ioy.0
 for <alsa-devel@alsa-project.org>; Sun, 05 Jun 2016 18:22:56 -0700 (PDT)
In-Reply-To: <20160605231626.GA4076@archie.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: Eric Nelson <eric@nelint.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

On Sun, Jun 5, 2016 at 8:16 PM, Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:

> I looked into this today and discovered the following:
>
> With my patch applied, if I reset the board just after playback, at the
> next boot, the sgtl5000_fill_defaults function does not succeed: Writing
> the default value 0x7060 to register 0x30 (CHIP_ANA_POWER) fails.
>
> How did CHIP_ANA_POWER change with my patch: Before, only
> LINREG_SIMPLE_POWERUP was cleared as is recommended in the datasheet
> when using the internal LDO, now both LINREG_SIMPLE_POWERUP and
> STARTUP_POWERUP are cleared, as is recommended when using external VDDD.
>
> But why does the SGTL5000 nack that default write to CHIP_ANA_POWER
> after a reboot, which interrupted the playback?
>
> The following patch from Eric solved the problem; one write fails but it
> continues setting the other registers and thus even if resetting a board
> during playback, the sound still works after reboot:
> http://mailman.alsa-project.org/pipermail/alsa-devel/2015-February/088356.html
> Another workaround might be to not even write a default value to
> CHIP_ANA_POWER, as in this patch from Eric:
> http://mailman.alsa-project.org/pipermail/alsa-devel/2015-February/088355.html
>
> What do you think we should do?

Shouldn't both patches be applied?
