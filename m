From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 0/2] ASoC: tlv320dac33: small fixes
Date: Tue, 16 Feb 2010 11:31:59 +0000
Message-ID: <1266319919.3206.2.camel@odin>
References: <1266319396-25066-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f213.google.com (mail-ew0-f213.google.com
	[209.85.219.213])
	by alsa0.perex.cz (Postfix) with ESMTP id CE1A824407
	for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2010 12:32:03 +0100 (CET)
Received: by ewy5 with SMTP id 5so1113717ewy.32
	for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2010 03:32:03 -0800 (PST)
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
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-02-16 at 13:23 +0200, Peter Ujfalusi wrote:
> Hello,
> 
> Two small fixes for the tlv320dac33 codec driver:
> Clearing the FIFFLUSH flag before playback start
>  The register cache has the bit set after the playback is stopped, so clear it
>  before the playback.
> OSCSET calculation in case of 44.1KHz sampling rate was off by 1 (0x1588
>  instead of 0x1589, which is the value should be used according to TI).
> 
> ---
> Peter Ujfalusi (2):
>   ASoC: tlv320dac33: Clearing FIFOFLUSH flag before playback
>   ASoC: tlv320dac33: Correct the OSCSET calculation
> 
>  sound/soc/codecs/tlv320dac33.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
