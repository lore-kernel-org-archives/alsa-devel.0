From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V1 10/11] ASoC: DaVinci: i2s don't limit
 rates
Date: Mon, 6 Jul 2009 23:19:39 +0100
Message-ID: <20090706221939.GG25548@sirena.org.uk>
References: <1246761001-21982-4-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-5-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-6-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-7-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-8-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-9-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-10-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-11-git-send-email-troy.kisky@boundarydevices.com>
	<20090705115746.GB5334@sirena.org.uk>
	<4A527452.6050304@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6EC3B10385A
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 00:19:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A527452.6050304@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com, Hugo Villeneuve <hugo@hugovil.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 06, 2009 at 03:01:54PM -0700, Troy Kisky wrote:

> But even if the cpu is the clock/frame master, the sample rate generator has an 8 bit
> divider field, which seems to be always 0 in the current code. And I don't see any reference
> to params_rate in the davinci-i2s.c file. Has anyone tried the cpu as master???

It does appear that way, doesn't it?  But looking at the code
davinci-sffsdr runs with the CPU as frame master so I'd have expected
that it would have shown any problems here.
