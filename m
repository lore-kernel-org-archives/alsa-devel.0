From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 2/3] ASoC: dio2125: add dio2125 amp driver
Date: Tue, 07 Mar 2017 14:13:20 +0100
Message-ID: <1488892400.2420.26.camel@baylibre.com>
References: <20170306174451.24406-1-jbrunet@baylibre.com>
 <20170306174451.24406-3-jbrunet@baylibre.com>
 <20170307123653.jg7jqe4sft2pqycc@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B115266AC4
 for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2017 14:13:21 +0100 (CET)
Received: by mail-wm0-f42.google.com with SMTP id n11so4441809wma.0
 for <alsa-devel@alsa-project.org>; Tue, 07 Mar 2017 05:13:21 -0800 (PST)
In-Reply-To: <20170307123653.jg7jqe4sft2pqycc@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Kevin Hilman <khilman@baylibre.com>, alsa-devel@alsa-project.org, Neil Armstrong <narmstrong@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2017-03-07 at 13:36 +0100, Mark Brown wrote:
> On Mon, Mar 06, 2017 at 06:44:50PM +0100, Jerome Brunet wrote:
> 
> > +	gpiod_set_value(priv->gpiod_enable, val);
> 
> You should use gpiod_set_value_cansleep() so that the driver can work
> with all GPIOs unless there's a specific need to have GPIOs you can
> control in interrupt (which should be the case for anything you're
> using
> for DAPM control).

Indeed, Thanks for pointing this out.
I have question regarding this DAPM control.
Here, I put the control in DAPM so it can help with the pop noise
reduction, but I think it would be nice if the user could force the
mute if he wants to.

Would it be OK to add a user control and some logic so the output is
enabled only if DAPM and the user agree it should ?

> 
> Please submit an incremental patch fixing this.

Done
