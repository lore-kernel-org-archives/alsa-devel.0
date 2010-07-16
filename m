From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: soc-core: soc_pcm_ops
	dynamically allocated
Date: Fri, 16 Jul 2010 16:09:48 +0100
Message-ID: <20100716150948.GA23183@rakim.wolfsonmicro.main>
References: <1279291619-5081-1-git-send-email-lamiaposta71@gmail.com>
	<1279291619-5081-2-git-send-email-lamiaposta71@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1CD32103806
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Jul 2010 17:09:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1279291619-5081-2-git-send-email-lamiaposta71@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raffaele Recalcati <lamiaposta71@gmail.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, Barry Song <21cnbao@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, alsa-devel@alsa-project.org, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, Davide Bonfanti <davide.bonfanti@bticino.it>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 16, 2010 at 04:46:57PM +0200, Raffaele Recalcati wrote:

>     If soc_pcm_ops is statically allocated, more than one call to soc_new_pcm
>     cause operations overwrite. The problem is overcome usyng dynamic
>     allocation.

As I said previously you're looking for Liam's multi-component work
here rather than this (or at least should be basing your work off his).
