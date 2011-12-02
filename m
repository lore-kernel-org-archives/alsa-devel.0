From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] sound/soc/lapis: add machine driver
Date: Fri, 2 Dec 2011 12:22:05 +0000
Message-ID: <20111202122205.GL8245@opensource.wolfsonmicro.com>
References: <1321848532-8784-1-git-send-email-tomoya.rohm@gmail.com>
	<1321848532-8784-2-git-send-email-tomoya.rohm@gmail.com>
	<20111121113433.GD3784@opensource.wolfsonmicro.com>
	<CANKRQnjdS1NvcGLa=S1M0D4U_NV3+JR1E4YfAV7Ziq-fE2LQgg@mail.gmail.com>
	<20111202114638.GI8245@opensource.wolfsonmicro.com>
	<CANKRQng5OzqjiQ81OUH+2Aet8DAM198s6B=_1FuASnd19BU26w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E030F2437E
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 13:22:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CANKRQng5OzqjiQ81OUH+2Aet8DAM198s6B=_1FuASnd19BU26w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>, qi.wang@intel.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, yong.y.wang@intel.com, kok.howg.ewe@intel.com, Daniel Mack <zonque@gmail.com>, Liam Girdwood <lrg@ti.com>, joel.clark@intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 02, 2011 at 09:09:34PM +0900, Tomoya MORINAGA wrote:
> 2011/12/2 Mark Brown <broonie@opensource.wolfsonmicro.com>:

> > The CPU side audio drivers are not there - there seemed to be some quite
> > serious review issues with those.

> Let me clarify your saying.
> Does the above "audio drivers" mean i2s (of south bridge) driver or HD
> audio (of north bridge) or another?

I2S and audio DMA.
