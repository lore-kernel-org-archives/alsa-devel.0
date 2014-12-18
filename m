From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3] sound/soc/adi/axi-spdif.c: Support
 programmable master clock
Date: Thu, 18 Dec 2014 16:07:53 +0100
Message-ID: <5492EDC9.5000401@metafoo.de>
References: <54893D3D.8050100@topic.nl>
 <1418283847-25673-1-git-send-email-mike.looijmans@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-207.synserver.de (smtp-out-207.synserver.de
 [212.40.185.207])
 by alsa0.perex.cz (Postfix) with ESMTP id 40AAC260615
 for <alsa-devel@alsa-project.org>; Thu, 18 Dec 2014 16:08:00 +0100 (CET)
In-Reply-To: <1418283847-25673-1-git-send-email-mike.looijmans@topic.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 12/11/2014 08:44 AM, Mike Looijmans wrote:
> If the master clock supports programmable rates, program it to generate
> the desired frequency. Only apply constraints when the clock is fixed.
> This allows proper clock generation for both 44100 and 48000 Hz based
> sampling rates if the platform supports it.
>
> The clock frequency must be set before enabling it. Enabling the clock
> was done in "startup", but that occurs before "hw_params" where the rate
> is known. Enabling a programmable clock without first setting a valid
> frequency may harm the system. Move the clock start to the hw_params
> routine, and keep track of whether the clock has been started, because
> shutdown may be called without having called hw_params first, and
> hw_params may be called multiple times.
> Starting the clock and enabling the SPDIF output AFTER programming the
> dividers is a more logical order anyway.
>
> To detect if the source clock is fixed, the driver calls clk_round_rate
> for two frequencies. If the results are equal, or if the call returns
> an error, the driver assumes the clock is fixed.
>
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.
