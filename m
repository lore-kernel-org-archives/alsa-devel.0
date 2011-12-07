From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/5] ASoC: Hold runtime PM references to
 components of active DAIs
Date: Wed, 07 Dec 2011 09:48:05 +0200
Message-ID: <4EDF1A35.8020003@ti.com>
References: <1323043291-6797-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
	[74.125.149.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 1471024667
	for <alsa-devel@alsa-project.org>; Wed,  7 Dec 2011 08:48:00 +0100 (CET)
Received: by laho5 with SMTP id o5so75518lah.7
	for <alsa-devel@alsa-project.org>; Tue, 06 Dec 2011 23:47:55 -0800 (PST)
In-Reply-To: <1323043291-6797-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
> Every device that implements runtime power management for DAIs is doing
> it in pretty much the same way: in the startup callback they take a
> runtime PM reference and then in the shutdown callback they release that
> reference, keeping the device active while the DAI is active. Given the
> frequency with which this is done and the obviousness of the need to keep
> the device active in this period factor the code out into the core, taking
> references on the device for each CPU DAI, CODEC DAI and DMA device in the
> core.
> 
> As runtime PM is reference counted this shouldn't interfere with any
> other reference holding by the drivers, and since (in common with the
> existing implementations) we don't check for errors on enabling it
> shouldn't matter if the device actually has runtime PM enabled or not.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
