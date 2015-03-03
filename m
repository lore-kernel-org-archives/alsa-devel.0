From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: omap-pcm: Correct dma mask
Date: Tue, 3 Mar 2015 16:36:34 +0200
Message-ID: <54F5C6F2.60309@ti.com>
References: <1425382694-30424-1-git-send-email-peter.ujfalusi@ti.com>
 <20150303140848.GP21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 12A0426153F
 for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2015 15:36:40 +0100 (CET)
In-Reply-To: <20150303140848.GP21293@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Mark,

On 03/03/2015 04:08 PM, Mark Brown wrote:
> On Tue, Mar 03, 2015 at 01:38:14PM +0200, Peter Ujfalusi wrote:
>> DMA_BIT_MASK of 64 is not valid dma address mask for OMAPs, it should be
>> set to 32.
>> The 64 was introduced by commit (in 2009):
>> a152ff24b978 ASoC: OMAP: Make DMA 64 aligned
> =

> Applied, thanks.

Would it be possible to add this tags to the patch, I forgot it:

Reported-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>

Thanks,
P=E9ter
