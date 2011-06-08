From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Something broke in snd_soc_pcm_stream
Date: Wed, 8 Jun 2011 10:05:52 +0100
Message-ID: <20110608090552.GB2828@opensource.wolfsonmicro.com>
References: <4DEE98C8.2010706@freescale.com>
	<20110607214442.GB7712@opensource.wolfsonmicro.com>
	<4DEEA429.6040605@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C0D40103803
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Jun 2011 11:05:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DEEA429.6040605@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 07, 2011 at 05:20:25PM -0500, Timur Tabi wrote:

> It just so happens that on the the P1022, the CPU does support both directions
> in its DAI, but the codec (WM8776) supports only one direction per DAI.  So I
> suspect that you shouldn't be testing codec_dai either, because it assumes that
> the codec is the only arbiter on which direction a given dai-group supports.

Or it just means that unidirectional CPU DAIs are so rare that nobody
got round to adding the check for them.

> Anyway, I changed my driver to test for the actual pointer, and it works.  You
> might want to consider doing the same in soc_pcm_new().

I know we've been round this loop quite a few times in the past but just
to reiterate the situation with Linux is rather different to with other
OSs - you can submit patches to *any* code in Linux, you're not restricted
to only working on your individual driver.
