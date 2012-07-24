From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ALSA: ASoC: add DT bindings for cs4270
Date: Tue, 24 Jul 2012 23:42:27 +0100
Message-ID: <20120724224227.GC1767@opensource.wolfsonmicro.com>
References: <1343161248-27557-1-git-send-email-zonque@gmail.com>
 <500F0407.8090807@freescale.com> <500F050D.6080505@gmail.com>
 <500F05CC.2000105@freescale.com> <500F0666.3030707@gmail.com>
 <500F07F9.8000408@freescale.com> <500F1B3E.1070804@wwwdotorg.org>
 <500F1B7B.1070602@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8E123265DAB
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2012 00:42:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <500F1B7B.1070602@freescale.com>
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
Cc: alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>, lrg@ti.com, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 24, 2012 at 05:02:35PM -0500, Timur Tabi wrote:
> Stephen Warren wrote:

> > Perhaps your board permanently ties the reset line to de-asserted, or
> > the bootloader/... deasserts the codecs reset pin before the kernel boots?

> Probably.  We have a pretty sophisticate FPGA on our reference boards that
> handles a lot of stuff like this.

More likely it's just tied to whichever of ground or a supply holds the
device out of reset, if it's the FPGA I'd expect you to have runtime
control of it.
