From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v2 00/16] ASoC: fsl-ssi: Driver cleanup
Date: Fri, 4 Apr 2014 14:59:57 +0200
Message-ID: <CAOf5uw=CGyk4tvGaUzQeF=z_VqEP_uB0=-ueHt-4cfULTbaQ_g@mail.gmail.com>
References: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
 <20140403221406.GI14763@sirena.org.uk>
 <20140404064932.GC20621@pengutronix.de>
 <CAOf5uwkDdsDzRAMHV0e2ideR-R8Tztis1HxqosQAxefVQDE3oA@mail.gmail.com>
 <20140404105910.GF20621@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f50.google.com (mail-wg0-f50.google.com [74.125.82.50])
 by alsa0.perex.cz (Postfix) with ESMTP id A3B5F2657D4
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 14:59:57 +0200 (CEST)
Received: by mail-wg0-f50.google.com with SMTP id x13so3493141wgg.9
 for <alsa-devel@alsa-project.org>; Fri, 04 Apr 2014 05:59:57 -0700 (PDT)
In-Reply-To: <20140404105910.GF20621@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>, kernel@pengutronix.de, Nicolin Chen <Guangyu.Chen@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Markus

On Fri, Apr 4, 2014 at 12:59 PM, Markus Pargmann <mpa@pengutronix.de> wrote:
> Hi Michael,
>
> On Fri, Apr 04, 2014 at 09:58:03AM +0200, Michael Trimarchi wrote:
>> Hi Markus
>>
>> On Fri, Apr 4, 2014 at 8:49 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
>> > Hi,
>> >
>> > On Thu, Apr 03, 2014 at 11:14:06PM +0100, Mark Brown wrote:
>> >> On Sat, Mar 15, 2014 at 01:44:08PM +0100, Markus Pargmann wrote:
>> >> > Hi,
>> >> >
>> >> > This new version of the cleanup is mainly a reordering of the patches. It moves
>> >> > the regmap patch to the end of the series so none of the other patches depend
>> >> > on it. This also fixes a bug I introduced in "Remove fsl_ssi_setup" which also
>> >> > removed the switching between network and normal mode depending on the number
>> >> > of channels. I reversed this code removal. Another new patch was added "Fix
>> >> > i2s_mode variable setup" which fixes the i2s_mode assignment in set_dai_fmt().
>> >>
>> >> It's been nearly three weeks with no response to this except for the
>> >> last patch - I've got ahead and applied since it all looks sane (modulo
>> >> the bugfix question), we can see if problems occur in -next after the
>> >> merge window.  Thanks!
>> >
>> > Thanks for applying this series, but could you please drop it for the
>> > moment? We found some issues with the baud clock setup for i2s master
>> > mode and have some fixed patches for the series. So it would be nice to
>> > get this in without fixups if that's still possible? I could send a v3
>> > next week.
>>
>> We have tested a bit them on Wandboard and rebase our patches.
>> I was busy in the last 2 weeks but they are fine so far.
>
> Thank you for testing. Can I add a Tested-by tag to the commits that
> didn't change for the next version of this series?
>

Yes you can add it.

Michael

> Regards,
>
> Markus
>
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
