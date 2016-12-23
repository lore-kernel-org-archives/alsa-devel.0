From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 3/3] ASoC: tlv320aic3x: Add controls for
 selecting HP power down modes
Date: Fri, 23 Dec 2016 20:47:07 +0200
Message-ID: <084901eb-25be-4941-0cbc-0e88cc4010d6@bitmer.com>
References: <20161223092112.7992-1-peter.ujfalusi@ti.com>
 <20161223092112.7992-4-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 728FF26719A
 for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2016 19:47:09 +0100 (CET)
In-Reply-To: <20161223092112.7992-4-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org

On 12/23/2016 11:21 AM, Peter Ujfalusi wrote:
> When the HP drivers are powered down, their output can be placed in
> high-impedance state or it can be weakly driven to the VCM level.
> High-impedance mode provides better power saving in the expense of pop
> noise when powering up the HP.
> When the output is driven to VCM level the artifacts can be minimized, but
> the power down power consumption will be slightly higher.
> 
> The patch adds way to select the HPL/R power-down mode.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  sound/soc/codecs/tlv320aic3x.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
This certainly gives more possibilities to control this depending on
use-case and device idleness. However I think does it find use or will
it end up being a random choice?

Alternative could be some high-impedance widget that defines the output
mode and what a machine driver wanting lower power consumption can
connect instead of HP outputs. Another idea that comes to my mind do you
hear the pop if output is let to be in high-impedance but is driven to
VCM with some delay before powering up?

-- 
Jarkko
