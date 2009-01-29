From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 0/1] ASoC: TWL4030: Analog
	bypass	implementation - try2
Date: Thu, 29 Jan 2009 13:54:34 +0000
Message-ID: <20090129135310.GE12179@sirena.org.uk>
References: <1233233870-22700-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 03490103896
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 15:08:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1233233870-22700-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: sakoman@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 29, 2009 at 02:57:49PM +0200, Peter Ujfalusi wrote:

> With the this implementation, there is no visible difference in power
> consumption compared to the previous, codec off way.
> So when the codec is in SND_SOC_BIAS_STANDBY mode and all of the bypasses are
> disabled, the additional power consumption is minimal, if any.

It isn't ideal since what should happen is that the bias is kept on
while any paths are active (not just digital ones) but it shouldn't
cause any problems since all that should happen is that the checks
for bypass paths being active will just always return false.  I'll
the patch - when the core becomes more capable the patch can always be
revisited.
