From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Where are dma interrupts handled in ASoC code?
Date: Fri, 21 Nov 2008 11:01:07 +0000
Message-ID: <20081121110106.GB31866@sirena.org.uk>
References: <520f0cf10811210145i20dec91ax9508b9268136bd5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D21ED2440F
	for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2008 12:01:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <520f0cf10811210145i20dec91ax9508b9268136bd5c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Kacur <jkacur@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 21, 2008 at 10:45:46AM +0100, John Kacur wrote:

> Where are dma overflow interrupts handled? For example I don't see
> this in sound/soc/s3c24xx-i2s.c

The s3c24xx ASoC code doesn't interact with the DMA controller directly,
it uses the DMA API exported by the arch/arm code to do that.
