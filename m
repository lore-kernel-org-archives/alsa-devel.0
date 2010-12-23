From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Remove WM8995 write sequencer
 bitfield definitions
Date: Thu, 23 Dec 2010 14:41:53 +0000
Message-ID: <1293115313.3320.21.camel@odin>
References: <1293105890-15065-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 039001038EF
	for <alsa-devel@alsa-project.org>; Thu, 23 Dec 2010 15:41:56 +0100 (CET)
Received: by wwe15 with SMTP id 15so5987084wwe.20
	for <alsa-devel@alsa-project.org>; Thu, 23 Dec 2010 06:41:56 -0800 (PST)
In-Reply-To: <1293105890-15065-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-12-23 at 12:04 +0000, Mark Brown wrote:
> They're very verbose and extremely repetitive so bulk up the kernel more
> than is ideal. If required we can readd with WRITE_SEQUENCER_n type
> definitions that cover the entire register bank in a few defines.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8995.h | 4480 ---------------------------------------------
>  1 files changed, 0 insertions(+), 4480 deletions(-)
> 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
