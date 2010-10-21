From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: soc-core: Fix codec->name memory leak
Date: Thu, 21 Oct 2010 21:35:20 +0100
Message-ID: <1287693320.3205.70.camel@odin>
References: <1287663585-28792-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6BAD2103A5D
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Oct 2010 22:35:18 +0200 (CEST)
Received: by ewy22 with SMTP id 22so79834ewy.38
	for <alsa-devel@alsa-project.org>; Thu, 21 Oct 2010 13:35:18 -0700 (PDT)
In-Reply-To: <1287663585-28792-1-git-send-email-dp@opensource.wolfsonmicro.com>
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

On Thu, 2010-10-21 at 13:19 +0100, Dimitris Papastamos wrote:
> Ensure that the codec->name is freed when unregistering the codec.
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
