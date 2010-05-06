From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: tlv320dac33: Use codec defaults for
 LOM/LOP and DAC power
Date: Thu, 06 May 2010 15:02:44 +0100
Message-ID: <1273154564.2992.39.camel@odin>
References: <1273136665-3340-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id BCB162472B
	for <alsa-devel@alsa-project.org>;
	Thu,  6 May 2010 16:02:49 +0200 (CEST)
Received: by wyf23 with SMTP id 23so46272wyf.38
	for <alsa-devel@alsa-project.org>; Thu, 06 May 2010 07:02:47 -0700 (PDT)
In-Reply-To: <1273136665-3340-1-git-send-email-peter.ujfalusi@nokia.com>
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

On Thu, 2010-05-06 at 12:04 +0300, Peter Ujfalusi wrote:
> Do not change the codec defaults for the following registers:
> 0x40, 0x41: Line output gains, do not use amplification
> 0x42: LOM/LOP Voltage hold, and selection
> 0x44: LOM inversion control
> 
> It has been found, that the values configured to these registers
> can cause amplification, which can make the output of DAC33
> distorted.
> 
> The codec reset values are considered safe in all environmnts.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---
> 

Applied.

Thanks

Liam
