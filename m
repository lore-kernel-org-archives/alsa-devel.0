From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch] ASoC: adau1701: signedness bug in
	adau1701_write()
Date: Mon, 20 Jun 2011 18:49:16 +0100
Message-ID: <20110620174916.GA32291@opensource.wolfsonmicro.com>
References: <20110620071125.GG14591@shale.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 75E171038BD
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jun 2011 19:49:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110620071125.GG14591@shale.localdomain>
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
Cc: "open list:SOUND - SOC LAYER..." <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 20, 2011 at 10:11:25AM +0300, Dan Carpenter wrote:
> "ret" is supposed to be signed here.  The current code will only
> return -EIO on error, instead of a more appropriate error code such
> as -EAGAIN etc.

That changelog is not accurate, if nothing else the code will return
-EINVAL if it can't figure out a length for a register.  However, the
change itself is good so applied, thanks.
