From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/5] ASoC: DaVinci: pcm,
 fix underruns by using sram
Date: Sat, 8 Aug 2009 10:17:08 +0100
Message-ID: <20090808091708.GG4519@sirena.org.uk>
References: <1249602935-1267-1-git-send-email-troy.kisky@boundarydevices.com>
	<1249602935-1267-2-git-send-email-troy.kisky@boundarydevices.com>
	<1249602935-1267-3-git-send-email-troy.kisky@boundarydevices.com>
	<1249602935-1267-4-git-send-email-troy.kisky@boundarydevices.com>
	<1249602935-1267-5-git-send-email-troy.kisky@boundarydevices.com>
	<4A7B8C02.6020902@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B07024395
	for <alsa-devel@alsa-project.org>;
	Sat,  8 Aug 2009 11:17:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A7B8C02.6020902@boundarydevices.com>
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
Cc: davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 06, 2009 at 07:05:54PM -0700, Troy Kisky wrote:

> This is allocated too late for the "ensure that buffer size is a multiple of period size"
> constraint.

> I have a patch after fixing other feedback.

It looks good to me - I've no issues with the patch except for the one I
mentioned last time about considering ignoring the data in SRAM when
reporting the current position but I'm happy either way.  The patch will
run into the cross tree issues with the platform data like the channel
combining one, probably best to submit patches against Kevin's tree for
now (or wait until after the merge window).

Have you tested with PulseAudio?  If not it'd be worth giving it a spin
- it's one of the more demanding applications.
