From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH V1 10/11] ASoC: DaVinci: i2s don't limit
 rates
Date: Mon, 06 Jul 2009 15:27:10 -0700
Message-ID: <4A527A3E.9030603@boundarydevices.com>
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
	<20090706221939.GG25548@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth03.csee.onr.siteprotect.com
	(smtpauth03.csee.onr.siteprotect.com [64.26.60.137])
	by alsa0.perex.cz (Postfix) with ESMTP id 362A32415C
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 00:27:16 +0200 (CEST)
In-Reply-To: <20090706221939.GG25548@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com, Hugo Villeneuve <hugo@hugovil.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Mon, Jul 06, 2009 at 03:01:54PM -0700, Troy Kisky wrote:
> 
>> But even if the cpu is the clock/frame master, the sample rate generator has an 8 bit
>> divider field, which seems to be always 0 in the current code. And I don't see any reference
>> to params_rate in the davinci-i2s.c file. Has anyone tried the cpu as master???
> 
> It does appear that way, doesn't it?  But looking at the code
> davinci-sffsdr runs with the CPU as frame master so I'd have expected
> that it would have shown any problems here.
> 
But in this case the clock to divide would come from the CLKR pin, so a divide
by (0+1) would be correct.
