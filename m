From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: WL1273 FM radio: Access I2C
	IO	functions through pointers.
Date: Mon, 17 Jan 2011 15:15:06 +0000
Message-ID: <20110117151502.GB3159@sirena.org.uk>
References: <1294925701.3453.5.camel@odin>
	<1294928273.6390.5.camel@masi.mnp.nokia.com>
	<20110113150113.GC20480@sirena.org.uk>
	<1294935501.6390.44.camel@masi.mnp.nokia.com>
	<20110113171202.GG30351@opensource.wolfsonmicro.com>
	<1294990984.6390.81.camel@masi.mnp.nokia.com>
	<20110114122250.GC20846@opensource.wolfsonmicro.com>
	<1295254346.25951.23.camel@masi.mnp.nokia.com>
	<20110117135634.GB21113@opensource.wolfsonmicro.com>
	<1295276294.25951.54.camel@masi.mnp.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BB33710387E
	for <alsa-devel@alsa-project.org>; Mon, 17 Jan 2011 16:15:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1295276294.25951.54.camel@masi.mnp.nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Cc: alsa-devel@alsa-project.org, sameo@linux.intel.com, ext Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 17, 2011 at 04:58:14PM +0200, Matti J. Aaltonen wrote:
> On Mon, 2011-01-17 at 13:56 +0000, ext Mark Brown wrote:

> -       select SND_SOC_WL1273 if RADIO_WL1273
> +       select SND_SOC_WL1273
>         select SND_SOC_WM2000 if I2C
>         select SND_SOC_WM8350 if MFD_WM8350
>         select SND_SOC_WM8400 if MFD_WM8400

> That way the compilation of the codec would be independent of the rest
> of the driver...

Will the resulting code actually link if the MFD driver hasn't been
built?  Looks like it given that everything looks like hard coded
vtable dereferences and there's no API from the MFD driver to its users.
I'm really unsure what the MFD driver is supposed to do now, it'll only
ever instantiate a single subdevice and offers no services to users - it
seems better to just remove it, it looks like it's just creating
needless complication.

I have to say it looks like the locking at best a bit odd, some of the
APIs require that the CODEC driver lock a lock from the core by hand
while others have no locking in the interface.
