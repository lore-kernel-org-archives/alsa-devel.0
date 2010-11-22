From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/4] ASoC: Fix compile breakage in jz4740.c
 and smartq_wm8987.c
Date: Mon, 22 Nov 2010 13:42:15 +0000
Message-ID: <1290433335.3309.19.camel@odin>
References: <1290361727-25162-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id ED16E1039CE
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 14:42:22 +0100 (CET)
Received: by wyg36 with SMTP id 36so7042745wyg.38
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 05:42:22 -0800 (PST)
In-Reply-To: <1290361727-25162-1-git-send-email-jhnikula@gmail.com>
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

On Sun, 2010-11-21 at 19:48 +0200, Jarkko Nikula wrote:
> Commit ce6120c require that soc-dapm.h cannot be included before soc.h but
> these two drivers were not checked. Fix them by including only soc.h as it
> includes soc-dapm.h.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

All

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
