From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3 3/4] ASoc: kirkwood: add DT support
Date: Sat, 3 Aug 2013 14:51:51 +0100
Message-ID: <20130803135150.GA23006@n2100.arm.linux.org.uk>
References: <20130731081832.54212b76@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 179DB261647
 for <alsa-devel@alsa-project.org>; Sat,  3 Aug 2013 15:52:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130731081832.54212b76@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 31, 2013 at 08:18:32AM +0200, Jean-Francois Moine wrote:
> The kirkwood audio driver is used without DT in the Kirkwood machine.
> This patch adds a DT compatible definition for use in other Marvell
> machines such as the Armada 88AP510 (Dove).
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
>  sound/soc/kirkwood/kirkwood-i2s.c        | 27 ++++++++++++++++------
>  1 file changed, 20 insertions(+), 7 deletions(-)

This misses documentation for the DT conversion.  Documentation should be
created at the same time as a driver is converted.  I think you should
combine patches 3 and 4 together given that you add the documentation and
change the DT compatible name you've given this driver in this patch in
patch 4.
> 
> diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
> index a13fffb..234b5a1 100644
> --- a/sound/soc/kirkwood/kirkwood-i2s.c
> +++ b/sound/soc/kirkwood/kirkwood-i2s.c
> @@ -12,7 +12,6 @@
>  
>  #include <linux/init.h>
>  #include <linux/module.h>
> -#include <linux/platform_device.h>

Why are you getting rid of this include?  It still makes use of platform
devices and the like, so it _should_ continue to include this.  Don't
rely on implicit includes.
