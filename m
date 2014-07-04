From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH v4 6/8] ASoC: compress: Add support for DAI
 multicodec
Date: Fri, 04 Jul 2014 15:55:41 +0200
Message-ID: <53B6B25D.4010605@baylibre.com>
References: <20140701164134.GH2296@intel.com> <53B400DE.3040205@baylibre.com>
 <20140703064147.GK2296@intel.com> <53B539E8.1000301@baylibre.com>
 <53B53C6B.8020707@metafoo.de> <53B540EE.30009@baylibre.com>
 <53B541F0.1040105@metafoo.de> <53B5428F.9050100@baylibre.com>
 <20140703120613.GP2296@intel.com> <20140703121846.GB410@sirena.org.uk>
 <20140703161517.GQ2296@intel.com> <53B59F94.6040803@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
 by alsa0.perex.cz (Postfix) with ESMTP id F09792659E6
 for <alsa-devel@alsa-project.org>; Fri,  4 Jul 2014 15:55:43 +0200 (CEST)
Received: by mail-wg0-f41.google.com with SMTP id a1so1741610wgh.24
 for <alsa-devel@alsa-project.org>; Fri, 04 Jul 2014 06:55:43 -0700 (PDT)
In-Reply-To: <53B59F94.6040803@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vinod.koul@intel.com>
Cc: misael.lopez@ti.com, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/07/2014 20:23, Lars-Peter Clausen wrote:

[...]

> If the assumption is that a DAI link that has a compressed DAI on the
> CPU side is never connected to a 'real' CODEC (or multiple CODECS) on
> the CODEC side. I think we can just leave soc-compress.c alone and just
> add a sanity check to make sure that num_codecs is always 1.

OK, I'll repost the series without any change on soc-compress.c beside a =

test.

Thanks,
Benoit

-- =

Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
