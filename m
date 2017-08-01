From: Cheng-yi Chiang <cychiang@chromium.org>
Subject: Re: [PATCH v2] ASoC: Intel: Reset hw_ptr on resume
	trigger
Date: Tue, 1 Aug 2017 12:42:35 +0800
Message-ID: <CAFv8Nw+QN8dSY-Pb_a5BX0PY1uQPkxP5U9uT_6+7bLe+W+PkEw@mail.gmail.com>
References: <20170731104734.5776-1-cychiang@chromium.org>
 <20170801033006.GL3053@localhost>
 <8B5BDC21C48FAF4CA5D7E3FE1A63A9087407DE4D@ORSMSX111.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f53.google.com (mail-it0-f53.google.com
 [209.85.214.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 1961B266D44
 for <alsa-devel@alsa-project.org>; Tue,  1 Aug 2017 06:43:07 +0200 (CEST)
Received: by mail-it0-f53.google.com with SMTP id 77so2036448itj.1
 for <alsa-devel@alsa-project.org>; Mon, 31 Jul 2017 21:43:07 -0700 (PDT)
In-Reply-To: <8B5BDC21C48FAF4CA5D7E3FE1A63A9087407DE4D@ORSMSX111.amr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Eoff, Ullysses A" <ullysses.a.eoff@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, "Koul, Vinod" <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Eoff, thank you for the patch and providing the context.
ChromiumOS now uses kernel 4.4 for BYT and I found that kernel 4.4 does not
have this patch.
We thought this should be useful in upstream.
Thanks!

On Tue, Aug 1, 2017 at 12:32 PM, Eoff, Ullysses A <ullysses.a.eoff@intel.com
> wrote:

> This patch was originally submitted in the context of the ChromiumOS
> kernel 3.10 for BYT (https://groups.google.com/a/
> chromium.org/forum/#!topic/chromium-os-reviews/AsoBhfHzQg8).
>
>
> > -----Original Message-----
> > From: Koul, Vinod
> > Sent: Monday, July 31, 2017 8:30 PM
> > To: Cheng-Yi Chiang <cychiang@chromium.org>; Jie, Yang <
> yang.jie@intel.com>
> > Cc: linux-kernel@vger.kernel.org; Liam Girdwood <lgirdwood@gmail.com>;
> Mark Brown <broonie@kernel.org>; Jaroslav Kysela
> > <perex@perex.cz>; Takashi Iwai <tiwai@suse.com>; Eoff, Ullysses A <
> ullysses.a.eoff@intel.com>; alsa-devel@alsa-project.org
> > Subject: Re: [PATCH v2] ASoC: Intel: Reset hw_ptr on resume trigger
> >
> > On Mon, Jul 31, 2017 at 06:47:34PM +0800, Cheng-Yi Chiang wrote:
> > > From: "U. Artie Eoff" <ullysses.a.eoff@intel.com>
> > >
> > > Reset the hw_ptr before queuing the restore_stream_context
> > > work to eradicate a nasty white audio noise on resume.
> >
> > Liam, Jie? This on legacy BYT driver..
> >
> > >
> > > Tested-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > > Signed-off-by: U. Artie Eoff <ullysses.a.eoff@intel.com>
> > > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > > ---
> > >  sound/soc/intel/baytrail/sst-baytrail-pcm.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/sound/soc/intel/baytrail/sst-baytrail-pcm.c
> b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
> > > index 4765ad474544..e0db7070cd42 100644
> > > --- a/sound/soc/intel/baytrail/sst-baytrail-pcm.c
> > > +++ b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
> > > @@ -187,8 +187,10 @@ static int sst_byt_pcm_trigger(struct
> snd_pcm_substream *substream, int cmd)
> > >             sst_byt_stream_start(byt, pcm_data->stream, 0);
> > >             break;
> > >     case SNDRV_PCM_TRIGGER_RESUME:
> > > -           if (pdata->restore_stream == true)
> > > +           if (pdata->restore_stream == true) {
> > > +                   pcm_data->hw_ptr = 0;
> > >                     schedule_work(&pcm_data->work);
> > > +           }
> > >             else
> > >                     sst_byt_stream_resume(byt, pcm_data->stream);
> > >             break;
> > > --
> > > 2.12.2
> > >
> >
> > --
> > ~Vinod
>
