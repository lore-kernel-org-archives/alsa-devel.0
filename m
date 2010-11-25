From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Call snd_soc_unregister_dais instead
 of snd_soc_unregister_dai in sh4_soc_dai_remove
Date: Thu, 25 Nov 2010 11:11:23 +0000
Message-ID: <20101125111122.GA22298@rakim.wolfsonmicro.main>
References: <1290677035.1928.3.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 054A6103C31
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 12:11:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1290677035.1928.3.camel@mola>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Manuel Lauss <mano@roarinelk.homelinux.net>, linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 25, 2010 at 05:23:55PM +0800, Axel Lin wrote:
> We call snd_soc_register_dais() in sh4_soc_dai_probe(),
> thus we should call snd_soc_unregister_dais() in sh4_soc_dai_remove().

Applied, thanks.
