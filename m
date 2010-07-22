From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 0/1] *** SUBJECT HERE ***
Date: Thu, 22 Jul 2010 12:02:10 +0100
Message-ID: <20100722110210.GE4737@rakim.wolfsonmicro.main>
References: <1279791534-20028-1-git-send-email-matti.j.aaltonen@nokia.com>
	<20100722094832.GC4737@rakim.wolfsonmicro.main>
	<201007221357.16840.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BD2B4103992
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jul 2010 13:02:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201007221357.16840.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: ext Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, "Aaltonen Matti.J (Nokia-MS/Tampere)" <matti.j.aaltonen@nokia.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 22, 2010 at 01:57:16PM +0300, Peter Ujfalusi wrote:

> I think the whole SNDRV_PCM_INFO_HALF_DUPLEX bit cleaning/setting can be left 
> out as such.

That would be even simpler, of course!

> My point is, that in wl1273_startup, the driver anyway will refuse the non 
> correct stream for FM mode. It is checking, that only playback can be started, 
> when the FM is in TX mode, and allows only capture, if the chip has been 
> configured to FM RX mode. In BT mode the codec can work in full duplex.

...and hopefully userspace won't be trying to do any of the unsupported
things anyway at a higher level than ALSA so that's probably OK.  I
guess in principle the device can support full duplex even with FM, it's
just that the output is going to get discarded so it's not *useful* so
there's not such a need to make sure userspace is told about the
restriction anyway - the CPU driver can do the DMA which is all that's
directly visible to the application.
