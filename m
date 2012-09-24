From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: Configure pin muxing
	via	pinctrl when registering a DAI
Date: Mon, 24 Sep 2012 11:23:11 +0100
Message-ID: <20120924102311.GD21375@opensource.wolfsonmicro.com>
References: <1348214066-28384-1-git-send-email-peter.ujfalusi@ti.com>
 <20120921111352.GA21524@opensource.wolfsonmicro.com>
 <505C68AA.7080907@ti.com> <505C9496.1050307@wwwdotorg.org>
 <CACRpkdZ=_qm-g-LDth8m43Cug4LoMsD3FuvTiiyQgP=chGTAUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4455F260376
 for <alsa-devel@alsa-project.org>; Mon, 24 Sep 2012 12:23:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CACRpkdZ=_qm-g-LDth8m43Cug4LoMsD3FuvTiiyQgP=chGTAUw@mail.gmail.com>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Magnus Damm <magnus.damm@gmail.com>, Liam Girdwood <lrg@ti.com>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 24, 2012 at 10:34:50AM +0200, Linus Walleij wrote:

> (I think someone could attempt to do the same thing with regulators
> with the same centralization failure, we know regulator voltages
> need to be switched at runtime, take an SD card and centralized
> regulators breaks apart immediately.)

It's also not terribly tractable because idle states don't mean power
off, between retention and wake sources there's far too many
execeptions.
