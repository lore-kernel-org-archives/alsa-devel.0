From: Jesper Juhl <jj@chaosbits.net>
Subject: Re: [PATCH] Sound, SoC,
 WM9090: Remove unused variable 'wm9090' from wm9090_i2c_remove()
Date: Sun, 29 Jan 2012 22:43:06 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1201292242530.27749@swampdragon.chaosbits.net>
References: <alpine.LNX.2.00.1201280055410.13952@swampdragon.chaosbits.net>
	<20120129214205.GD2994@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from swampdragon.chaosbits.net (swampdragon.chaosbits.net
	[90.184.90.115]) by alsa0.perex.cz (Postfix) with ESMTP id EB99B24719
	for <alsa-devel@alsa-project.org>; Sun, 29 Jan 2012 22:42:51 +0100 (CET)
In-Reply-To: <20120129214205.GD2994@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Ian Lartey <ian@opensource.wolfsonmicro.com>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sun, 29 Jan 2012, Mark Brown wrote:

> On Sat, Jan 28, 2012 at 12:57:42AM +0100, Jesper Juhl wrote:
> > The variable 'wm9090' is assigned to but never used, so let's just
> > remove it.
> 
> There's already a fix in for this (adding use back).
> 
Ok. Thank you for letting me know.

-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.
