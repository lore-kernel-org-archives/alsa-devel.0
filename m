From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v1 RESEND] audio: tlv320aic26: fix PLL
 register configuration
Date: Sat, 21 May 2011 12:08:22 +0100
Message-ID: <1305976102.3317.2.camel@odin>
References: <1305901566-8125-1-git-send-email-michael.williamson@criticallink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 83B9910387A
	for <alsa-devel@alsa-project.org>;
	Sat, 21 May 2011 13:08:26 +0200 (CEST)
Received: by wyg36 with SMTP id 36so3664200wyg.38
	for <alsa-devel@alsa-project.org>; Sat, 21 May 2011 04:08:26 -0700 (PDT)
In-Reply-To: <1305901566-8125-1-git-send-email-michael.williamson@criticallink.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Michael Williamson <michael.williamson@criticallink.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-05-20 at 10:26 -0400, Michael Williamson wrote:
> The current PLL configuration code for the tlc320aic26 codec appears to assume a
> hardcoded system clock of 12 MHz.  Use the clock value provided by the DAI_OPS
> API for the calculation.
> 
> Tested using a MityDSP-L138 platform providing a 24.576 MHz clock.
> 
> Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> This got bounced by the alsa-devel list (I wasn't on list).  I'm not sure 
> whose tree this needs to go through, but given the lack of response
> I'm guessing alsa-devel. If I'm missing a list, any advice would be 
> appreciated.

Applied.

Thanks

Liam
