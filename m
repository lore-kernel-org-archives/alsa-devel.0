From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Question about "ALSA device list" on kernel boot
Date: Mon, 13 Sep 2010 10:05:02 +0100
Message-ID: <20100913090502.GF16606@rakim.wolfsonmicro.main>
References: <w3paanmfjth.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0D593245F5
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Sep 2010 11:05:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <w3paanmfjth.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 13, 2010 at 11:39:39AM +0900, Kuninori Morimoto wrote:

> Was print policy changed ?
> If it is strange, where is ?
>  => soc-core side ? or FSI side ?

There is now only one name for cards, set in the card name field.  I'd
recommend updating this with more informative names for the affected
boards.
