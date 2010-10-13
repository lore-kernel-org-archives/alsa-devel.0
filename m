From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add max98088 CODEC driver
Date: Wed, 13 Oct 2010 09:24:14 +0100
Message-ID: <20101013082414.GD6424@rakim.wolfsonmicro.main>
References: <B2150E1E4418E1438554A300EA5040E40D469C124D@ITSVLEX06.it.maxim-ic.internal>
	<B2150E1E4418E1438554A300EA5040E40D469C124F@ITSVLEX06.it.maxim-ic.internal>
	<1286934472.1117.129.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 644B2103856
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Oct 2010 10:24:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1286934472.1117.129.camel@Joe-Laptop>
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

On Tue, Oct 12, 2010 at 06:47:52PM -0700, Joe Perches wrote:
> On Tue, 2010-10-12 at 18:20 -0700, Peter Hsiang wrote:

> > +static struct {
> > +       int readable;
> > +       int writable;
> > +       int vol;
> > +} max98088_access[M98088_REG_CNT] = {

> bool instead?

> static struct {
> 	bool readable;
> 	bool writable,
> 	bool vol;
> } etc...

The readable and writable fields are being used as bitmasks:

| +       { 0x1F, 0x1F, 1 }, /* 03 battery voltage */

so this discards data which we may wish to use in future.

> readable isn't used anywhere, writeable is used as bool
> vol isn't a good name as it's easy to confuse with
> volume.  Maybe volatile_register?

vol is traditionally used for this throughout the subsystem.  It's
unfortuante that volatile is a keyword.
