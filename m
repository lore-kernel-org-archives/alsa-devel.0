From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8960: Support shared LRCLK
Date: Fri, 14 Sep 2012 16:50:10 +0100
Message-ID: <20120914155008.GA4684@opensource.wolfsonmicro.com>
References: <1347508108-24248-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <50522A5A.10006@freescale.com> <50525F2C.4080607@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C413C265CC1
 for <alsa-devel@alsa-project.org>; Fri, 14 Sep 2012 17:56:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <50525F2C.4080607@freescale.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 13, 2012 at 05:33:16PM -0500, Timur Tabi wrote:

> On the #alsa-soc, I was told that I could force on the control in my
> machine driver.  Specifically, I was told this:

> 	"in your board file you can always make an always on output in the DAPM map"

> Can you tell me how to do this?  Is there an example?  I don't want to
> have to rely on user-space configuration to get playback to work.

You can't force controls on in your machine driver.  DAPM controls only
affect routing so I'm really not sure what you're looking for here.

The advice you were given on the ASoC channel was to add a new widget
in your board that's always connected to the DAC, just define some
random output widget.
