From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2 2/3] ASoC: cs4265: Add native 32bit I2S
 transport [UNSCANNED]
Date: Thu, 30 Aug 2018 17:43:12 +0100
Message-ID: <20180830164312.GF32322@imbe.wolfsonmicro.main>
References: <20180829233802.22032-1-flatmax@flatmax.org>
 <20180829233802.22032-2-flatmax@flatmax.org>
 <20180830154140.GG7301@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 40CA0267668
 for <alsa-devel@alsa-project.org>; Thu, 30 Aug 2018 18:43:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180830154140.GG7301@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Matt Flax <flatmax@flatmax.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 30, 2018 at 04:41:40PM +0100, Mark Brown wrote:
> On Thu, Aug 30, 2018 at 09:38:01AM +1000, Matt Flax wrote:
> > The cs4265 uses 32 bit transport on the I2S bus. This patch enables native
> > 32 bit mode for machine drivers which use this sound card driver.
> > 
> > Signed-off-by: Matt Flax <flatmax@flatmax.org>
> > ---
> > 
> > No changes from v1, however have tested the intended functionality and
> > list discussion had firmed up its purpose.
> > ---
> 
> Charles?

I think this one looks fine to me:

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Only slightly doubt I had was that the CODEC doesn't actually
support 32bit only 24bit. It will however happily accept the
32-bit from the bus you just loose some precision whilst playing
it, so feels like that is basically the same as supporting it to
me. Unless I have missed something again :-)

Thanks,
Charles
