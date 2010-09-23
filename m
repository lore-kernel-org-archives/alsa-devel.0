From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix incorrect parameter to
 snd_soc_codec_volatile_register
Date: Thu, 23 Sep 2010 20:05:47 +0100
Message-ID: <20100923190547.GE32112@rakim.wolfsonmicro.main>
References: <1285168566-20226-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6928C10395C
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Sep 2010 21:05:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1285168566-20226-1-git-send-email-dp@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 22, 2010 at 04:16:06PM +0100, Dimitris Papastamos wrote:
> We need to pass the register index and not the register value.
> This patch depends on my previous patch "ASoC: Delegate to hw
> specific read for volatile registers".
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
