From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v7 07/11] ASoC: topology: Add support to
 configure existing physical DAI links
Date: Sat, 5 Nov 2016 13:35:15 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F88198D951@shsmsx102.ccr.corp.intel.com>
References: <cover.1478071138.git.mengdong.lin@linux.intel.com>
 <6bc394d703dcaf3afbb8bf35c8dc983360fc7cd0.1478071138.git.mengdong.lin@linux.intel.com>
 <20161104172221.wrqkh24nkih6rihm@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 99BFE26663B
 for <alsa-devel@alsa-project.org>; Sat,  5 Nov 2016 14:35:23 +0100 (CET)
In-Reply-To: <20161104172221.wrqkh24nkih6rihm@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, "mengdong.lin@linux.intel.com" <mengdong.lin@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "Shah, Hardik T" <hardik.t.shah@intel.com>, "Singh, Guneshwor O" <guneshwor.o.singh@intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "Koul,
 Vinod" <vinod.koul@intel.com>, "Ughreja,
 Rakesh A" <rakesh.a.ughreja@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Saturday, November 5, 2016 1:22 AM
> To: mengdong.lin@linux.intel.com
> Cc: alsa-devel@alsa-project.org; tiwai@suse.de;
> liam.r.girdwood@linux.intel.com; Shah, Hardik T <hardik.t.shah@intel.com>;
> Singh, Guneshwor O <guneshwor.o.singh@intel.com>; Koul, Vinod
> <vinod.koul@intel.com>; Ughreja, Rakesh A <rakesh.a.ughreja@intel.com>;
> Lin, Mengdong <mengdong.lin@intel.com>
> Subject: Re: [PATCH v7 07/11] ASoC: topology: Add support to configure
> existing physical DAI links
> 
> On Thu, Nov 03, 2016 at 01:04:27AM +0800, mengdong.lin@linux.intel.com
> wrote:
> 
> > +	name = strlen(cfg->name) ? cfg->name : NULL;
> > +	stream_name = strlen(cfg->stream_name) ? cfg->stream_name : NULL;
> 
> Please replace these with normal if statements.  Also, are we sure that we've
> sufficiently audited the input paths to ensure that the strings are always
> terminated?

Okay. I submitted patch to fix this -  ASoC: topology: Check name strings of physical DAI links.

This another minor ABI update, just a name change of a field and backward compatible.

Thanks again for your review!
Mengdong
