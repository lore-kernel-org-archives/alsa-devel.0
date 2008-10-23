From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Fix DSP DAI format and
	signal polarities matching
Date: Thu, 23 Oct 2008 12:51:53 +0100
Message-ID: <20081023115151.GH10280@sirena.org.uk>
References: <1224761223-15988-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4577C103857
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Oct 2008 13:52:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1224761223-15988-1-git-send-email-jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 23, 2008 at 02:27:03PM +0300, Jarkko Nikula wrote:
> - Codec doesn't support to configure bit clock and frame sync polarities
> - Codec doesn't support DSP_A format but DSP_B with inverted bit clock
>   polarity
> - Match also other formats with their signal polarities
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
