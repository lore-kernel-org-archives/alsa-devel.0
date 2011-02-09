From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/3] ASoC: Convert WM8903 to use PGA_S for
 output stage enables
Date: Wed, 09 Feb 2011 21:51:11 +0000
Message-ID: <1297288271.3297.185.camel@odin>
References: <1297273377-7898-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8CC9A1039BA
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2011 22:51:14 +0100 (CET)
Received: by wwe15 with SMTP id 15so674058wwe.20
	for <alsa-devel@alsa-project.org>; Wed, 09 Feb 2011 13:51:14 -0800 (PST)
In-Reply-To: <1297273377-7898-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Wed, 2011-02-09 at 17:42 +0000, Mark Brown wrote:
> This simplfies the code and slightly reduces the startup time.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8903.c |  180 +++++++++++++++------------------------------
>  1 files changed, 60 insertions(+), 120 deletions(-)

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
