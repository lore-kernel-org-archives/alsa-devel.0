From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/2] ASoC: tlv320dac33: small fixes
Date: Tue, 16 Feb 2010 13:36:39 +0000
Message-ID: <20100216133639.GA18456@rakim.wolfsonmicro.main>
References: <1266319396-25066-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DB56924381
	for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2010 14:36:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1266319396-25066-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 16, 2010 at 01:23:14PM +0200, Peter Ujfalusi wrote:
> Hello,
> 
> Two small fixes for the tlv320dac33 codec driver:
> Clearing the FIFFLUSH flag before playback start
>  The register cache has the bit set after the playback is stopped, so clear it
>  before the playback.
> OSCSET calculation in case of 44.1KHz sampling rate was off by 1 (0x1588
>  instead of 0x1589, which is the value should be used according to TI).

Applied both, thanks.
