From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add max98088 CODEC driver
Date: Wed, 22 Sep 2010 11:38:07 +0100
Message-ID: <20100922103806.GC22361@opensource.wolfsonmicro.com>
References: <B2150E1E4418E1438554A300EA5040E40D469C123B@ITSVLEX06.it.maxim-ic.internal>
	<20100901111432.GE17548@opensource.wolfsonmicro.com>
	<B2150E1E4418E1438554A300EA5040E40D46A5BB13@ITSVLEX06.it.maxim-ic.internal>
	<20100903101721.GE16587@rakim.wolfsonmicro.main>
	<B2150E1E4418E1438554A300EA5040E40D46E1B8E7@ITSVLEX06.it.maxim-ic.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9CDBF1038CC
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Sep 2010 12:37:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <B2150E1E4418E1438554A300EA5040E40D46E1B8E7@ITSVLEX06.it.maxim-ic.internal>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Hsiang <Peter.Hsiang@maxim-ic.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Joonyoung Shim <jy0922.shim@samsung.com>, Takashi Iwai <tiwai@suse.de>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jesse Marroquin <Jesse.Marroquin@maxim-ic.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 21, 2010 at 07:49:30PM -0700, Peter Hsiang wrote:
> On Fri, Sep 03, 2010, Mark Brown wrote:

> > No, you should use the features of the current kernel.  For your
> > backport you can do things like supply soc-cache.c as well.

> The soc-cache.c in the latest kernel-next version supports codecs
> with volatile registers in 16 bit mode, but not for the 8 bit mode.
> See snd_soc_8_8_write.

> The source code comments confirmed this:
> "Note at present this code can not be used by CODECs with 
> volatile registers."  

> For this codec (with volatile registers), should we use the read
> and write functions in the codec driver until the 8-bit mode is
> supported by Linux soc-cache.c?

You should modify soc-cache.c to support volatile registers if you need
this; it's not been implemented because nobody needed it yet (someone
may get to it before you get round to resubmitting, but if they haven't
then just extend the core functionality).
