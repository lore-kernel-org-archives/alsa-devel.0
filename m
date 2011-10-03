From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/6] ASoC: samsung: wm8994 depends on
	mfd_wm8994
Date: Mon, 3 Oct 2011 15:08:24 +0100
Message-ID: <20111003140824.GM3731@opensource.wolfsonmicro.com>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
	<1869072.QQLATNzYYx@wuerfel> <20111003120741.GD23811@sirena.org.uk>
	<11174515.ANsqIhx0NX@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E79542437D
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Oct 2011 16:08:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <11174515.ANsqIhx0NX@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Sangbeom Kim <sbkim73@samsung.com>, 'Jassi Brar' <jassisinghbrar@gmail.com>, linux-kernel@vger.kernel.org, 'Liam Girdwood' <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 03, 2011 at 03:43:10PM +0200, Arnd Bergmann wrote:

> > You've not sent a seprate patch for that one yet...

> I wasn't sure any more which version you wanted. Is this this right one?

I was expecting something that selects the core.  I was also expecting
something that can be applied against -next which this patch can't be,
this doesn't feel like something we should be rushing into 3.1.
