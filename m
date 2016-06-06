From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: sgtl5000: only check VDDD-supply,
	not revision
Date: Mon, 6 Jun 2016 14:10:12 -0300
Message-ID: <CAOMZO5CVLz2L2mV5uh4bm_pCKA0PRJVK1_r4H-=UkK4e-AQWjQ@mail.gmail.com>
References: <20160602124724.7725-1-clemens.gruber@pqgruber.com>
 <CAOMZO5B20n7Tu3r+BsU2R5BbYj41tf7qBsMLRWxChdWMkHxLNQ@mail.gmail.com>
 <5751AEF6.40200@nelint.com> <575264A4.2070709@nelint.com>
 <20160604090324.GA867@archie.localdomain>
 <20160604171525.GA29266@archie.localdomain>
 <20160605231626.GA4076@archie.localdomain>
 <CAOMZO5Bvtpc0umHLDa_kE_a0tfMPZJK-pgUevcTx1RYi_oXphw@mail.gmail.com>
 <20160606164547.GA2203@archie.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f194.google.com (mail-io0-f194.google.com
 [209.85.223.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 258BF2659FB
 for <alsa-devel@alsa-project.org>; Mon,  6 Jun 2016 19:10:14 +0200 (CEST)
Received: by mail-io0-f194.google.com with SMTP id n127so3015434iof.2
 for <alsa-devel@alsa-project.org>; Mon, 06 Jun 2016 10:10:14 -0700 (PDT)
In-Reply-To: <20160606164547.GA2203@archie.localdomain>
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

On Mon, Jun 6, 2016 at 1:45 PM, Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:

> Yes, I think so too. However I am unsure if we should also remove
> SGTL5000_CHIP_LINREG_CTRL from the defaults as in Eric's patch 3/6 or
> only keep the parts of the patch dealing with SGTL5000_CHIP_ANA_POWER.
> What do you think?

I think the way Eric did in patch 3/6 is fine.

Thanks
