From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Ensure output PGA is enabled for
 line outputs in wm_hubs
Date: Sun, 15 May 2011 08:45:23 -0700
Message-ID: <20110515154522.GB26637@opensource.wolfsonmicro.com>
References: <1305434515-26515-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<201105151336.22324.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EAFD424386
	for <alsa-devel@alsa-project.org>;
	Sun, 15 May 2011 17:45:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201105151336.22324.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, May 15, 2011 at 01:36:22PM +0100, Alan Horstmann wrote:
> On Sunday 15 May 2011 05:41, Mark Brown wrote:

> > -	{ "LINEOUT2N Mixer", "Left Output Switch", "Left Output Mixer" },
> > -	{ "LINEOUT2N Mixer", "Right Output Switch", "Left Output Mixer" },
> > +	{ "LINEOUT2N Mixer", "Left Output Switch", "Left Output PGA" },
> > +	{ "LINEOUT2N Mixer", "Right Output Switch", "Left Output PGA" },

> Is this also left/right typo?

Yes, thanks.
