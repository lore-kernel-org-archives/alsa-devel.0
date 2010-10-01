From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: user space control app driver interface for sound
 soc
Date: Fri, 1 Oct 2010 10:35:35 -0700
Message-ID: <20101001173534.GA21157@opensource.wolfsonmicro.com>
References: <20100930203118.GA4175@opensource.wolfsonmicro.com>
	<B2150E1E4418E1438554A300EA5040E40D46F92A44@ITSVLEX06.it.maxim-ic.internal>
	<20100930220953.GF4175@opensource.wolfsonmicro.com>
	<B2150E1E4418E1438554A300EA5040E40D46F92A90@ITSVLEX06.it.maxim-ic.internal>
	<20100930233453.GH4175@opensource.wolfsonmicro.com>
	<B2150E1E4418E1438554A300EA5040E40D46F92B44@ITSVLEX06.it.maxim-ic.internal>
	<20101001023728.GK4175@opensource.wolfsonmicro.com>
	<4CA58619.2090408@ladisch.de>
	<20101001071233.GB20529@opensource.wolfsonmicro.com>
	<s5hr5gaqba8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A3CE4103805
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 19:35:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hr5gaqba8.wl%tiwai@suse.de>
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
Cc: Peter Hsiang <Peter.Hsiang@maxim-ic.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 01, 2010 at 03:42:55PM +0200, Takashi Iwai wrote:

> FWIW, if it's an EQ band coef data or such small and more-or-less safe
> data, you can create even a dedicated ALSA control element to
> read/write the byte array.  For example, SPDIF status bits are
> transferred in that way between the driver and the user-space.

Though in the embedded case platform data often ends up being idomatic
since many of the typical uses revolve around tuning things for physical
properties of the platform.
