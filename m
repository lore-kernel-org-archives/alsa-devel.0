From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [patch] ASoC: checking kzalloc() for IS_ERR()
	instead of NULL
Date: Mon, 11 Oct 2010 12:16:03 +0100
Message-ID: <1286795763.4614.3.camel@dplaptop>
References: <20101009193131.GA5851@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9E2CB1038F5
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Oct 2010 13:16:08 +0200 (CEST)
In-Reply-To: <20101009193131.GA5851@bicker>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <error27@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, kernel-janitors@vger.kernel.org, Ian Lartey <ian@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, 2010-10-09 at 21:31 +0200, Dan Carpenter wrote:
> There is a typo here that got copy and pasted to several probe
> functions.  kzalloc() returns NULL on allocation failures and not an
> ERR_PTR.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> 

Thanks for noticing this.

Acked-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
