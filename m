From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ASoC: pxa2xx-i2s
Date: Wed, 21 Jan 2009 19:32:33 +0000
Message-ID: <20090121193230.GA15911@sirena.org.uk>
References: <4975E030.5080905@acdstar.com> <4975F160.8040001@gmail.com>
	<4976042B.6060604@acdstar.com> <49764F15.6080008@acdstar.com>
	<20090121132313.GA29953@sirena.org.uk>
	<49775159.7070708@linespeed.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B0E4243CE
	for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2009 20:32:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <49775159.7070708@linespeed.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brian G Rhodes <bgr@linespeed.net>
Cc: alsa-devel@alsa-project.org, Brian Rhodes <bgr@acdstar.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 21, 2009 at 10:46:17AM -0600, Brian G Rhodes wrote:
> Mark Brown wrote:

> >What is the clock master in your system?

> The master is the i2s controller sysclk.  The dac2x is in slave mode.  
> Though the i2s controller isn't directly supplying the bit clock to the 
> codec in this case.  We're using the PLL on the dac2x.

Just to confirm, the codec is the clock master on the I2S bus itself?
