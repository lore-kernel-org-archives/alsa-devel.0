From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 05/11] ASoC: Add helper functions to cast
 from DAPM context to CODEC/platform
Date: Mon, 26 May 2014 21:36:54 +0200
Message-ID: <538397D6.4080105@metafoo.de>
References: <1400415858-11025-1-git-send-email-lars@metafoo.de>
 <1400415858-11025-6-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-017.synserver.de (smtp-out-043.synserver.de
 [212.40.185.43])
 by alsa0.perex.cz (Postfix) with ESMTP id CC6A026545F
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 21:38:41 +0200 (CEST)
In-Reply-To: <1400415858-11025-6-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 05/18/2014 02:24 PM, Lars-Peter Clausen wrote:
> This is useful if we have a pointer to a DAPM context and know that it is a
> CODEC or platform DAPM context and want to get a pointer to the CODEC or
> platform.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---

It would be nice if this one could make it into 3.16. It doesn't depend on any 
of the patches earlier in this series and I think it is pretty trivial. Having 
it in 3.16 makes it possible to use it after the merge window in some driver 
cleanup patches without having to do cross topic branch merges.

Thanks,
- Lars
