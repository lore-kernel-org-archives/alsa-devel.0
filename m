From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: dt: Move WM8903 pin list from Tegra
 board binding to CODEC binding
Date: Wed, 07 Aug 2013 10:02:12 -0600
Message-ID: <52026F84.5030204@wwwdotorg.org>
References: <1375866978-14726-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id DE7702617AB
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2013 18:02:17 +0200 (CEST)
In-Reply-To: <1375866978-14726-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 08/07/2013 03:16 AM, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> The pin list is the same for any board using the CODEC.

> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt

>    the second being the connection's source. Valid names for sources and
...
> +  sinks are the WM8903's pins (documented in the WM8903 binding document),
> +  and the jacks on the board:
>  
>    Board connectors:

Probably want to remove the line "Board connectors:" ?

> diff --git a/Documentation/devicetree/bindings/sound/wm8903.txt b/Documentation/devicetree/bindings/sound/wm8903.txt

> +Pins on the device (for linking into audio routes):
> +
> +  * IN1L
> +  * IN1R

I thought all the pins were going to be assigned numbers too so that
bindings could use either?
