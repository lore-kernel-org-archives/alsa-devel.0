From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: Add device tree binding description
 for pcm030-audio-fabric
Date: Mon, 24 Sep 2012 16:54:30 -0600
Message-ID: <5060E4A6.2050204@wwwdotorg.org>
References: <1348525194-14687-1-git-send-email-emillbrandt@dekaresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 92DC22616D7
 for <alsa-devel@alsa-project.org>; Tue, 25 Sep 2012 00:54:34 +0200 (CEST)
In-Reply-To: <1348525194-14687-1-git-send-email-emillbrandt@dekaresearch.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 09/24/2012 04:19 PM, Eric Millbrandt wrote:
> Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>

> +++ b/Documentation/devicetree/bindings/sound/pcm030-audio-fabric.txt
> @@ -0,0 +1,12 @@
> +Phytec pcm030 audio
> +
> +Required properties:
> +- compatible : "phytec,pcm030-audio-fabric"
> +- asoc-platform : The mpc5200 controller's phandle for the ac97 controller

That's not a good property name; ASoC is AFAIK a Linux-specific term,
and DT bindings are supposed to be OS-agnostic. Perhaps
"ac97-controller" would be better?
