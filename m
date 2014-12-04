From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4/5] ASoC: dwc: Add devicetree support for
	Designware I2S
Date: Thu, 04 Dec 2014 10:55:55 +0100
Message-ID: <2240364.fL8B0EDbFB@wuerfel>
References: <547F3CAC.9050105@arm.com> <2041200.ZjakFFAZAU@wuerfel>
 <20141203201905.GO7712@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by alsa0.perex.cz (Postfix) with ESMTP id BA27E26071B
 for <alsa-devel@alsa-project.org>; Thu,  4 Dec 2014 10:56:02 +0100 (CET)
In-Reply-To: <20141203201905.GO7712@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Andrew Jackson <Andrew.Jackson@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rajeev Kumar <rajeevkumar.linux@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wednesday 03 December 2014 20:19:05 Mark Brown wrote:
> On Wed, Dec 03, 2014 at 09:13:18PM +0100, Arnd Bergmann wrote:
> 
> > I don't think we even have to worry about the platform_data case here:
> > the only platform using this hardware in Linux is arm/mach-spear, and
> > it defines a device node with a binding that is similar to the one you
> > document here but that is not implemented in the driver.
> 
> Not all the world uses DT, this is a DesignWare IP so it's likely to get
> deployed widely - potentially on PCI cards and things like that.

It's not really new though, and we are only seeing the second user.
Maybe this one just isn't as common as a lot of the other designware IP?



	Arnd
