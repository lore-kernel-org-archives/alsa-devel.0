From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH v3 08/15] ASoC: hdac_hdmi: Create
 widget/route based on nodes enumerated
Date: Tue, 8 Dec 2015 16:58:56 +0530
Message-ID: <20151208112856.GB5850@subhransu-desktop>
References: <1449523078-4311-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449523469-4395-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449523469-4395-8-git-send-email-subhransu.s.prusty@intel.com>
 <s5hzixmkzgu.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id DF95B265D12
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 06:58:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hzixmkzgu.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: patches.audio@intel.com, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 07, 2015 at 05:14:41PM +0100, Takashi Iwai wrote:
> On Mon, 07 Dec 2015 22:24:22 +0100,
> Subhransu S. Prusty wrote:
> >  	return pin->num_mux_nids;
> >  }
> >  
> > -static void hdac_hdmi_fill_widget_info(struct snd_soc_dapm_widget *w,
> > -				enum snd_soc_dapm_type id,
> > -				const char *wname, const char *stream)
> > +static void hdac_hdmi_fill_widget_info(struct device *dev,
> > +				struct snd_soc_dapm_widget *w,
> > +				enum snd_soc_dapm_type id, void *priv,
> > +				const char *wname, const char *stream,
> > +				struct snd_kcontrol_new *wc, int numkc)
> >  {
> >  	w->id = id;
> > -	w->name = wname;
> > +	w->name = devm_kstrdup(dev, wname, GFP_KERNEL);
> 
> Missing NULL check.  Not only here but in handful places in this
> patch.

Sorry to have missed to add check on these. Will fix them.

Regards,
Subhransu
> 
> 
> Takashi

-- 
