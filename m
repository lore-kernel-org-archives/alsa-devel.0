From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Need general idea how to architect driver for
 multi-codec board
Date: Sat, 28 May 2011 09:34:16 +0800
Message-ID: <20110528013355.GD5971@opensource.wolfsonmicro.com>
References: <BANLkTi=Fi_4nCP7A3Jd9C=4N_FTijOwGdw@mail.gmail.com>
	<20110511175021.GB22798@sirena.org.uk>
	<BANLkTi=arRRqPEDS9S=-ynM_1d8N_A=d+w@mail.gmail.com>
	<20110527012756.GA26768@sirena.org.uk>
	<BANLkTinM_MigPxzY4WCBZhjRPwuV15b9gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7BB0424435
	for <alsa-devel@alsa-project.org>;
	Sat, 28 May 2011 18:44:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTinM_MigPxzY4WCBZhjRPwuV15b9gQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, May 27, 2011 at 02:36:58PM -0700, Caleb Crome wrote:

> However, I'm still having problems getting the system set up with more than
> 2 channels.  the rx51 and speyside don't quite do the same thing as far as I
> can tell:  the rx51 is close -- it very nearly brings up the 'b' codec in
> the aic34, but I don't see how the TDM is set -- it appears to still be a
> stereo configuration.

There's an API for configuring TDM - snd_soc_dai_set_tdm slot.

> Do I need multiple snd_soc_dai_links when configuring?  In hw_params, I only

Yes, you will.  Or invent a new interface.  The current APIs provide
point to point links between interfaces.  If you're trying to do
something different then you'll need to extend the core to support what
you need.

> seem to get 1 codec dai_link, so I can't set the TDM slots there.

What makes you say that?

> Or are the extra codecs in the daisy chain considered 'aux' devices?  I

No.  aux devices have no digital links.  In addition to looking at the
existing code you'll also find a lot of background information if you
look through the revision control history...
