From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: fsi: Add spin lock operation for
 accessing shared area
Date: Thu, 28 Jan 2010 12:44:37 +0000
Message-ID: <20100128124437.GA8732@rakim.wolfsonmicro.main>
References: <uhbq66d2m.wl%morimoto.kuninori@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CC16E103847
	for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2010 13:44:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <uhbq66d2m.wl%morimoto.kuninori@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 28, 2010 at 01:46:16PM +0900, Kuninori Morimoto wrote:
> fsi_master_xxx function should be protected by spin lock,
> because it are used from both FSI-A and FSI-B.
> 
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>

Applied, thanks.
