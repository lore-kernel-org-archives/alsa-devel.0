From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [alsa-devel] "ak" vs "asahi-kasei" (was: Re: [PATCH 3/3 v3] ARM:
 shmobile: lager: add sound support on DT)
Date: Wed, 11 Jun 2014 18:57:44 +0200
Message-ID: <CAMuHMdUT0hEBGbN+W-Oz5zJ0N8S2VDMndqtDO=EtWF3jG2MEew@mail.gmail.com>
References: <CAMuHMdWTVBjFzA9L9Eqpq_2Xi9_NHkOCLrb_UjK611SBfwnc=Q@mail.gmail.com>
	<87ioo7c0g5.wl%kuninori.morimoto.gx@renesas.com>
	<539815E6.2050304@codethink.co.uk>
	<20140611165410.GK5099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20140611165410.GK5099@sirena.org.uk>
Sender: linux-sh-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 11, 2014 at 6:54 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Jun 11, 2014 at 09:40:06AM +0100, Ben Dooks wrote:
>> On 11/06/14 09:30, Kuninori Morimoto wrote:
>
>> >>> ak4642 driver can't probe by "ak";
>
>> Should we add ak, as well?
>
> They're usually referred to as AKM when abbreviated and their web site
> is http://www.akm.com/ - don't know what the stock ticker symbol is.  In
> any case there's no real cost to adding both abbreviated and
> non-abbreviated forms if we want to transition.

commit ae8c4209af2cec065fef15d200a42a04130799f7
Author: Stephen Warren <swarren@nvidia.com>
Date:   Mon Nov 19 15:34:43 2012 -0700

    of: Add vendor prefix for Asahi Kasei Corp.

    Their stock ticker is 3407.T which wouldn't make a good DT vendor
    prefix. Use the company name initials instead.

    Signed-off-by: Stephen Warren <swarren@nvidia.com>
    Signed-off-by: Rob Herring <rob.herring@calxeda.com>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
