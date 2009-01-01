From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Subject: [PATCH 1/1] set invalid dma channel to -1
	(and	properly check for it) since 0 is not an invalid channel
	but -1 is.
Date: Thu, 1 Jan 2009 11:29:53 +0000
Message-ID: <20090101112951.GA6888@sirena.org.uk>
References: <495BF49B.1000907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 33DE610380C
	for <alsa-devel@alsa-project.org>; Thu,  1 Jan 2009 12:30:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <495BF49B.1000907@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: sware <microcontrolfreak@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, stephen.ware@eqware.net, ALSA project mailing list <alsa-devel@alsa-project.org>, Dennis O'Brien <dennis.obrien@eqware.net>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 31, 2008 at 02:39:23PM -0800, sware wrote:
> Set the invalid dma channel to -1 (and check properly for it) in pxa2xx_pcm_hw_free().
> Was assuming 0 is an invalid channel number but 0 is a valid pxa dma channel num.

> Signed-off-by: stephen <stephen.ware@eqware.net>

Applied, thanks.
