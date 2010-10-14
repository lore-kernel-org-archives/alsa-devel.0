From: Peter Hsiang <Peter.Hsiang@maxim-ic.com>
Subject: Re: [PATCH] ASoC: Add max98088 CODEC driver
Date: Wed, 13 Oct 2010 20:18:44 -0700
Message-ID: <B2150E1E4418E1438554A300EA5040E40D470D7DEA@ITSVLEX06.it.maxim-ic.internal>
References: <B2150E1E4418E1438554A300EA5040E40D469C124D@ITSVLEX06.it.maxim-ic.internal>
	<B2150E1E4418E1438554A300EA5040E40D469C124F@ITSVLEX06.it.maxim-ic.internal>
	<20101013103224.GK6424@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from antispam01.maxim-ic.com (antispam01.maxim-ic.com
	[205.153.101.182])
	by alsa0.perex.cz (Postfix) with ESMTP id CB52610385C
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 05:18:32 +0200 (CEST)
In-Reply-To: <20101013103224.GK6424@rakim.wolfsonmicro.main>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jesse@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Marroquin <Jesse.Marroquin@maxim-ic.com>, Liam@alsa-project.org, Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 13, 2010, Mark Brown wrote:
> On Tue, Oct 12, 2010 at 06:20:10PM -0700, Peter Hsiang wrote:
> 
> This looks pretty good, waiting for Liam's review but I think we can do
> further stuff incrementally.  Minor comments:
> 
> > +
> > +       /* Setup an array of texts for the equalizer enum.
> > +        * This is based on Mark Brown's equalizer driver code.
> > +        * It has been extended to support multiple equalizers.
> > +        */
> 
> The code that you're basing this on supports multiple equalizers too -
> things like the WM8994 have several.  Given that all those supported by
> the original code are identical there didn't seem to be any point in
> restricting which EQ a given setup can be deployed on - it's just one
> more thing that can go wrong.

Thanks - that is a very good idea.  I have implemented it and will
submit it shortly.
