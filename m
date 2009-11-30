From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] ASoC: sh: fsi: Add runtime PM support
Date: Mon, 30 Nov 2009 13:06:29 +0000
Message-ID: <20091130130629.GA18877@rakim.wolfsonmicro.main>
References: <u3a3wcl1b.wl%morimoto.kuninori@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B150E10385D
	for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2009 14:06:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <u3a3wcl1b.wl%morimoto.kuninori@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: alsa-devel@alsa-project.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 30, 2009 at 08:24:48PM +0900, Kuninori Morimoto wrote:
> This patch add support runtime PM.
> Driver callbacks for Runtime PM are empty because
> the device registers are always re-initialized after
> pm_runtime_get_sync(). The Runtime PM functions replaces the
> clock framework module stop bit handling in this driver.

Applied both, thanks.
