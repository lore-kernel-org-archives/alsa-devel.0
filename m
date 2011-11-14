From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: sta32x: add workaround for ESD
	reset issue
Date: Mon, 14 Nov 2011 21:37:17 +0000
Message-ID: <20111114213716.GG6528@opensource.wolfsonmicro.com>
References: <1321287798-20462-1-git-send-email-js@sig21.net>
	<1321287798-20462-4-git-send-email-js@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C7530243DD
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2011 22:37:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1321287798-20462-4-git-send-email-js@sig21.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Johannes Stezenbach <js@sig21.net>
Cc: alsa-devel@alsa-project.org, Sven Neumann <s.neumann@raumfeld.com>, Liam Girdwood <lrg@ti.com>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 14, 2011 at 05:23:18PM +0100, Johannes Stezenbach wrote:
> sta32x resets and loses all configuration during ESD test.
> Work around by polling the CONFA register once a second
> and restore all coeffcients and registers when CONFA
> changes unexpectedly.

Applied, though it would be nicer if idle_bias_off were also enabled so
that this only has an effect when audio is active (otherwise I can't
imagine anything cares about the reset).
