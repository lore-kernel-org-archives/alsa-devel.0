From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RESEND] ASoC: omap-abe-twl6040: Add device tree
	support
Date: Wed, 25 Jul 2012 22:48:37 +0100
Message-ID: <20120725214837.GQ3099@opensource.wolfsonmicro.com>
References: <1343221751-29863-1-git-send-email-peter.ujfalusi@ti.com>
 <20120725131507.GM3099@opensource.wolfsonmicro.com>
 <500FF709.9060205@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F3AD4265B44
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2012 23:56:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <500FF709.9060205@ti.com>
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

On Wed, Jul 25, 2012 at 04:39:21PM +0300, Peter Ujfalusi wrote:
> On 07/25/2012 04:15 PM, Mark Brown wrote:

> > We're already in the merge window...

> Yes, I'm aware of that.
> I have sent the v3 on 6.6.2012 to the list [1].
> I just noticed that on my working branch after I have rebased it on mainline
> the omap-abe-twl6040 was not compiling (due to the cpu_dai_of_node rename to
> cpu_of_node). I wanted to send a quick fix for this when I realized that the
> DT support for the machine driver is not taken.

Please just send the build fix with a followup adding the DT bindings
and then we can get the DT bindings in for 3.7.  It's unfortunate that
Liam's been so busy and things like this got dropped on the floor but
I'm not enthusiastic adding something like this after the pull request
went to Linus.

Though obviously it's not even been compiled in mainline :/

In general you need to really start paying attention to this stuff
and start chasing around -rc5 or so.
