From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: [PATCH 02/19] ASoC: sst_platform: add cpu dai
 driver for moorestown platform
Date: Thu, 5 May 2011 12:48:06 +0800
Message-ID: <20110505044806.GH10907@qtel.sh.intel.com>
References: <20110504133756.32443.6282.stgit@localhost>
	<20110504134504.32443.60814.stgit@localhost>
	<1304565781.20953.41.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F0CC10393D
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 06:49:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1304565781.20953.41.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, "Wang, Xingchao" <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 05, 2011 at 11:23:01AM +0800, Koul, Vinod wrote:
> On Wed, 2011-05-04 at 19:15 +0530, Lu, Guanqun wrote:
> > Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
> > ---
> >  sound/soc/mid-x86/sst_platform.c |   14 ++++++++++++++
> >  1 files changed, 14 insertions(+), 0 deletions(-)
> > 
> > diff --git a/sound/soc/mid-x86/sst_platform.c b/sound/soc/mid-x86/sst_platform.c
> > index 139db15..ce0ac3c 100644
> > --- a/sound/soc/mid-x86/sst_platform.c
> > +++ b/sound/soc/mid-x86/sst_platform.c
> > @@ -110,6 +110,20 @@ struct snd_soc_dai_driver sst_platform_dai[] = {
> >  		.formats = SNDRV_PCM_FMTBIT_S24_LE,
> >  	},
> >  },
> > +{
> > +	.name = "mrst-cpu-pcm2",
> > +	.id = 4,
> > +	.playback = {
> > +		.channels_min = 1,
> > +		.channels_max = 2,
> > +		.rates = (SNDRV_PCM_RATE_48000 |
> > +			  SNDRV_PCM_RATE_44100 |
> > +			  SNDRV_PCM_RATE_8000),
> > +		.formats = (SNDRV_PCM_FMTBIT_S16 | SNDRV_PCM_FMTBIT_U16 |
> > +			    SNDRV_PCM_FMTBIT_S24 | SNDRV_PCM_FMTBIT_U24 |
> > +			    SNDRV_PCM_FMTBIT_S32 | SNDRV_PCM_FMTBIT_U32),
> > +	},
> > +},
> Nope, We cant keep on adding these DAIs for every new platform :(
> Even the current way is not best as it just creates 4 instance of DAI
> where we could have done with two (as they have same properties)
> I would use the current headset DAI and change the ops there, or create
> a new one for each type so that it can be reused.

So how about this one (not tested yet):

diff --git a/sound/soc/mid-x86/sst_platform.c b/sound/soc/mid-x86/sst_platform.c
index 7985cfe..78660e4 100644
--- a/sound/soc/mid-x86/sst_platform.c
+++ b/sound/soc/mid-x86/sst_platform.c
@@ -68,16 +68,21 @@ struct snd_soc_dai_driver sst_platform_dai[] = {
        .name = "Headset-cpu-dai",
        .id = 0,
        .playback = {
-               .channels_min = SST_STEREO,
+               .channels_min = SST_MONO,
                .channels_max = SST_STEREO,
-               .rates = SNDRV_PCM_RATE_48000,
-               .formats = SNDRV_PCM_FMTBIT_S24_LE,
+               .rates = (SNDRV_PCM_RATE_48000 |
+                         SNDRV_PCM_RATE_44100 |
+                         SNDRV_PCM_RATE_8000),
+               .formats = (SNDRV_PCM_FMTBIT_S16 | SNDRV_PCM_FMTBIT_U16 |
+                           SNDRV_PCM_FMTBIT_S24 | SNDRV_PCM_FMTBIT_U24 |
+                           SNDRV_PCM_FMTBIT_S32 | SNDRV_PCM_FMTBIT_U32),
        },
        .capture = {
                .channels_min = 1,
                .channels_max = 5,
                .rates = SNDRV_PCM_RATE_48000,
-               .formats = SNDRV_PCM_FMTBIT_S24_LE,
+               .formats = (SNDRV_PCM_FMTBIT_S16 | SNDRV_PCM_FMTBIT_U16 |
+                           SNDRV_PCM_FMTBIT_S24_LE),
        },
 },
 {

-- 
guanqun
