From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH v2 4/8] ASoC: topology: ABI - Add name
 element to snd_soc_tplg_stream
Date: Tue, 6 Oct 2015 15:16:30 +0000
Message-ID: <1444144590.25504.27.camel@intel.com>
References: <cover.1443605139.git.mengdong.lin@intel.com>
 <08b095d38f59c43690daaa45e1d201f367812228.1443605139.git.mengdong.lin@intel.com>
 <20151002165907.GU12635@sirena.org.uk> <1443809055.10986.10.camel@loki>
 <F46914AEC2663F4A9BB62374E5EEF8F84B84FF3F@shsmsx102.ccr.corp.intel.com>
 <20151006103403.GH12635@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 83A692655A5
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 17:17:04 +0200 (CEST)
In-Reply-To: <20151006103403.GH12635@sirena.org.uk>
Content-Language: en-US
Content-ID: <D01A7B74A669514C991C49DCC59C8641@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "broonie@kernel.org" <broonie@kernel.org>, "Lin, Mengdong" <mengdong.lin@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "Kp,
 Jeeja" <jeeja.kp@intel.com>, "Prusty,
 Subhransu S" <subhransu.s.prusty@intel.com>, "Patel,
 Vedang" <vedang.patel@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2015-10-06 at 11:34 +0100, Mark Brown wrote:
> On Tue, Oct 06, 2015 at 08:55:58AM +0000, Lin, Mengdong wrote:
> 
> > > > OK, so this means that every DAI link name is going to become an ABI
> > > > too if there's a topology in there.  Not a problem but we'll need to
> > > > watch out for that on review...  I wonder if I can make some automated
> > > > checker thing.
> 
> > Do you mean we need to check if a DAI link name is already used, or if it's a
> > valid string?
> 
> No, I mean that if someone changes a name it'll invalidate topology
> files that reference that name.

Shouldn't this sort be checked in the alsa-lib while building the topology. It should
validate the names, graph and complete only when stuff is right.

-- 
~Vinod
