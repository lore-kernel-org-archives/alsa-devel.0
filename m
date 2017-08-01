From: "Eoff, Ullysses A" <ullysses.a.eoff@intel.com>
Subject: RE: [PATCH v2] ASoC: Intel: Reset hw_ptr on resume trigger
Date: Tue, 1 Aug 2017 04:32:56 +0000
Message-ID: <8B5BDC21C48FAF4CA5D7E3FE1A63A9087407DE4D@ORSMSX111.amr.corp.intel.com>
References: <20170731104734.5776-1-cychiang@chromium.org>
 <20170801033006.GL3053@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170801033006.GL3053@localhost>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Koul, Vinod" <vinod.koul@intel.com>, Cheng-Yi Chiang <cychiang@chromium.org>, "Jie, Yang" <yang.jie@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This patch was originally submitted in the context of the ChromiumOS kernel 3.10 for BYT (https://groups.google.com/a/chromium.org/forum/#!topic/chromium-os-reviews/AsoBhfHzQg8).


> -----Original Message-----
> From: Koul, Vinod
> Sent: Monday, July 31, 2017 8:30 PM
> To: Cheng-Yi Chiang <cychiang@chromium.org>; Jie, Yang <yang.jie@intel.com>
> Cc: linux-kernel@vger.kernel.org; Liam Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>; Jaroslav Kysela
> <perex@perex.cz>; Takashi Iwai <tiwai@suse.com>; Eoff, Ullysses A <ullysses.a.eoff@intel.com>; alsa-devel@alsa-project.org
> Subject: Re: [PATCH v2] ASoC: Intel: Reset hw_ptr on resume trigger
> 
> On Mon, Jul 31, 2017 at 06:47:34PM +0800, Cheng-Yi Chiang wrote:
> > From: "U. Artie Eoff" <ullysses.a.eoff@intel.com>
> >
> > Reset the hw_ptr before queuing the restore_stream_context
> > work to eradicate a nasty white audio noise on resume.
> 
> Liam, Jie? This on legacy BYT driver..
> 
> >
> > Tested-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > Signed-off-by: U. Artie Eoff <ullysses.a.eoff@intel.com>
> > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > ---
> >  sound/soc/intel/baytrail/sst-baytrail-pcm.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/intel/baytrail/sst-baytrail-pcm.c b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
> > index 4765ad474544..e0db7070cd42 100644
> > --- a/sound/soc/intel/baytrail/sst-baytrail-pcm.c
> > +++ b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
> > @@ -187,8 +187,10 @@ static int sst_byt_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
> >  		sst_byt_stream_start(byt, pcm_data->stream, 0);
> >  		break;
> >  	case SNDRV_PCM_TRIGGER_RESUME:
> > -		if (pdata->restore_stream == true)
> > +		if (pdata->restore_stream == true) {
> > +			pcm_data->hw_ptr = 0;
> >  			schedule_work(&pcm_data->work);
> > +		}
> >  		else
> >  			sst_byt_stream_resume(byt, pcm_data->stream);
> >  		break;
> > --
> > 2.12.2
> >
> 
> --
> ~Vinod
