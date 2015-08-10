From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [RFC PATCH 00/10] ASoC: support adding PCM
 dynamically from topology
Date: Mon, 10 Aug 2015 14:39:40 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8480B9969@SHSMSX101.ccr.corp.intel.com>
References: <1439186973-913-1-git-send-email-mengdong.lin@intel.com>
 <20150810115015.GA10748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 982EA265D88
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2015 16:40:05 +0200 (CEST)
In-Reply-To: <20150810115015.GA10748@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Monday, August 10, 2015 7:50 PM
> To: Lin, Mengdong
> Cc: alsa-devel@alsa-project.org; tiwai@suse.de; Girdwood, Liam R
> Subject: Re: [RFC PATCH 00/10] ASoC: support adding PCM dynamically from
> topology
> 
> On Mon, Aug 10, 2015 at 02:09:33PM +0800, mengdong.lin@intel.com wrote:
> 
> > Mengdong Lin (10):
> >   ASoC: change the PCM runtime array to a list
> >   ASoC: Define soc_init_dai_link() to wrap link intialization.
> >   ASoC: soc_bind_dai_link() change 2nd argument to DAI link pointer
> >   ASoC: implement DAI links in a list.
> >   ASoC: Add support for dummy DAI links and PCM runtimes
> >   ASoC: bind new DAI links after probing components.
> >   ASoC: support adding a DAI dynamically
> >   ASoC: topology: change pass number of DAI smaller than graph
> >   ASoC: Topology: change stream formats to bitwise flag
> >   ASOC: topology: Add PCM DAIs dynamically when loading them
> 
> Please when submitting patch serieses use something like git send-email to
> make them appear as a thread in reply to the cover letter.  Please also make
> sure that PATCH is the first thing in the [] to make it easier to spot messages
> and try to keep your subject lines consistant with the style of the subsystem
> (and at least internally consistent within your series).

Sorry for the format/style errors. 
I've revised the v2 patches as you suggested. Please review.

Thanks
Mengdong
