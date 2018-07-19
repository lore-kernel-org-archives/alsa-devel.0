From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH RESEND 02/15] ASoC: meson: add axg
	fifo	base driver
Date: Thu, 19 Jul 2018 09:55:53 +0200
Message-ID: <1531986953.26720.21.camel@baylibre.com>
References: <20180717154304.9973-1-jbrunet@baylibre.com>
 <20180717154304.9973-3-jbrunet@baylibre.com>
 <20180718115054.GI5700@sirena.org.uk> <s5ha7qoblk0.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C0A072675FC
 for <alsa-devel@alsa-project.org>; Thu, 19 Jul 2018 09:55:55 +0200 (CEST)
Received: by mail-wr1-f65.google.com with SMTP id h9-v6so7070278wro.3
 for <alsa-devel@alsa-project.org>; Thu, 19 Jul 2018 00:55:55 -0700 (PDT)
In-Reply-To: <s5ha7qoblk0.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Kevin Hilman <khilman@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2018-07-18 at 17:39 +0200, Takashi Iwai wrote:
> On Wed, 18 Jul 2018 13:50:54 +0200,
> Mark Brown wrote:
> > 
> > On Tue, Jul 17, 2018 at 05:42:51PM +0200, Jerome Brunet wrote:
> > 
> > > +	return !status ? IRQ_NONE : IRQ_HANDLED;
> > 
> > Please just write normal conditional statements, it makes things a lot
> > easier to read (the ! isn't helping either here).

Indeed. I'll correct this in a follow up patch

> 
> ... and there is the standard IRQ_RETVAL() macro for this purpose.

I was not aware of it. Thanks for the tip Takashi

> 
> 
> Takashi
