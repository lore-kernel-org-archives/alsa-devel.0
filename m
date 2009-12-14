From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 9/9] sound/soc/codecs: Correct code taking
 the size of a pointer
Date: Mon, 14 Dec 2009 11:38:51 +0000
Message-ID: <20091214113851.GD21066@rakim.wolfsonmicro.main>
References: <Pine.LNX.4.64.0912131242570.24267@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BD3F32435D
	for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2009 12:38:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0912131242570.24267@ask.diku.dk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <julia@diku.dk>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 13, 2009 at 12:43:15PM +0100, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> sizeof(codec->reg_cache) is just the size of the pointer.  Elsewhere in the
> file, codec->reg_cache is used with sizeof(wm8900_reg_defaults), so the
> code is changed to do the same here.

Applied, thanks.
