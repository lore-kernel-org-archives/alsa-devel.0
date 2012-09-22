From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: Configure pin muxing via
 pinctrl when registering a DAI
Date: Sat, 22 Sep 2012 11:28:41 -0400
Message-ID: <20120922152840.GM4495@opensource.wolfsonmicro.com>
References: <1348214066-28384-1-git-send-email-peter.ujfalusi@ti.com>
 <20120921111352.GA21524@opensource.wolfsonmicro.com>
 <505C68AA.7080907@ti.com> <505C9496.1050307@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AFED6261651
 for <alsa-devel@alsa-project.org>; Sat, 22 Sep 2012 17:28:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <505C9496.1050307@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 21, 2012 at 10:23:50AM -0600, Stephen Warren wrote:
> On 09/21/2012 07:16 AM, Peter Ujfalusi wrote:

> > pinctrl_get_select() returns with a pointer to struct pinctrl. If the platform
> > does not have CONFIG_PINCTRL enabled it will return with NULL.
> > If no pinctrl has been specified for the device it will return with error
> > (-ENODEV).
> > Neither of these cases should be considered as error. We do print out with
> > dev_info() to notify the developer, but having pinctrl mux should not be
> > mandatory.

> Indeed - what about a platform like Tegra which has pinctrl enabled, yet
> doesn't specify any pinctrl configuration for any device other than the
> pin controller itself? Do we want to force every device into having to
> specify an empty pin control configuration? If we take this route, we
> should really have the driver core or platform bus set up the initial
> pinctrl state, and I believe that approach was explicitly decided against.

Well, the other options are for pinctrl to either not return an error in
the no configuration case or change to a void return type.  The current
behaviour seems a bit pointless since we can't usefully do anything with
the errors, we can just factor the error logs into the core and have
done with it since it's not possible to treat errors as such.
