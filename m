From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: arecord and DMA misaligned error with device
Date: Mon, 31 May 2010 11:18:27 +0100
Message-ID: <1275301107.3174.9.camel@odin>
References: <AANLkTilGJrApaQ2N9vQLVLKQWq_tkv7qMVKzYHUlBdpl@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8CA16103860
	for <alsa-devel@alsa-project.org>;
	Mon, 31 May 2010 12:18:31 +0200 (CEST)
Received: by wwf26 with SMTP id 26so674361wwf.38
	for <alsa-devel@alsa-project.org>; Mon, 31 May 2010 03:18:31 -0700 (PDT)
In-Reply-To: <AANLkTilGJrApaQ2N9vQLVLKQWq_tkv7qMVKzYHUlBdpl@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ruchi Sirauthiya <sirauthiya.ruchi@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, 2010-05-29 at 23:43 +0530, Ruchi Sirauthiya wrote:
> Hi all,
> 
> I am working on an OMAP board with Linux kernel 2.6.22.18-omap3 and ALSA. I
> got the
> following stack trace when running 'arecord' continuously for a long time
> (~30 minutes).

This kernel is rather ancient, please upgrade. Fwiw, I know that some
people can capture audio using recent kernels on OMAP3 for days.

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
