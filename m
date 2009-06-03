From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 1/4] ASoC: pxa-ssp: enhance I2S and add
	Left_J support
Date: Wed, 3 Jun 2009 16:24:50 +0200
Message-ID: <20090603142450.GR26148@buzzloop.caiaq.de>
References: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
	<20090603131819.GQ26148@buzzloop.caiaq.de>
	<f17812d70906030722x70029dc9x4e6cb37ad4cc5d1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id EFE801038BA
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Jun 2009 16:24:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <f17812d70906030722x70029dc9x4e6cb37ad4cc5d1f@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 03, 2009 at 10:22:17PM +0800, Eric Miao wrote:
> > The tdm time slot configuration needs to be set again in my board support
> > code just like in your example: snd_soc_set_tdm_slot(cpu_dai, 3, 2).
> 
> Mmm.... what would be the preferred way, to let board specific
> code do this or the I2S configuration code?

It is a configuration details that is up to the user to set up. Hence
the right place is the board specific code - I just wanted to let you
know the interface differences from a board support code point of view.

Daniel
