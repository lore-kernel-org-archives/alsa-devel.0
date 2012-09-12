From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/5] arch/powerpc/boot/dts pcm030 add
 mpc5200-soc-audio node
Date: Wed, 12 Sep 2012 11:17:20 +0800
Message-ID: <20120912031719.GH9162@opensource.wolfsonmicro.com>
References: <1347416089-23393-1-git-send-email-emillbrandt@dekaresearch.com>
 <1347416089-23393-5-git-send-email-emillbrandt@dekaresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 335772615EE
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 05:17:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1347416089-23393-5-git-send-email-emillbrandt@dekaresearch.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 11, 2012 at 10:14:48PM -0400, Eric Millbrandt wrote:

> +		analog@0 {
> +			stream-name = "AC97 Analog";
> +			codec-name = "wm9712-codec.0";

This name is fairly clearly an internal implementation detail of how
Linux does audio drivers, we shouldn't be using it in device tree
bindings.  We should instead be doing something like referencing a
device tree node for the CODEC.  Look at how drivers like the nVidia
Tegra ones handle this, though for AC'97 we should really be able to
figure out a standard hookup like this automatically at runtime, it's
all enumerable.
