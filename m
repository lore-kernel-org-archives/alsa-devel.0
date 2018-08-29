From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 2/3] ASoC: cs4265: Add native 32bit I2S
 transport
Date: Wed, 29 Aug 2018 09:22:18 +0100
Message-ID: <20180829082218.GY32322@imbe.wolfsonmicro.main>
References: <20180826225844.13754-1-flatmax@flatmax.org>
 <20180826225844.13754-2-flatmax@flatmax.org>
 <20180827082843.GU32322@imbe.wolfsonmicro.main>
 <20180828185652.GJ2414@sirena.org.uk>
 <cbf11383-f9f5-22a3-6fa0-e097462716f2@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 54834267657
 for <alsa-devel@alsa-project.org>; Wed, 29 Aug 2018 10:22:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <cbf11383-f9f5-22a3-6fa0-e097462716f2@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Flax <flatmax@flatmax.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 29, 2018 at 09:31:31AM +1000, Matt Flax wrote:
> 
> 
> On 29/08/18 04:56, Mark Brown wrote:
> >On Mon, Aug 27, 2018 at 09:28:43AM +0100, Charles Keepax wrote:
> >
> >>Are you sure this is correct? The datasheet for the part only
> >>says it supports up to 24-bit audio and I thought the defines
> >>SNDRV_PCM_FMTBIT_S24_LE and U24 are expected to have 32-bits
> >>in the slot whilst on the bus.
> >No, they're not.  They're expected to be 32 bit in memory and 24 bit on
> >the bus.
> >
> 
> If this is the case, then I would assume that 32bit formats are
> forced through ALSA plughw.
> 
> If operation is forced through plughw, then this patch is necessary
> to allow native 32 operation on the bus. The codec drops the 8 LSBs
> during operation as it reads/writes the 24 MSBs.
> 

Yeah apologies for the confusion I imagine this patch is then
fine.

Thanks,
Charles
