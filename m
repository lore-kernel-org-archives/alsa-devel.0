From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: mxs: mxs-saif: Fix the
	playback/record capabilities
Date: Mon, 3 Jun 2013 12:18:16 -0300
Message-ID: <CAOMZO5BVwMM2Q3CAoepmc0dQgHDARKoUuUrab--Y=6WNm-GA1Q@mail.gmail.com>
References: <1370191092-1773-1-git-send-email-festevam@gmail.com>
 <51ABA36D.8020802@metafoo.de>
 <20130603092028.GD31367@sirena.org.uk>
 <51ACB14D.2050205@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f48.google.com (mail-vb0-f48.google.com
 [209.85.212.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 65113261ABC
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2013 17:18:17 +0200 (CEST)
Received: by mail-vb0-f48.google.com with SMTP id w8so2653785vbf.7
 for <alsa-devel@alsa-project.org>; Mon, 03 Jun 2013 08:18:16 -0700 (PDT)
In-Reply-To: <51ACB14D.2050205@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: marex@denx.de, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 3, 2013 at 12:07 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:

> I think the sgtl5000 has a single bidirectional DAI, but I'd assume that it

Yes, correct.

> is not the only CODEC to be ever used with the mxs-saif. In my opinion a
> better solution is to add support for being able to specify if a
> snd_soc_dai_link is used playback, capture or both.

Yes, I think that adding a device tree property specifying the SAIF
direction could do the trick.
