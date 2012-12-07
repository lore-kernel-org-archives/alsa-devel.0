From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: I would like to resubmit an ALSA device driver for
 the Maxim 98090 Codec...
Date: Fri, 7 Dec 2012 12:01:59 +0900
Message-ID: <20121207030158.GA26070@opensource.wolfsonmicro.com>
References: <A453F1AE3B5DC14DB19666C506CE75A7108684F245@ITSVLEX06.it.maxim-ic.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 73B5D261742
 for <alsa-devel@alsa-project.org>; Fri,  7 Dec 2012 04:02:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <A453F1AE3B5DC14DB19666C506CE75A7108684F245@ITSVLEX06.it.maxim-ic.internal>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jerry Wong <Jerry.Wong@maximintegrated.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 06, 2012 at 05:14:50PM -0800, Jerry Wong wrote:

> Here is the resubmission of the sound/soc/max98090.c driver with the changes you suggested including regmap I/O and some stylistic updates.

Please fix your mailer to word wrap within paragraphs.  Please also
follow the submission procedure in SubmittingPatches, as previously
mentioned this is essential especially the Signed-off-by bit.  I really
can't apply or even properly review something that doesn't follow that.

Looking at the code you want to check the register defaults - defaults
for volatile registers don't make a huge amount of sense.  

For the ranges based on bases use ... or if (else) rather than listing
the individual registers by hand.

For the custom get and sets I can't see why you're not able to use
generic controls, if you aren't there's enough of these that you should
add a generic type.

Gains should always be volume controls with TLV, enable/disable stuff
should be Switch and controls called Gain Volume don't make a lot of
sense (just Volume).

Prints that just log the build time aren't helpful, you'll notice no
other mainline drivers do that...  there's already a kernel level build
time.  Similarly other stuff like interrupt numbers that are getting
logged are a bit noisy.

Build time options for things like performance need to be made runtime
or platform data based.

Are you sure you want the bandgap reference running the entire time the
system is powered up?
