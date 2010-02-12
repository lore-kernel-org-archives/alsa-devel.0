From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: Make pmdown_time a per-card
 setting
Date: Fri, 12 Feb 2010 14:19:12 +0000
Message-ID: <1265984352.3231.7.camel@odin>
References: <1265974819-25151-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 89DED2452B
	for <alsa-devel@alsa-project.org>; Fri, 12 Feb 2010 15:19:15 +0100 (CET)
Received: by ewy23 with SMTP id 23so41482ewy.4
	for <alsa-devel@alsa-project.org>; Fri, 12 Feb 2010 06:19:14 -0800 (PST)
In-Reply-To: <1265974819-25151-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-02-12 at 11:40 +0000, Mark Brown wrote:
> Make the pmdown_time a per-card setting rather than a global one,
> initialised before the card initialisation runs. This allows cards
> to override the default setting if it makes sense to do so (for
> example, due to an unavoidable pop).
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
