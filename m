From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ALSA: ASoC: cs4720: use
	snd_soc_cache_sync()
Date: Tue, 22 Nov 2011 23:06:36 +0000
Message-ID: <20111122230636.GD3005@opensource.wolfsonmicro.com>
References: <1321978643-23976-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 76F0124141
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 00:06:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1321978643-23976-1-git-send-email-zonque@gmail.com>
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
Cc: alsa-devel@alsa-project.org, s.neumann@raumfeld.com, timur@freescale.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 22, 2011 at 05:17:23PM +0100, Daniel Mack wrote:
> Replace the manual register restore mechanism in cs4270.c and call the
> generic snd_soc_cache_sync() handler instead.

Applied, thanks.
