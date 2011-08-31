From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: snd_soc_codec_{readable,
 writable}_register change default to true
Date: Wed, 31 Aug 2011 09:47:28 +0100
Message-ID: <20110831084728.GD4926@opensource.wolfsonmicro.com>
References: <1314462254-11717-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 55DD61038B1
	for <alsa-devel@alsa-project.org>;
	Wed, 31 Aug 2011 10:47:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1314462254-11717-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 27, 2011 at 06:24:12PM +0200, Lars-Peter Clausen wrote:
> Change the default return value of snd_soc_codec_{readable,writable}_register to
> true when no codec specific callback for this function is given. Otherwise all
> registers of that codec will neither be readable nor writable, which is most
> certainly not what we want.

Applied all, thanks.
