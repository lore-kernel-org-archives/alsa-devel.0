From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH v2 4/8] ASoC: topology: ABI - Add name
 element to snd_soc_tplg_stream
Date: Fri, 02 Oct 2015 19:04:15 +0100
Message-ID: <1443809055.10986.10.camel@loki>
References: <cover.1443605139.git.mengdong.lin@intel.com>
 <08b095d38f59c43690daaa45e1d201f367812228.1443605139.git.mengdong.lin@intel.com>
 <20151002165907.GU12635@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BC8C260668
 for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2015 20:04:28 +0200 (CEST)
In-Reply-To: <20151002165907.GU12635@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, mengdong.lin@intel.com, vinod.koul@intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com, vedang.patel@intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2015-10-02 at 17:59 +0100, Mark Brown wrote:
> On Wed, Sep 30, 2015 at 05:31:34PM +0800, mengdong.lin@intel.com wrote:
> > From: Vedang Patel <vedang.patel@intel.com>
> > 
> > For codec-codec links, this struct will be mapped to the DAI links's
> > params, which is struct snd_soc_pcm_stream and it needs a stream name.
> 
> OK, so this means that every DAI link name is going to become an ABI
> too if there's a topology in there.  Not a problem but we'll need to
> watch out for that on review...  I wonder if I can make some automated
> checker thing.

Probably good to discuss at ELCE as there may be other things that can
be auto-checked too ....

Liam
