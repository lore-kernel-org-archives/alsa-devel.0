From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] ASoC: Add WM8903 CODEC driver
Date: Tue, 26 Aug 2008 15:44:04 +0200
Message-ID: <20080826154404.3f24d0c1@hyperion.delvare>
References: <1219752327-5704-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20080826152856.01187982@hyperion.delvare>
	<s5hiqtnq4md.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C8B410383C
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Aug 2008 15:44:10 +0200 (CEST)
In-Reply-To: <s5hiqtnq4md.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On Tue, 26 Aug 2008 15:37:30 +0200, Takashi Iwai wrote:
> At Tue, 26 Aug 2008 15:28:56 +0200,
> Jean Delvare wrote:
> > On Tue, 26 Aug 2008 13:05:27 +0100, Mark Brown wrote:
> > > +	if (ret != 0) {
> > > +		dev_err(&pdev->dev, "can't add i2c driver");
> > 
> > Missing \n at end of string (looks like many other drivers have this
> > problem - I found 11 other cases under sound/soc, I can send a patch
> > fixing these if you want.)
> 
> It'd be appreciated.  If Mark didn't work on it yet, I'll merge them.

Incidentally, I am working on converting almost all the affected
drivers to the new i2c device driver binding model, and my conversion
changes that part of the code. So in order to avoid useless conflicts,
I'd rather not touch that part of the code in a separate patch. My
conversion patches will fix the strings as a side effect anyway.

I'll send a patch with 2 fixes affecting the drivers I am not going to
touch, so that these fixes aren't lost.

-- 
Jean Delvare
