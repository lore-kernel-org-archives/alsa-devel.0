From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCHv2 0/5] *** SUBJECT HERE ***ASoC:
 tlv320dac33: FIFO caused delay reporting and fixes
Date: Mon, 26 Apr 2010 15:40:53 +0100
Message-ID: <1272292853.3208.71.camel@odin>
References: <1272006601-24946-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f220.google.com (mail-bw0-f220.google.com
	[209.85.218.220])
	by alsa0.perex.cz (Postfix) with ESMTP id C7F7B103830
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Apr 2010 16:40:57 +0200 (CEST)
Received: by bwz20 with SMTP id 20so5094543bwz.32
	for <alsa-devel@alsa-project.org>; Mon, 26 Apr 2010 07:40:56 -0700 (PDT)
In-Reply-To: <1272006601-24946-1-git-send-email-peter.ujfalusi@nokia.com>
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

On Fri, 2010-04-23 at 10:09 +0300, Peter Ujfalusi wrote:
> Hello,
> 
> Changelog:
> - Calculated delay instead of msleep(2) in patch 1
> - ns changed to us in patch 5 (in the macro for calculation)
> 
> The main feature of this series is the FIFO caused delay reporting on the DAC33
> codec.
> The main patch is quite big, but I don't think it can be divided further.
> 
> Short details of the actual implementation is in the commit message(s), and
> I will not copy it here.
> 
> The values reported by the delay call has been verified by using one GPIO as a
> signal, and printout from the kernel at the same time with the delay, than
> based on the time scale on the scope several (>100) cases has been hand
> calculated and the results were compared to the kernel reported values.
> The difference were around (or less) the 10 samples, but during the bursts it
> is much harder to count, but the reported value was reasonable accurate there
> as well.
> 
> ---
> Peter Ujfalusi (5):
>   ASoC: tlv320dac33: Fix for early interrupt in FIFO Mode1
>   ASoC: tlv320dac33: Skip calculations in FIFO Bypass mode
>   ASoC: tlv320dac33: Change magic numbers used in Mode7
>   ASoC: tlv320dac33: Calculate the interface speed during bursts
>   ASoC: tlv320dac33: FIFO caused delay reporting
> 
>  sound/soc/codecs/tlv320dac33.c |  250 ++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 238 insertions(+), 12 deletions(-)

Applied.

Thanks

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
