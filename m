From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Blackfin AC97: fix build error after
 multi-component update
Date: Thu, 13 Jan 2011 13:56:48 +0000
Message-ID: <1294927008.3453.9.camel@odin>
References: <1294793853-16049-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0BA23103873
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 14:56:53 +0100 (CET)
Received: by wyi11 with SMTP id 11so1713147wyi.38
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 05:56:52 -0800 (PST)
In-Reply-To: <1294793853-16049-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-01-11 at 19:57 -0500, Mike Frysinger wrote:
> We need to tweak how we query the active capture/playback state after
> the recent overhauls of common code.
> 
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> ---
>  sound/soc/blackfin/bf5xx-ac97.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Please remember to CC both Mark and I otherwise patches could be missed.

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
