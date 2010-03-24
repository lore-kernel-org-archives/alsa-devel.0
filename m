From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch] wm8994: playback => capture
Date: Wed, 24 Mar 2010 14:04:45 +0000
Message-ID: <20100324140445.GD26453@rakim.wolfsonmicro.main>
References: <20100324115834.GG21571@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 143382440C
	for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2010 15:04:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100324115834.GG21571@bicker>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <error27@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Joonyoung Shim <jy0922.shim@samsung.com>, alsa-
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 24, 2010 at 02:58:34PM +0300, Dan Carpenter wrote:
> Sparse caught that initialize "playback" two times instead of
> initializing "capture".
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Applied, thanks.
