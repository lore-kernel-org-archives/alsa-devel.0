From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/5] ASoC: ak4642: headphone/stereo-line
	output control
Date: Tue, 8 Nov 2011 10:55:42 +0000
Message-ID: <20111108105542.GD25591@opensource.wolfsonmicro.com>
References: <87y5vsqxiz.wl%kuninori.morimoto.gx@renesas.com>
	<87ty6gqxgy.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 285F824378
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2011 11:55:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87ty6gqxgy.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Paul Mundt <lethal@linux-sh.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 06, 2011 at 10:05:05PM -0800, Kuninori Morimoto wrote:
> This patch modifies ak4642 driver to output both headphone/stereo-line in same time.

If you're going to start implementing any sort of routing control you
should really be updating the driver to work normally - we shouldn't
really have accepted the limited functionality in the first place.
