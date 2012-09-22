From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: Configure pin muxing via
 pinctrl when registering a DAI
Date: Sat, 22 Sep 2012 11:18:36 -0400
Message-ID: <20120922151835.GI4495@opensource.wolfsonmicro.com>
References: <1348214066-28384-1-git-send-email-peter.ujfalusi@ti.com>
 <20120921111352.GA21524@opensource.wolfsonmicro.com>
 <505C68AA.7080907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 277BA261647
 for <alsa-devel@alsa-project.org>; Sat, 22 Sep 2012 17:18:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <505C68AA.7080907@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 21, 2012 at 04:16:26PM +0300, Peter Ujfalusi wrote:
> On 09/21/2012 02:13 PM, Mark Brown wrote:
> > On Fri, Sep 21, 2012 at 10:54:26AM +0300, Peter Ujfalusi wrote:

> >> pinctrl framework now becoming widely available for SoCs to configure pin
> >> multiplexing.
> >> Instead of adding the same code to all dai drivers the core can take care
> >> of this transparently.
> >> Do not make too much noise if pinctrl is not provided via DT for the dai
> >> but just use dev_info().

> > Please fix your word wrapping, I've mentioned this to you before...

> I'll reformat it. BTW: The text is edited so it fits in the 'Commit Message'
> part of git gui.

The line length is perfectly fine, it's the fact that you appear to
start each sentence on a new line so we end up with line lengths
alternating between normal and extremely short within paragraphs - just
look at the above.  It's doing absolutely nothing for legibility and
it's a constant thing.

> > It also seems bad that we're ignoring errors, does the pinctl API not
> > stub itself out well enough.

> pinctrl_get_select() returns with a pointer to struct pinctrl. If the platform
> does not have CONFIG_PINCTRL enabled it will return with NULL.
> If no pinctrl has been specified for the device it will return with error
> (-ENODEV).
> Neither of these cases should be considered as error. We do print out with
> dev_info() to notify the developer, but having pinctrl mux should not be
> mandatory.

So then why is pinctrl returning errors in the first place if the
sensible thing to do is just ignore them?
