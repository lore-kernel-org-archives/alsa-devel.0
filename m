From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH][ASoC V2] Fix null-pointer dereference
	in	soc_create_pcm()
Date: Wed, 21 May 2008 11:54:26 +0100
Message-ID: <20080521105426.GA26954@rakim.wolfsonmicro.main>
References: <1211237159-26546-1-git-send-email-timur@freescale.com>
	<20080520113130.GA32249@rakim.wolfsonmicro.main>
	<s5hskwcvt8n.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B504C2450C
	for <alsa-devel@alsa-project.org>;
	Wed, 21 May 2008 12:54:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hskwcvt8n.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 21, 2008 at 12:36:40PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > > When soc_create_pcm() finds all four components it needs, it displays a status
> > > message.  This message references the local variables 'codec_dai' and

> This looks applicable to the upstream tree... Shouldn't it be fixed as
> well?

The error condition can't occur in ASoC v1 - it doesn't support the
dynamic registration of machine components so the local codec and CPU
DAI variables must always have been initialised if soc_new_pcm()
succeeds.  It's an issue for v2 because soc_create_pcm() can be called
multiple times if the PCM is registered before all the components
required to create it are registered - if that happens then only the
last component to be added will have had the local variables
initialised.
