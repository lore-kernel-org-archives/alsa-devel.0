From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: OMAP machines: Fix kernel crash due
 to changes in core
Date: Fri, 7 Oct 2011 11:17:12 +0100
Message-ID: <20111007101711.GD19080@opensource.wolfsonmicro.com>
References: <1317971206-10365-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 57CCA2447A
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 12:17:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317971206-10365-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, =?utf-8?Q?Gra=C5=BEvydas?= Ignotas <notasas@gmail.com>, Anuj Aggarwal <anuj.aggarwal@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 07, 2011 at 10:06:46AM +0300, Peter Ujfalusi wrote:
> Calling soc_dapm_sync() after adding DAPM widgets/routes
> will lead to kernel crash caused by unitialized
> widget->power_check callback (NULL pointer dereference).

> Call snd_soc_dapm_new_widgets(dapm); instead of soc_dapm_sync
> which will initialize the widgets, and will call the
> dapm_power_widgets (soc_dapm_sync is a wrapper for
> dapm_power_widgets).

No, there should be no need for either callback in individual drivers
unless they're doing something very specialist.  This will have been the
case for a while now.
