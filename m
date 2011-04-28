From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/7] ASoC: DAPM: Pass snd_dapm_soc_update
	as parameter
Date: Thu, 28 Apr 2011 22:48:18 +0100
Message-ID: <20110428214817.GA19535@opensource.wolfsonmicro.com>
References: <1304009173-5786-1-git-send-email-lars@metafoo.de>
	<1304009173-5786-2-git-send-email-lars@metafoo.de>
	<20110428194054.GB16837@opensource.wolfsonmicro.com>
	<4DB9D06C.5090006@metafoo.de>
	<20110428205827.GA18350@opensource.wolfsonmicro.com>
	<4DB9DB16.1060507@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A44FB243F0
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Apr 2011 23:48:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DB9DB16.1060507@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 28, 2011 at 11:24:38PM +0200, Lars-Peter Clausen wrote:

> Hm. I won't argue to death here. I could only repeat what I've said before.
> But if we keep passing it indirectly we should at least make the struct opaque
> to the world outside of soc-dapm and move the update pointer from
> snd_soc_dapm_context to snd_soc_card.

Moving to the card doesn't seem helpful, while we're currently doing one
update at once it's not immediately obvious that we want to keep doing
that indefinitely.  Like I've said before with the stream events it's
not clear that we should still be using them any more, IIRC there's only
one user which actually cares (tlv320dac33) and that would probably be
perfectly happy with using events on an AIF widget.
