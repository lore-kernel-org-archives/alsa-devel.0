From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: Re: [PATCH 1/3] ASoC: Davinci: McASP: add support new
 McASP IP Variant
Date: Mon, 3 Sep 2012 06:57:22 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA718B0@DBDE01.ent.ti.com>
References: <1346417459-30042-1-git-send-email-gururaja.hebbar@ti.com>
 <1346417459-30042-2-git-send-email-gururaja.hebbar@ti.com>
 <20120901004443.GB21451@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 932F4264F25
 for <alsa-devel@alsa-project.org>; Mon,  3 Sep 2012 08:57:30 +0200 (CEST)
In-Reply-To: <20120901004443.GB21451@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Rajashekhara,
 Sudhakar" <sudhakar.raj@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Nori,
 Sekhar" <nsekhar@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "Girdwood,
 Liam" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Sep 01, 2012 at 06:14:44, Mark Brown wrote:
> On Fri, Aug 31, 2012 at 06:20:57PM +0530, Hebbar, Gururaja wrote:
> =

> > +			if (dev->version =3D=3D MCASP_VERSION_3) {
> > +				mcasp_clr_bits(dev->base + MCASP_VER3_RFIFOCTL,
> >  								FIFO_ENABLE);
> > -			mcasp_set_bits(dev->base + DAVINCI_MCASP_RFIFOCTL,
> > +				mcasp_set_bits(dev->base + MCASP_VER3_RFIFOCTL,
> >  								FIFO_ENABLE);
> > +			} else {
> > +				mcasp_clr_bits(dev->base +
> > +					DAVINCI_MCASP_RFIFOCTL,	FIFO_ENABLE);
> > +				mcasp_set_bits(dev->base +
> > +					DAVINCI_MCASP_RFIFOCTL,	FIFO_ENABLE);
> > +			}
> =

> This is all basically OK but it seems like it'd be better if all these
> dev->version checks were switch statements.  That way when the hardware
> designers get bored and add version 4 of the register map it'll slot in
> naturally, and it'll be more clear what the code currently handles.

Ok I will update this. Since 3/3 is already accepted & I don=92t see any re=
views
for 2/3, I will only resend this patch (1/3). Is it ok?

> =



Regards, =

Gururaja
