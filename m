From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] ASoC: jz4740: Convert qi_lb60 to use
 snd_soc_register_card()
Date: Sun, 15 Jan 2012 12:10:42 +0000
Message-ID: <20120115121041.GD3040@opensource.wolfsonmicro.com>
References: <1325820610.10011.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 83E22245E7
	for <alsa-devel@alsa-project.org>; Sun, 15 Jan 2012 13:10:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1325820610.10011.1.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 06, 2012 at 11:30:10AM +0800, Axel Lin wrote:
> Use snd_soc_register_card() instead of creating a "soc-audio" platform device.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Applied, thanks.
