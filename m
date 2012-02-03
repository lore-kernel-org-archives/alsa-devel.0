From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core - Add support for DAI and
	machine kcontrols.
Date: Fri, 3 Feb 2012 20:46:40 +0000
Message-ID: <20120203204640.GD23505@opensource.wolfsonmicro.com>
References: <1328290989-14399-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B0F29103892
	for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2012 21:46:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1328290989-14399-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 03, 2012 at 05:43:09PM +0000, Liam Girdwood wrote:

> 1) Use snd_soc_add_card_controls() where no direct codec control is required.
> 2) Use snd_soc_add_codec_controls() where there is direct codec control.

> In the case of 1) above we also update the machine drivers to get the correct
> component data pointers from the kcontrol (rather than getting the machine pointer
> via the codec pointer).

Hrm, I can't apply this right now as I don't have an appropriate system
to hand but what are the cases where there is CODEC control?  This
sounds suspicous, perhaps we need some of the drivers enhancing (though
no reason to block this patch).
