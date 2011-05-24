From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: fix raumfeld platform
Date: Tue, 24 May 2011 23:25:18 +0800
Message-ID: <20110524152516.GE7945@opensource.wolfsonmicro.com>
References: <1306239032-7951-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9E325243A3
	for <alsa-devel@alsa-project.org>;
	Tue, 24 May 2011 17:25:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1306239032-7951-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, May 24, 2011 at 02:10:32PM +0200, Daniel Mack wrote:
> Commit f0fba2ad (ASoC: multi-component - ASoC Multi-Component Support)
> broke support for Raumfeld platforms as it didn't take into account the
> different hardware features on individual devices.
> 
> In particular, Raumfeld speakers have no S/PDIF output, so the members
> of the snd_soc_card struct must be set dynamically.

Applied, thanks.
