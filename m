From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ALSA: ASoC: add DT bindings for cs4270
Date: Tue, 24 Jul 2012 23:41:19 +0100
Message-ID: <20120724224119.GB1767@opensource.wolfsonmicro.com>
References: <1343161248-27557-1-git-send-email-zonque@gmail.com>
 <500F0407.8090807@freescale.com> <500F050D.6080505@gmail.com>
 <500F05CC.2000105@freescale.com> <500F0666.3030707@gmail.com>
 <500F07F9.8000408@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9C46B265DAC
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2012 00:46:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <500F07F9.8000408@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 24, 2012 at 03:39:21PM -0500, Timur Tabi wrote:
> Daniel Mack wrote:

> > And are you ok with the 2nd patch?

...which requires the first one anyway.

> Isn't that something that should be done in platform code?  It seems very
> platform-specific for a codec driver.  I have no problem using the CS4270
> on my board, and I don't need this feature.

Using a reset signal on the CODEC isn't at all platform specific - it's
something the device itself supports so I'd expect the driver for the
device to support it so it can be joined up with it for register I/O and
so on, besides there's not really anywhere else to put it in the DT.
