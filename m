From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH] davinci-evm: extend it to support DM81xx
	and derivatives
Date: Thu, 13 Jul 2017 13:31:25 +0530
Message-ID: <c439ed79-1961-1781-1853-bcdc758592d3@ti.com>
References: <20170712124318.39e5941b49d0da45602bd1c1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C1EE266B7E
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 10:01:29 +0200 (CEST)
In-Reply-To: <20170712124318.39e5941b49d0da45602bd1c1@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vitaly Wool <vitalywool@gmail.com>, Mark Brown <broonie@kernel.org>, Kevin Hilman <khilman@kernel.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Vladimir Barinov <vbarinov@embeddedalley.com>, alsa-devel@alsa-project.org, Jyri Sarah <jsarha@ti.com>, trini@konsulko.com
List-Id: alsa-devel@alsa-project.org

+ Peter & Jyri

Hi Vitaly,

On Wednesday 12 July 2017 04:13 PM, Vitaly Wool wrote:
> Having worked closely with TI DM8148/DM8168 EVMs I came across
> many derivatives of these boards which didn't use the standard
> codec but had something like wm897x instead. They all would fit
> davinci-evm driver nicely if it had support for audio CPU clock
> divisor and slightly more generic naming. So this patch adds
> support for reading CPU divisor from a DT and slightly changes
> names of helper/init functions to be more generic.
> 
> It also adds support for DaVinci boards that use wm8978 codec.
> 
> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>

While there are some users of davinci-evm.c, I think a majority are
using simple-audio-card instead. Curious on why you chose not to use
that. It sounds like codec is not the bitclock and frame-sync master in
your case. Did that end up creating issues ?

Thanks,
Sekhar
