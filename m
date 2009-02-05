From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: pxa-ssp: disable only when the ssp
	dai is active
Date: Thu, 5 Feb 2009 11:03:20 +0000
Message-ID: <20090205110319.GA17085@rakim.wolfsonmicro.main>
References: <f17812d70902050242h145788b7s34a34d34f6f26c06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E8C391037FD
	for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2009 12:03:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <f17812d70902050242h145788b7s34a34d34f6f26c06@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 05, 2009 at 06:42:13PM +0800, Eric Miao wrote:

> Typo?

No, the check is inverted since the shutdown function will be called
once per substream.  This means that if both playback and record are
active and one is stopped the driver can't stop the clocks since
that'd disrupt the other.  The core updates the active flag before
calling into the driver.
