From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 3/5] ASoC: Use core pm_runtime callbacks
	for omap-mcpdm
Date: Mon, 05 Dec 2011 10:32:06 +0200
Message-ID: <4EDC8186.50000@ti.com>
References: <1323043291-6797-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1323043291-6797-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog118.obsmtp.com (na3sys009aog118.obsmtp.com
	[74.125.149.244])
	by alsa0.perex.cz (Postfix) with ESMTP id 9BB70103A2F
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 09:32:03 +0100 (CET)
Received: by mail-bw0-f42.google.com with SMTP id jf3so825853bkc.29
	for <alsa-devel@alsa-project.org>; Mon, 05 Dec 2011 00:32:01 -0800 (PST)
In-Reply-To: <1323043291-6797-3-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: alsa-devel@alsa-project.org

On 12/05/2011 02:01 AM, Mark Brown wrote:
> Now that the core holds a pm_runtime reference to the device while the
> link is active there is no need for the driver to do so.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
