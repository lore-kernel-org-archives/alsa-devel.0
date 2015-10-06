From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v2 4/8] ASoC: topology: ABI - Add name
 element to snd_soc_tplg_stream
Date: Tue, 6 Oct 2015 08:55:58 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F84B84FF3F@shsmsx102.ccr.corp.intel.com>
References: <cover.1443605139.git.mengdong.lin@intel.com>
 <08b095d38f59c43690daaa45e1d201f367812228.1443605139.git.mengdong.lin@intel.com>
 <20151002165907.GU12635@sirena.org.uk> <1443809055.10986.10.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id B0C83265053
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 10:56:03 +0200 (CEST)
In-Reply-To: <1443809055.10986.10.camel@loki>
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
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "Koul, Vinod" <vinod.koul@intel.com>, "Kp,
 Jeeja" <jeeja.kp@intel.com>, "Prusty,
 Subhransu S" <subhransu.s.prusty@intel.com>, "Patel,
 Vedang" <vedang.patel@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Liam Girdwood [mailto:liam.r.girdwood@linux.intel.com]
> Sent: Saturday, October 03, 2015 2:04 AM
> To: Mark Brown
> Cc: Lin, Mengdong; alsa-devel@alsa-project.org; tiwai@suse.de; Patel,
> Vedang; Prusty, Subhransu S; Koul, Vinod; Kp, Jeeja
> Subject: Re: [PATCH v2 4/8] ASoC: topology: ABI - Add name element to
> snd_soc_tplg_stream
> 
> On Fri, 2015-10-02 at 17:59 +0100, Mark Brown wrote:
> > On Wed, Sep 30, 2015 at 05:31:34PM +0800, mengdong.lin@intel.com
> wrote:
> > > From: Vedang Patel <vedang.patel@intel.com>
> > >
> > > For codec-codec links, this struct will be mapped to the DAI links's
> > > params, which is struct snd_soc_pcm_stream and it needs a stream
> name.
> >
> > OK, so this means that every DAI link name is going to become an ABI
> > too if there's a topology in there.  Not a problem but we'll need to
> > watch out for that on review...  I wonder if I can make some automated
> > checker thing.

Hi Mark,

Do you mean we need to check if a DAI link name is already used, or if it's a valid string?
Is there any naming convention for a DAI link?

Thanks
Mengdong

> Probably good to discuss at ELCE as there may be other things that can be
> auto-checked too ....
> 
> Liam
