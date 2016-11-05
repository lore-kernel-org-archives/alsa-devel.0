From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v7 11/11] ASoC: topology: ABI - Add voice
 wake up flag for DAI links
Date: Sat, 5 Nov 2016 13:35:14 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F88198D94C@shsmsx102.ccr.corp.intel.com>
References: <cover.1478071138.git.mengdong.lin@linux.intel.com>
 <4ec58db3621474cd8acf664483b18c30628f6cad.1478071138.git.mengdong.lin@linux.intel.com>
 <20161104173616.iqeuhkm7wwfzc5e2@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 7085726647B
 for <alsa-devel@alsa-project.org>; Sat,  5 Nov 2016 14:35:20 +0100 (CET)
In-Reply-To: <20161104173616.iqeuhkm7wwfzc5e2@sirena.org.uk>
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
> Sent: Saturday, November 5, 2016 1:36 AM
> To: mengdong.lin@linux.intel.com
> Cc: alsa-devel@alsa-project.org; tiwai@suse.de;
> liam.r.girdwood@linux.intel.com; Shah, Hardik T <hardik.t.shah@intel.com>;
> Singh, Guneshwor O <guneshwor.o.singh@intel.com>; Koul, Vinod
> <vinod.koul@intel.com>; Ughreja, Rakesh A <rakesh.a.ughreja@intel.com>;
> Lin, Mengdong <mengdong.lin@intel.com>
> Subject: Re: [PATCH v7 11/11] ASoC: topology: ABI - Add voice wake up flag
> for DAI links
> 
> On Thu, Nov 03, 2016 at 01:05:32AM +0800, mengdong.lin@linux.intel.com
> wrote:
> > From: Mengdong Lin <mengdong.lin@linux.intel.com>
> >
> > Add a new flag bit SND_SOC_TPLG_LNK_FLGBIT_VOICE_WAKEUP to link
> flags.
> > If a link is used for voice wake up, users can set this flag bit and
> > topology will set the link's 'ignore_suspend' to true.
> 
> So, as we discussed in person yesterday I'm not 100% convinced about the
> name here - there are other applications that might want to use this facility
> like other triggers or some sort of passthrough monitoring.
> I'm drawing a bit of blank on better names right now...  I'm going to apply
> this but we should continue to think about renaming.

Okay. We'll rename this once we find a better name.

Thanks
Mengdong
