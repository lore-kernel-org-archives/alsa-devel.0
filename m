From: Naveen M <naveen.m@intel.com>
Subject: Re: [PATCH 2/5] ASoC: Intel: Headset button support in
 broxton machine driver
Date: Fri, 6 Apr 2018 06:45:58 +0530
Message-ID: <20180406011548.GA4189@intel.com>
References: <1522817219-3750-1-git-send-email-naveen.m@intel.com>
 <1522817219-3750-3-git-send-email-naveen.m@intel.com>
 <20180406003033.GA234162@decatoncale.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id EEA962676D9
 for <alsa-devel@alsa-project.org>; Fri,  6 Apr 2018 03:16:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180406003033.GA234162@decatoncale.mtv.corp.google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Benson Leung <bleung@google.com>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, harshapriya.n@intel.com, broonie@kernel.org, bleung@chromium.org, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 05, 2018 at 05:30:33PM -0700, Benson Leung wrote:
> Hi Naveen,
> 
> On Wed, Apr 04, 2018 at 10:16:56AM +0530, Naveen Manohar wrote:
> > Patch adds headset button support for broxton machine driver
> > (bxt_da7219_max98357a).
> > 
> > Signed-off-by: Naveen Manohar <naveen.m@intel.com>
> > ---
> >  sound/soc/intel/boards/bxt_da7219_max98357a.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
> > index ce021a3..1c1e70c 100644
> > --- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
> > +++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
> > @@ -16,6 +16,7 @@
> >   * GNU General Public License for more details.
> >   */
> >  
> > +#include <linux/input.h>
> >  #include <linux/module.h>
> >  #include <linux/platform_device.h>
> >  #include <sound/core.h>
> > @@ -168,6 +169,7 @@ static int broxton_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
> >  static int broxton_da7219_codec_init(struct snd_soc_pcm_runtime *rtd)
> >  {
> >  	int ret;
> > +	struct snd_soc_jack *jack;
> >  	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> >  	struct snd_soc_component *component = rtd->codec_dai->component;
> >  
> > @@ -192,7 +194,12 @@ static int broxton_da7219_codec_init(struct snd_soc_pcm_runtime *rtd)
> >  		return ret;
> >  	}
> >  
> > -	da7219_aad_jack_det(component, &broxton_headset);
> > +	jack = &broxton_headset;
> > +	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_MEDIA);
> 
> I recently made a set of changes that replaced KEY_MEDIA usage for BTN_0
> with KEY_PLAYPAUSE. See https://lkml.org/lkml/2017/11/22/586
> 
> Since this patch may be destined for Chrome OS, you should definitely use
> KEY_PLAYPAUSE, as the Chrome OS user space doesn't respond to KEY_MEDIA but does
> respond to KEY_PLAYPAUSE.
> 
> Thanks,
> Benson
> 
Thanks for the review and update. Shall correct this in V2.
Also there are other machines which still use KEY_MEDIA - kbl_da7219_max98357a.c, cht_bsw_nau8824.c
Shall correct these too.
> -- 
> Benson Leung
> Staff Software Engineer
> Chrome OS Kernel
> Google Inc.
> bleung@google.com
> Chromium OS Project
> bleung@chromium.org



-- 
