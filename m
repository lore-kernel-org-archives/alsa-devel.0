From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] asoc tlv320aic3x: add GPIO support
Date: Sat, 19 Apr 2008 12:24:26 +0100
Message-ID: <20080419112425.GA18877@sirena.org.uk>
References: <20080418181214.GB26197@buzzloop.caiaq.de>
	<bd7b27490804181326v311f192bi8454c9c0661427d2@mail.gmail.com>
	<20080419004103.GA29770@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2BBDB24D35
	for <alsa-devel@alsa-project.org>;
	Sat, 19 Apr 2008 13:24:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080419004103.GA29770@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 19, 2008 at 02:41:03AM +0200, Daniel Mack wrote:

> the registers in questions are purely in its scope. So the idea is to
> set up the GPIO's functions via alsa controls and handle its events in
> some board-related code as this is really not abstractable. One could,
> however, do this setup in machine-related code within the asoc
> environment.

The usual approach is to have multi-function pins on CODECs are
controlled by the ASoC codec driver based on configuration supplied by
the machine driver.  Their use tends to be heavily constrained by the
board design so it usually makes more sense to let the machine driver
set things up and deal with exposing controls for any configurability
that user space can exercise.

Most of the time when GPIO lines on CODECs are used they tend to be
controlling other bits of the audio subsystem anyway (eg, power for
simple amplifiers) - most SoCs have plenty of GPIOs on-board and they're
usually much easier to work with due to being memory mapped on the CPU.
