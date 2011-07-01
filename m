From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4 4/4] ASoC: SAMSUNG: Add I2S0 internal
 dma driver
Date: Fri, 1 Jul 2011 09:12:02 -0700
Message-ID: <20110701161201.GB23784@opensource.wolfsonmicro.com>
References: <1309484927-3950-1-git-send-email-sbkim73@samsung.com>
	<1309484927-3950-2-git-send-email-sbkim73@samsung.com>
	<4E0DDEBB.1090805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E9191247AF
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Jul 2011 18:12:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E0DDEBB.1090805@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 01, 2011 at 03:50:35PM +0100, Liam Girdwood wrote:
> On 01/07/11 02:48, Sangbeom Kim wrote:

> > +       if (res >= snd_pcm_lib_buffer_bytes(substream))
> > +               res = 0;

> Is it likely that your DMA pointer will go beyond the buffer size ?
> If this happens then I suspect you have something wrong in your DMA config ?

This is actually quite common - the normal case where it happens is that
the DMA controller reports one location beyond the last location it read
so when it hits the end of the buffer you see it report just beyond the
end of the buffer (which is hit quite often since this tends to also
generate an interrupt which causes a pointer() query).  Replacing the
check with an == should be enough for that, though.
