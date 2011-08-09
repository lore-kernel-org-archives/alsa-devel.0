From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix SPI driver binding for WM8987
Date: Wed, 10 Aug 2011 00:31:37 +0900
Message-ID: <20110809153136.GH15861@opensource.wolfsonmicro.com>
References: <1312362661-4544-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4E41253E.2040407@ti.com>
	<20110809150503.GE15861@opensource.wolfsonmicro.com>
	<4E415204.8020702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 251CA24478
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Aug 2011 17:31:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E415204.8020702@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 09, 2011 at 04:28:04PM +0100, Liam Girdwood wrote:
> On 09/08/11 16:05, Mark Brown wrote:

> > Hrm?  Subject line says WM8987...

> But the diff said WM8750 iirc.

The issue being fixed is that the two devices are register compatible
but for SPI we were only registering a device ID for wm8750, for I2C
we'd got both IDs registered.  The driver says wm8750 everywhere except
the device IDs.
