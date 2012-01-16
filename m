From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH 1/2] ASoC: Allow drivers to specify how
 many bits are significant on a DAI
Date: Mon, 16 Jan 2012 22:26:11 +0000
Message-ID: <CABS+qY1rcDjxEcbR6df5mdV4n105Cf_Sis5QOOV6zZG+Sx34gg@mail.gmail.com>
References: <1326739267-9678-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog102.obsmtp.com (na3sys009aog102.obsmtp.com
	[74.125.149.69]) by alsa0.perex.cz (Postfix) with ESMTP id C7A94243DF
	for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2012 23:26:13 +0100 (CET)
Received: by mail-vw0-f48.google.com with SMTP id fr13so1055430vbb.7
	for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2012 14:26:12 -0800 (PST)
In-Reply-To: <1326739267-9678-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On 16 January 2012 18:41, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> Most devices accept data in formats that don't correspond directly to
> their internal format. ALSA allows us to set a msbits constraint which
> tells userspace about this in case it finds it useful (for example, in
> order to avoid wasting effort dithering bits that will be ignored when
> raising the sample size of data) so provide a mechanism for drivers to
> specify the number of bits that are actually significant on a DAI and
> add the appropriate constraints along with all the others.
>
> This is done slightly awkwardly as the constraint is specified per sample
> size - we loop over every possible sample size, including ones that the
> device doesn't support and including ones that have fewer bits than are
> actually used, but this is harmless as the upper layers do the right thing
> in these cases.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---

Acked-by: Liam Girdwood <lrg@ti.com>

Btw, will you be reworking Peter's patch ?

Liam
