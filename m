From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/8] ALSA: ASoC: tlv320aic3x add dsp_a,
	fix dsp_b
Date: Sat, 20 Dec 2008 17:54:56 +0000
Message-ID: <20081220175454.GB971@sirena.org.uk>
References: <1229629006-4261-1-git-send-email-troy.kisky@boundarydevices.com>
	<1229629006-4261-2-git-send-email-troy.kisky@boundarydevices.com>
	<bd7b27490812190204p11bd383bmb64bf62c166f4476@mail.gmail.com>
	<494BE237.7020204@boundarydevices.com>
	<bd7b27490812200802o39072b3dj37df269ae1e288a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F5B31037EC
	for <alsa-devel@alsa-project.org>; Sat, 20 Dec 2008 18:54:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <bd7b27490812200802o39072b3dj37df269ae1e288a0@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, cliff.cai@analog.com, alsa-devel@alsa-project.org, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Dec 20, 2008 at 06:02:33PM +0200, Jarkko Nikula wrote:

> And obviously omap-mcbsp.c too... grr, looks like I forgot to send a fix to
> it when fixing aic3x (commit 4b7d283150b35db6e5e10f72606f603ff424c92a). Will
> send a fix to omap-mcbsp, aic23 and osk5912 next week.

Takashi just said he'll be on holiday from the 23rd so if you could send
a patch before then that'd be best, though if you don't make it then
it's a sufficiently important bug fix to get merged later on.
