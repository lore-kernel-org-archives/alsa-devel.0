From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: add missing parameter to
	mx27vis_hifi_hw_free()
Date: Tue, 22 Dec 2009 12:34:20 +0000
Message-ID: <20091222123419.GA19056@opensource.wolfsonmicro.com>
References: <Pine.LNX.4.64.0912220923490.4919@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CDB2510382D
	for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2009 13:34:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0912220923490.4919@axis700.grange>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 22, 2009 at 09:26:10AM +0100, Guennadi Liakhovetski wrote:
> Commit 2ccafed4 added an extra parameter to the DAI .set_pll() method, but 
> it missed this call in sound/soc/imx/mx27vis_wm8974.c.

Appled, thanks.
