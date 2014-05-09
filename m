From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v4 2/5] ASoC: Move standard kcontrol
 helpers to the component level
Date: Fri, 9 May 2014 23:00:37 +0800
Message-ID: <20140509150034.GH2870@dragon>
References: <1398165797-22997-1-git-send-email-lars@metafoo.de>
 <1398165797-22997-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0238.outbound.protection.outlook.com [207.46.163.238])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EA1B261A5A
 for <alsa-devel@alsa-project.org>; Fri,  9 May 2014 17:00:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1398165797-22997-3-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Lars,

On Tue, Apr 22, 2014 at 01:23:14PM +0200, Lars-Peter Clausen wrote:
> After moving the IO layer inside ASoC to the component level we can now easily
> move the standard control helpers also to the component level. This allows to
> reuse the same standard helper control implementations for other components.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

I'm running next-20140508 on imx6q-sabresd board and seeing repeated
'amixer: Mixer hw:0 load error: Device or resource busy' message with
Debian wheezy rootfs.  The git bisect points me to this patch.

== message output before this patch ==

[....] Setting up ALSA...warning: 'alsactl restore' failed with error message 'Found hardware: "wm8962-audio" "" "" "" ""
Hardware is initialized using a generic method
[ ok tl: set_control:1328: failed to obtain info for control #117 (No such file or directory)'...done.

== message output after this patch ==

[....] Setting up ALSA...warning: 'alsactl restore' failed with error message 'Found hardware: "wm8962-audio" "" "" "" ""
Hardware is initialized using a generic method
alsactl: set_control:1328: failed to obtain info for control #117 (No such file or directory)'...amixer: Mixer hw:0 load error: Device or resource busy
amixer: Mixer hw:0 load error: Device or resource busy
amixer: Mixer hw:0 load error: Device or resource busy
amixer: Mixer hw:0 load error: Device or resource busy
amixer: Mixer hw:0 load error: Device or resource busy
amixer: Mixer hw:0 load error: Device or resource busy
amixer: Mixer hw:0 load error: Device or resource busy
amixer: Mixer hw:0 load error: Device or resource busy
amixer: Mixer hw:0 load error: Device or resource busy
amixer: Mixer hw:0 load error: Device or resource busy
amixer: Mixer hw:0 load error: Device or resource busy
amixer: Mixer hw:0 load error: Device or resource busy
amixer: Mixer hw:0 load error: Device or resource busy
amixer: Mixer hw:0 load error: Device or resource busy
amixer: Mixer hw:0 load error: Device or resource busy
amixer: Mixer hw:0 load error: Device or resource busy
amixer: Mixer hw:0 load error: Device or resource busy
amixer: Mixer hw:0 load error: Device or resource busy
amixer: Mixer hw:0 load error: Device or resource busy
amixer: Mixer hw:0 load error: Device or resource busy
amixer: Mixer hw:0 load error: Device or resource busy
amixer: Mixer hw:0 load error: Device or resource busy
amixer: Mixer hw:0 load error: Device or resource busy
amixer: Mixer hw:0 load error: Device or resource busy
amixer: Mixer hw:0 load error: Device or resource busy
amixer: Mixer hw:0 load error: Device or resource busy
amixer: Mixer hw:0 load error: Device or resource busy
amixer: Mixer hw:0 load error: Device or resource busy
amixer: Mixer hw:0 load error: Device or resource busy
amixer: Mixer hw:0 load error: Device or resource busy
amixer: Mixer hw:0 load error: Device or resource busy
amixer: Mixer hw:0 load error: Device or resource busy
amixer: Mixer hw:0 load error: Device or resource busy
amixer: Mixer hw:0 load error: Device or resource busy
amixer: Mixer hw:0 load error: Device or resource busy
amixer: Mixer hw:0 load error: Device or resource busy
amixer: Mixer hw:0 load error: Device or resource busy
done.

Why do we start seeing such error message with your patch?  Is this
a problem of rootfs or kernel?

Shawn
