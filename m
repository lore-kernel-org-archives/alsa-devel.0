From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: RX-51: Add Jack Function kcontrol
Date: Wed, 23 Jun 2010 11:36:05 +0100
Message-ID: <1277289365.3092.29.camel@odin>
References: <1277118900-30100-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 811D210389C
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jun 2010 12:36:07 +0200 (CEST)
Received: by mail-wy0-f179.google.com with SMTP id 38so910654wyb.38
	for <alsa-devel@alsa-project.org>; Wed, 23 Jun 2010 03:36:07 -0700 (PDT)
In-Reply-To: <1277118900-30100-1-git-send-email-jhnikula@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-06-21 at 14:14 +0300, Jarkko Nikula wrote:
> Nokia RX-51/N900 has multifunction 4-pole audio-video jack that can be used
> as headphone, headset or audio-video connector. This patch implements the
> control 'Jack Function' which is used to select the desired function.
> At the moment only TV-out without audio is supported.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> ---
>  sound/soc/omap/rx51.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 44 insertions(+), 0 deletions(-)
> 

Both Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
