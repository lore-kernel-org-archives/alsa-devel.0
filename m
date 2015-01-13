From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] ASoC: wm8904: fix runtime warning
Date: Tue, 13 Jan 2015 17:44:54 +0000
Message-ID: <20150113174454.GV14516@opensource.wolfsonmicro.com>
References: <1421143531-6662-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3FCE0260420
 for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2015 18:44:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1421143531-6662-1-git-send-email-voice.shen@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bo Shen <voice.shen@atmel.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 13, 2015 at 06:05:31PM +0800, Bo Shen wrote:
> Correct the path name for mux to get rid of the following warning:
> 
> --->8---
> wm8904 1-001a: Control not supported for path ADCL -> [Left] -> AIFOUTL
> wm8904 1-001a: ASoC: no dapm match for ADCL --> Left --> AIFOUTL
> wm8904 1-001a: ASoC: Failed to add route ADCL -> Left -> AIFOUTL
> wm8904 1-001a: Control not supported for path ADCR -> [Right] -> AIFOUTL
> wm8904 1-001a: ASoC: no dapm match for ADCR --> Right --> AIFOUTL
> wm8904 1-001a: ASoC: Failed to add route ADCR -> Right -> AIFOUTL
> wm8904 1-001a: Control not supported for path ADCL -> [Left] -> AIFOUTR
> wm8904 1-001a: ASoC: no dapm match for ADCL --> Left --> AIFOUTR
> wm8904 1-001a: ASoC: Failed to add route ADCL -> Left -> AIFOUTR
> wm8904 1-001a: Control not supported for path ADCR -> [Right] -> AIFOUTR
> wm8904 1-001a: ASoC: no dapm match for ADCR --> Right --> AIFOUTR
> wm8904 1-001a: ASoC: Failed to add route ADCR -> Right -> AIFOUTR
> wm8904 1-001a: Control not supported for path AIFINR -> [Right] -> DACL
> wm8904 1-001a: ASoC: no dapm match for AIFINR --> Right --> DACL
> wm8904 1-001a: ASoC: Failed to add route AIFINR -> Right -> DACL
> wm8904 1-001a: Control not supported for path AIFINL -> [Left] -> DACL
> wm8904 1-001a: ASoC: no dapm match for AIFINL --> Left --> DACL
> wm8904 1-001a: ASoC: Failed to add route AIFINL -> Left -> DACL
> wm8904 1-001a: Control not supported for path AIFINR -> [Right] -> DACR
> wm8904 1-001a: ASoC: no dapm match for AIFINR --> Right --> DACR
> wm8904 1-001a: ASoC: Failed to add route AIFINR -> Right -> DACR
> wm8904 1-001a: Control not supported for path AIFINL -> [Left] -> DACR
> wm8904 1-001a: ASoC: no dapm match for AIFINL --> Left --> DACR
> wm8904 1-001a: ASoC: Failed to add route AIFINL -> Left -> DACR
> ---8<---
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
