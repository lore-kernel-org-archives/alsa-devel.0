From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: (no subject)
Date: Fri, 27 Mar 2009 16:31:25 +0000
Message-ID: <20090327163124.GB6752@sirena.org.uk>
References: <20090327085613.dc719780.jarkko.nikula@nokia.com>
	<1238160721-27180-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id ACB3610385B
	for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2009 17:31:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1238160721-27180-1-git-send-email-jarkko.nikula@nokia.com>
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
Cc: alsa-devel@alsa-project.org, x0052729@ti.com
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 27, 2009 at 03:32:00PM +0200, Jarkko Nikula wrote:

> I think we should use something like this in case of McBSP2 in OMAP3. McBSP2
> has 4 kB internal audio buffer and it's causing underruns in playback
> startup if ALSA buffer is smaller than that because DMA is looping around the
> buffer while filling up the HW FIFO.

Applied, thanks (with your explanation from the previous message pasted
into the commit message for the benefit of anyone going through logs).
