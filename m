From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v6 04/11] ASoC: topology: ABI - Add flags
 and private data to PCM
Date: Wed, 2 Nov 2016 17:13:17 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F88198B58A@shsmsx102.ccr.corp.intel.com>
References: <cover.1476166990.git.mengdong.lin@linux.intel.com>
 <ca7df25320660c431215fab29e74727029048702.1476166990.git.mengdong.lin@linux.intel.com>
 <20161029184301.i6nau4cmjy2vmmlr@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id E9B36266A39
 for <alsa-devel@alsa-project.org>; Wed,  2 Nov 2016 18:13:22 +0100 (CET)
In-Reply-To: <20161029184301.i6nau4cmjy2vmmlr@sirena.org.uk>
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
> Sent: Sunday, October 30, 2016 2:43 AM
 
> On Tue, Oct 11, 2016 at 02:37:26PM +0800, mengdong.lin@linux.intel.com
> wrote:
> 
> > +/* DAI link flags */
> > +#define SND_SOC_TPLG_LNK_FLGBIT_IGNORE_SUSPEND          (1 << 3)
> > +#define SND_SOC_TPLG_LNK_FLGBIT_IGNORE_POWERDOWN_TIME   (1 <<
> 4)
> 
> This still feels *really* ASoC specific - both suspend and pmdown_time are
> very much ASoC internal implementations of generic ideas about how and
> when to manage things.  They don't talk about what the intended effect is
> which makes things a bit more obscure if we come back and try to change
> the implementation later.  Why are you using these flags, and can we add
> *that* information to the topology file instead?

The flag IGNORE_SUSPEND is used by the link for voice wake up, there is a DMIC connected to the SOC on our platrform. I use a new flag VOICE_WAKEUP to replace it in the last patch of the v7 series. If this flag still seems not good, please overlook the last patch, and we can configure it in device drivers.

And IGNORE_POWERDOWN_TIME is to configure the ignore_pmdown_time of the link. Since it's ASoC specific, I removed it from ABI and device driver can configure it in callbacks.

Thanks
Mengdong
