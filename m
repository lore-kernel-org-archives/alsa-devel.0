From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: sgtl5000: Use devm_ functions
Date: Mon, 7 Jul 2014 12:20:28 -0300
Message-ID: <CAOMZO5AiFCnfTzo4TyB5e5c+xiHQiHUbhRVY7z=AbjOWZDX3NA@mail.gmail.com>
References: <20140706070800.GA2927@himangi-Dell>
 <20140707144832.GL30458@sirena.org.uk>
 <alpine.DEB.2.10.1407071655171.4757@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f176.google.com (mail-lb0-f176.google.com
 [209.85.217.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 0ABEF26516D
 for <alsa-devel@alsa-project.org>; Mon,  7 Jul 2014 17:20:28 +0200 (CEST)
Received: by mail-lb0-f176.google.com with SMTP id w7so2938495lbi.7
 for <alsa-devel@alsa-project.org>; Mon, 07 Jul 2014 08:20:28 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.10.1407071655171.4757@hadrien>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Himangi Saraogi <himangi774@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 7, 2014 at 11:58 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:

> Nevertheless, there is already a call to devm_regulator_bulk_get in
> sgtl5000_enable_regulators which calls sgtl5000_replace_vddd_with_ldo
> which calls ldo_regulator_register.  That call was introduced by
>
> commit 63e54cd9caa3ce03635810608519e2b37d8bc706
> Author: Fabio Estevam <fabio.estevam@freescale.com>
> Date:   Thu Apr 24 14:13:08 2014 -0300
>
> It seems that that patch should be reverted?

I think so. Russell also reported a kernel oops when unbinding this
module, so I will prepare a patch reverting it.

Thanks
