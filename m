From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: Configure pin muxing via
 pinctrl when registering a DAI
Date: Tue, 25 Sep 2012 13:24:56 +0100
Message-ID: <20120925122456.GF4428@opensource.wolfsonmicro.com>
References: <505C9496.1050307@wwwdotorg.org>
 <20120922152840.GM4495@opensource.wolfsonmicro.com>
 <505E80AD.9050000@wwwdotorg.org>
 <CACRpkdbewb0SVYJoT9O4PAajFWny+YOcmf2CLUKL1NzxGWoa5A@mail.gmail.com>
 <20120924101757.GC21375@opensource.wolfsonmicro.com>
 <CACRpkdZKL62n02maO7CJ4Q1mNFW+=nTFOF1CWcs3b1Od3mGBbg@mail.gmail.com>
 <20120925111146.GC4428@opensource.wolfsonmicro.com>
 <50619467.3040203@ti.com>
 <20120925114352.GE4428@opensource.wolfsonmicro.com>
 <CACRpkdb3yA9Ued8nv59K+ct4BKmn2k53QXB16qTzQ21t2nvrhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 32329261718
 for <alsa-devel@alsa-project.org>; Tue, 25 Sep 2012 14:24:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CACRpkdb3yA9Ued8nv59K+ct4BKmn2k53QXB16qTzQ21t2nvrhA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 25, 2012 at 01:56:13PM +0200, Linus Walleij wrote:

> In ux500 drivers we use *specific* (as opposed to generic) runtime PM
> code to e.g. get some hysteresis before a drivers clock and pins
> (etc) are put to sleep. Pure driver business.

Right, the runtime PM infrastructure is really useful for this stuff.

> >  Devices that can be wake sources are an example here, if they
> > are doing that then turning them completely off may break functionality
> > but you can still turn some of the device (possibly a varying selection
> > depending on usage) off.  For simple cases it works well and it'd be
> > good to have it but you end up back into ignoring errors...

> Our ux500 "sleep" state on the pins will put them into the apropriate
> wakeup mode where applicable. Since this may vary across boards
> it's even machine-specific.

> Configuring wakeup sources when going to a state named "sleep"
> seems intuitive to me atleast.

For some devices the set of wakeup sources vary depending on the current
system state - for example, if a cable is plugged into a connector we
may have to keep some additional things on to monitor activity on the
cable.  This isn't the common case, for most things a sleep state works
fine, but it does come up.
