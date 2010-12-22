From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 0/3] ASoC: tlv320dac33: Cleanup,
	and 32/24 bit support
Date: Wed, 22 Dec 2010 22:36:01 +0000
Message-ID: <1293057361.3329.53.camel@odin>
References: <1293007518-3870-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 10A5F24609
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2010 23:36:09 +0100 (CET)
Received: by wwe15 with SMTP id 15so5399263wwe.20
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2010 14:36:04 -0800 (PST)
In-Reply-To: <1293007518-3870-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-12-22 at 10:45 +0200, Peter Ujfalusi wrote:
> Hello,
> 
> the following series adds 32/24 bit support for DAC33 codec.
> The manual FIFO configuration code will be removed, since that
> was mainly used for initial debugging, and with the 24 bit support
> the FIFO sizes are different, so it would be pain to safe guard
> the manual FIFO settings for both 16, and 24 bit modes.
> 
> ---
> Peter Ujfalusi (3):
>   ASoC: tlv320dac33: Remove manual FIFO configuration
>   ASoC: tlv320dac33: Some cleanup for 32/24 bit support
>   ASoC: tlv320dac33: Add 32/24 bit audio support
> 
>  sound/soc/codecs/tlv320dac33.c |  214 +++++++++++-----------------------------
>  1 files changed, 58 insertions(+), 156 deletions(-)

All Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
