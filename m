From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: What am i doing wrong?
Date: Thu, 29 Oct 2009 11:48:10 +0000
Message-ID: <20091029114810.GD15559@sirena.org.uk>
References: <0D107966AF6D79418315B7C5549F4B5101150D3A@lemail1.le.imgtec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 352A32469F
	for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2009 12:48:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <0D107966AF6D79418315B7C5549F4B5101150D3A@lemail1.le.imgtec.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Neil Jones <neil.jones@imgtec.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 28, 2009 at 05:33:51PM -0000, Neil Jones wrote:
> Im developing ASoC Driver for an SoC (I2S based).

> When testing playback with aplay, I get 1 buffers worth of data played
> back (10 periods) then playback stops due to a XRUN when my dma list
> wraps back to the start because the available data >= stop_threshold ??

> Here are my logs, interrupts are occurring at the correct time and my
> buffer pointer increments by period size each time.

> Any help would be appreciated

Posting your driver code would make it easier to advise you.
