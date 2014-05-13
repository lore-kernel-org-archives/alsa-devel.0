From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] ASoC: wm8962: Update register
 CLASS_D_CONTROL_1 to be non-volatile
Date: Tue, 13 May 2014 22:29:31 +0800
Message-ID: <20140513142926.GA12916@dragon>
References: <1399985115-29117-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0209.outbound.protection.outlook.com [207.46.163.209])
 by alsa0.perex.cz (Postfix) with ESMTP id E6E86265673
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 16:29:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1399985115-29117-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, lars@metafoo.de, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, May 13, 2014 at 01:45:15PM +0100, Charles Keepax wrote:
> The register CLASS_D_CONTROL_1 is marked as volatile because it contains
> a bit, DAC_MUTE, which is also mirrored in the ADC_DAC_CONTROL_1
> register. This causes problems for the "Speaker Switch" control, which
> will report an error if the CODEC is suspended because it relies on a
> volatile register.
> 
> To resolve this issue mark CLASS_D_CONTROL_1 as non-volatile and
> manually keep the register cache in sync by updating both bits when
> changing the mute status.
> 
> Reported-by: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---
> Hi Shawn,
> 
> I am afraid I don't have access to hardware for 8962 at the
> moment, so have only build tested this, but I believe it
> should fix your issue.

Yes, it fixes my issue.  Thanks, Charles.

Tested-by: Shawn Guo <shawn.guo@linaro.org>
