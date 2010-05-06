From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCHv2] ASoC: tlv320aic3x: Add platform data and
 reset gpio handling
Date: Thu, 06 May 2010 15:05:42 +0100
Message-ID: <1273154742.2992.41.camel@odin>
References: <1273053723-6304-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 21B0D2473A
	for <alsa-devel@alsa-project.org>;
	Thu,  6 May 2010 16:05:45 +0200 (CEST)
Received: by wwb24 with SMTP id 24so3664882wwb.38
	for <alsa-devel@alsa-project.org>; Thu, 06 May 2010 07:05:43 -0700 (PDT)
In-Reply-To: <1273053723-6304-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-05-05 at 13:02 +0300, Jarkko Nikula wrote:
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> 
> ---
> 
> v2:
> 
> - Removed added regulator_bulk_disable brain fart from aic3x_i2c_probe
> - Added comment to gpio_reset number in aic3x_pdata
> ---
>  include/sound/tlv320aic3x.h    |   17 +++++++++++++++++
>  sound/soc/codecs/tlv320aic3x.c |   25 +++++++++++++++++++++++++
>  2 files changed, 42 insertions(+), 0 deletions(-)
>  create mode 100644 include/sound/tlv320aic3x.h
> 

Applied with commit message.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
