From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Remove needless inclusion of
 tlv320aic3x.h from machine drivers
Date: Wed, 05 Jan 2011 11:00:09 +0000
Message-ID: <1294225209.3473.1.camel@odin>
References: <1294221944-6400-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1109C103962
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2011 12:00:16 +0100 (CET)
Received: by wwe15 with SMTP id 15so15159034wwe.20
	for <alsa-devel@alsa-project.org>; Wed, 05 Jan 2011 03:00:12 -0800 (PST)
In-Reply-To: <1294221944-6400-1-git-send-email-jhnikula@gmail.com>
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

On Wed, 2011-01-05 at 12:05 +0200, Jarkko Nikula wrote:
> After multi-component conversion these machine drivers don't actually need
> anything from sound/soc/codecs/tlv320aic3x.h so don't include it.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> ---
> rx51.c and n810.c compile tested but these other machine drivers seems to not
> use anything from tlv320aic3x.h either so should be safe to remove.

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
