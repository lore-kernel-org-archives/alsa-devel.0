From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Add initial WM8995 driver
Date: Wed, 22 Dec 2010 13:33:36 +0000
Message-ID: <1293024816.3329.30.camel@odin>
References: <1293017591-1277-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C55C1038E8
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2010 14:33:40 +0100 (CET)
Received: by wyi11 with SMTP id 11so4853738wyi.38
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2010 05:33:40 -0800 (PST)
In-Reply-To: <1293017591-1277-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-12-22 at 11:33 +0000, Dimitris Papastamos wrote:
> The WM8995 is a digital audio hub CODEC designed for smartphones.
> The current driver supports most of the basic functionality of the
> WM8995.
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/Kconfig  |    4 +
>  sound/soc/codecs/Makefile |    2 +
>  sound/soc/codecs/wm8995.c | 1818 ++++++++++
>  sound/soc/codecs/wm8995.h | 8749
> +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 10573 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/codecs/wm8995.c
>  create mode 100644 sound/soc/codecs/wm8995.h
> 
> 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
