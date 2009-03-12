From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: Add Magician machine support.
Date: Thu, 12 Mar 2009 15:58:59 +0000
Message-ID: <20090312155858.GE24376@sirena.org.uk>
References: <20090311222501.GA7536@sirena.org.uk>
	<1236852410-15891-1-git-send-email-philipp.zabel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E7F42103896
	for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2009 16:59:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1236852410-15891-1-git-send-email-philipp.zabel@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <philipp.zabel@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 12, 2009 at 11:06:50AM +0100, Philipp Zabel wrote:
> HTC Magician has a Philips UDA1380 codec connected via
> SSP1 (playback) and I2S (capture).
> There is a flip-flop between the SSP frame clock output
> and the codec's word select input pin. To make the codec
> see proper I2S input, the SSP has to send two frames per
> sample.

> Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>

This all looks good.  I'll hold off on applying until we've got the SSP
change resolved since it's needed for the driver to work properly.
