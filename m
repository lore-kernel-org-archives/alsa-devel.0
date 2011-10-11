From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Writing register default value for
 the reset register
Date: Tue, 11 Oct 2011 14:31:18 +0100
Message-ID: <20111011133118.GB3471@opensource.wolfsonmicro.com>
References: <1318326900.3526.2.camel@phoenix>
	<20111011123305.GA2899@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 27D6F1038C4
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Oct 2011 15:31:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20111011123305.GA2899@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: Axel Lin <axel.lin@gmail.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 11, 2011 at 01:33:05PM +0100, Dimitris Papastamos wrote:
> On Tue, Oct 11, 2011 at 05:55:00PM +0800, Axel Lin wrote:
> > The WM8983 can be reset by performing a write of any value to
> > the software reset register.

> > -	ret = snd_soc_write(codec, WM8983_SOFTWARE_RESET, 0x8983);
> > +	ret = snd_soc_write(codec, WM8983_SOFTWARE_RESET, 0);

> We should probably just handle the reset register specially during
> resume.

I really don't think it's worth the code complexity to add special
handling like that, this is a trivial patch which avoids the need for
any extra infrastructure.
