From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 2/3] ASoC: Remove open coded symmetry
 implementation from WM8903
Date: Fri, 10 Dec 2010 23:03:31 +0000
Message-ID: <1292022211.3422.28.camel@odin>
References: <1292008628-29457-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1292008628-29457-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4CF5E10380C
	for <alsa-devel@alsa-project.org>; Sat, 11 Dec 2010 00:03:34 +0100 (CET)
Received: by wwe15 with SMTP id 15so4036451wwe.20
	for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2010 15:03:34 -0800 (PST)
In-Reply-To: <1292008628-29457-2-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Fri, 2010-12-10 at 19:17 +0000, Mark Brown wrote:
> We're already flagged as using symmetric rates so we don't need to
> have a custom implementation.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8903.c |   79 +--------------------------------------------
>  1 files changed, 1 insertions(+), 78 deletions(-)
> 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
