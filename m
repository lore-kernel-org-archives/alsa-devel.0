From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: free socdev if init_card() fails in
 wm9705_soc_probe()
Date: Sun, 23 Aug 2009 10:03:54 +0100
Message-ID: <20090823090353.GA4589@sirena.org.uk>
References: <4A9045E8.1080606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CA71D24158
	for <alsa-devel@alsa-project.org>;
	Sun, 23 Aug 2009 11:04:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A9045E8.1080606@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: alsa-devel@alsa-project.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 22, 2009 at 09:24:24PM +0200, Roel Kluin wrote:
> Free socdev if snd_soc_init_card() fails.

> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>

Applied, thanks.
