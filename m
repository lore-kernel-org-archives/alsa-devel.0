From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: Mark WM8962 Additional Control 4
 register as volatile
Date: Thu, 30 Sep 2010 14:54:54 +0100
Message-ID: <1285854894.3101.0.camel@odin>
References: <1285806521-23090-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 1FD3D243AF
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Sep 2010 15:54:59 +0200 (CEST)
Received: by wyb42 with SMTP id 42so1900362wyb.38
	for <alsa-devel@alsa-project.org>; Thu, 30 Sep 2010 06:54:58 -0700 (PDT)
In-Reply-To: <1285806521-23090-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-09-29 at 17:28 -0700, Mark Brown wrote:
> There are some status bits for microphone detection in here.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8962-tables.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8962-tables.c b/sound/soc/codecs/wm8962-tables.c
> index f21a8c1..6fa98ea 100644
> --- a/sound/soc/codecs/wm8962-tables.c
> +++ b/sound/soc/codecs/wm8962-tables.c
> @@ -21204,7 +21204,7 @@ const struct wm8962_reg_access wm8962_reg_access[WM8962_MAX_REGISTER + 1] = {
>  	{ 0x0000, 0x0000, 0x0000 }, /* R45 */
>  	{ 0x0000, 0x0000, 0x0000 }, /* R46 */
>  	{ 0x000F, 0x0000, 0x0000 }, /* R47    - Thermal Shutdown Status */
> -	{ 0x7EC7, 0x7E07, 0x0000 }, /* R48    - Additional Control (4) */
> +	{ 0x7EC7, 0x7E07, 0xFFFF }, /* R48    - Additional Control (4) */
>  	{ 0x00D3, 0x00D7, 0xFFFF }, /* R49    - Class D Control 1 */
>  	{ 0x0000, 0x0000, 0x0000 }, /* R50 */
>  	{ 0x0047, 0x0047, 0x0000 }, /* R51    - Class D Control 2 */

Both

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
