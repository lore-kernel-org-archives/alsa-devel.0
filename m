From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ALSA: ASoC: add DT bindings for cs4270
Date: Tue, 24 Jul 2012 23:44:40 +0100
Message-ID: <20120724224440.GD1767@opensource.wolfsonmicro.com>
References: <1343161248-27557-1-git-send-email-zonque@gmail.com>
 <500F0407.8090807@freescale.com> <500F050D.6080505@gmail.com>
 <500F05CC.2000105@freescale.com> <500F1B05.3050107@wwwdotorg.org>
 <500F1BB7.7020504@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C7FEF265DAC
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2012 00:44:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <500F1BB7.7020504@freescale.com>
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

On Tue, Jul 24, 2012 at 05:03:35PM -0500, Timur Tabi wrote:
> Stephen Warren wrote:
> > The I2C code matches the compatible values from the device tree against
> > two tables in the kernel. First, the of_match_table that this patch
> > adds, and then if there's no match it falls back to the I2C device ID
> > table, and matches that against the DT compatible value with the vendor
> > prefix stripped off.

> > So while the second method does work as a fall-back, in the past I've
> > received guidance (I think from Grant Likely) that we should still add
> > the of_match_table to drivers in order to be explicit.

> So you're saying that all I2C device drivers should have an

It's certainly better to add one, it avoids any ambiguity in part
numbers (there's at least one other chip vendor (Wondermedia) using wm
for example).

> of_match_table()?  If so, then we should probably fix all codec drivers in
> one patch.

Meh, it's fine doing it piecemeal really.  It's hardly urgent anyway.
