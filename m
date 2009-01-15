From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/1] ALSA: ASoC: DaVinci: Fix SFFSDR
	compilation error.
Date: Thu, 15 Jan 2009 21:10:07 +0000
Message-ID: <20090115211005.GL12768@sirena.org.uk>
References: <20090108121613.1ef53112.hugo@hugovil.com>
	<1232052035-31846-1-git-send-email-hugo@hugovil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 77F92103890
	for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2009 22:10:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1232052035-31846-1-git-send-email-hugo@hugovil.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 15, 2009 at 03:40:35PM -0500, Hugo Villeneuve wrote:
> Remove dependency on sffsdr_fpga_set_codec_fs() when the
> SFFSDR FPGA module is not selected.

> Signed-off-by: Hugo Villeneuve <hugo@hugovil.com>

Looks good, applied.
