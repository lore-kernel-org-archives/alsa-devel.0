From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v4] ASoC: twl6040: Add ramp up/down volume
 for HS and HF
Date: Thu, 16 Dec 2010 13:45:15 +0000
Message-ID: <1292507115.3285.3.camel@odin>
References: <AANLkTikkc_bTbEtW=_NUL6OLRR5ev0DcR3xKf-GdZ4z=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 906D624447
	for <alsa-devel@alsa-project.org>; Thu, 16 Dec 2010 14:45:20 +0100 (CET)
Received: by wyi11 with SMTP id 11so2542925wyi.38
	for <alsa-devel@alsa-project.org>; Thu, 16 Dec 2010 05:45:20 -0800 (PST)
In-Reply-To: <AANLkTikkc_bTbEtW=_NUL6OLRR5ev0DcR3xKf-GdZ4z=@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Margarita Olaya <magi.oc@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-12-15 at 17:20 -0600, Margarita Olaya wrote:
> From: Margarita Olaya Cabrera <magi.olaya@ti.com>
> 
> Add ramp functions for the headset and handsfree outputs
> in order to reduce the pops during power on/off sequences.
> 
> In order to give more control to volume ramp, step size and delay
> between steps can be specified.
> 
> The patches are based on wm8350 implementation from Liam
> Girdwood.
> 
> Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
> Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/twl6040.c |  533 +++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 521 insertions(+), 12 deletions(-)
> 

Now applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
