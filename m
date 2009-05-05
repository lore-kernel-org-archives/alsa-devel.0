From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 1/2] ASoC: cs4270: introduce CS4270_I2C_INCR
Date: Tue, 5 May 2009 17:15:38 +0200
Message-ID: <20090505151538.GC24556@buzzloop.caiaq.de>
References: <1241515501-6600-1-git-send-email-daniel@caiaq.de>
	<4A005283.50306@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 0D657103808
	for <alsa-devel@alsa-project.org>;
	Tue,  5 May 2009 17:15:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A005283.50306@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, May 05, 2009 at 09:51:47AM -0500, Timur Tabi wrote:
> Daniel Mack wrote:
> > Replace the magic 0x80 value with a suitable macro definition.
> > 
> > Signed-off-by: Daniel Mack <daniel@caiaq.de>
> > Cc: Timur Tabi <timur@freescale.com>
> > Cc: Mark Brown <broonie@sirena.org.uk>
> 
> And I thought *I* was anal-retentive! :-)

Erm, yes - need to explain that :)

I planned to use that macro a second time for the register write-back at
resume time. But unfortunately, the i2c stack is so badly broken that it
does not allow the write of a whole data block without having the length
itself as part of the message (which is wrong for the codec).

But the change was there already by then, and so I left the patch in my
queue.

Daniel
