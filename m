From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] sound/soc: rename vol to volatile_register
 as appropriate
Date: Wed, 13 Oct 2010 16:29:17 +0100
Message-ID: <20101013152916.GA20270@rakim.wolfsonmicro.main>
References: <B2150E1E4418E1438554A300EA5040E40D469C124D@ITSVLEX06.it.maxim-ic.internal>
	<B2150E1E4418E1438554A300EA5040E40D469C124F@ITSVLEX06.it.maxim-ic.internal>
	<1286934472.1117.129.camel@Joe-Laptop>
	<20101013082414.GD6424@rakim.wolfsonmicro.main>
	<1286971846.1117.191.camel@Joe-Laptop>
	<20101013123301.GL6424@rakim.wolfsonmicro.main>
	<1286974549.1117.254.camel@Joe-Laptop>
	<20101013151117.GM6424@rakim.wolfsonmicro.main>
	<1286983667.1117.347.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B3C6A24441
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Oct 2010 17:29:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1286983667.1117.347.camel@Joe-Laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joe Perches <joe@perches.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Hsiang <Peter.Hsiang@maxim-ic.com>, Jesse Marroquin <Jesse.Marroquin@maxim-ic.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 13, 2010 at 08:27:47AM -0700, Joe Perches wrote:
> On Wed, 2010-10-13 at 16:11 +0100, Mark Brown wrote:

> > If you check the code again you will notice that these functons are all
> > used in ops structures which presents obvious issues when trying to
> > replace with open coded checks.
> > I hope their usefulness is clear given the above.

> There is some value in using consistent
> function styles for table driven and non-table
> driven instances.

I'm sorry, I don't understand what you are saying here.  What do you
believe to be inconsistent?
