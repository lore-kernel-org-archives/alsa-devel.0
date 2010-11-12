From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2 2/3] ASoC: Move widgets from DAPM context
 to snd_soc_card
Date: Fri, 12 Nov 2010 14:40:04 +0000
Message-ID: <20101112144003.GE17283@rakim.wolfsonmicro.main>
References: <1289553806-28625-1-git-send-email-jhnikula@gmail.com>
	<1289553806-28625-3-git-send-email-jhnikula@gmail.com>
	<20101112131840.GB17283@rakim.wolfsonmicro.main>
	<20101112155756.bd8a95be.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 415FE10395C
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 15:40:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20101112155756.bd8a95be.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 12, 2010 at 03:57:56PM +0200, Jarkko Nikula wrote:
> Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > If we keep moving stuff into the card it's questionable what the context
> > is buying us...

> DAPM context represent the parent device (codecs currently and other
> devices in someday) and its state so I don't see we'll be removing it in
> near future even now the widgets and paths are moved to card.

Yeah, but as we keep reducing the amount of per-device state we hold
that could eventually go down to zero - we keep on looking at things
and deciding they're better managed over the whole card.
