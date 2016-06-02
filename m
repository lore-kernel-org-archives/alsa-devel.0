From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: sgtl5000: only check VDDD-supply, not revision
Date: Thu, 2 Jun 2016 12:48:15 -0300
Message-ID: <CAOMZO5B20n7Tu3r+BsU2R5BbYj41tf7qBsMLRWxChdWMkHxLNQ@mail.gmail.com>
References: <20160602124724.7725-1-clemens.gruber@pqgruber.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160602124724.7725-1-clemens.gruber@pqgruber.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Eric Nelson <eric@nelint.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

On Thu, Jun 2, 2016 at 9:47 AM, Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:
> Instead of checking the SGTL5000 chip revision, we should only check if
> the VDDD regulator exists and only call sgtl5000_replace_vddd_with_ldo
> if the regulator is missing.
> Otherwise, the user reads in the kernel log that the internal LDO is
> used, even though he did follow the NXP recommendation to use external
> VDDD and also specified VDDD-supply in the devicetree.
>
> Also remove the comment, which incorrectly states that external VDDD is
> only supported for SGTL5000 chip revisions < 0x11.
> Official NXP documentation recommends using external VDDD and not the
> internal LDO due to the SGTL5000 erratum ER1. This also applies to
> revisions >= 0x11.
>
> Tested on an i.MX6Q board with SGTL5000 rev 0x11 and external VDDD.

Patch looks good to me.

Eric,

Sometime ago you were looking at this. What do you think about this patch?

Thanks
