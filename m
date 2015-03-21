From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH v3 2/2] ALSA: hda - Remove jack kctls
Date: Sat, 21 Mar 2015 00:23:36 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A901BDBB73@SHSMSX101.ccr.corp.intel.com>
References: <1426865953-1606-1-git-send-email-yang.jie@intel.com>
 <1426865953-1606-3-git-send-email-yang.jie@intel.com>
 <s5h8uerzljv.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 758E42604D9
 for <alsa-devel@alsa-project.org>; Sat, 21 Mar 2015 01:23:42 +0100 (CET)
In-Reply-To: <s5h8uerzljv.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Saturday, March 21, 2015 12:22 AM
> To: Jie, Yang
> Cc: broonie@kernel.org; alsa-devel@alsa-project.org; Girdwood, Liam R
> Subject: Re: [alsa-devel] [PATCH v3 2/2] ALSA: hda - Remove jack kctls
> 
> At Fri, 20 Mar 2015 23:39:13 +0800,
> Jie Yang wrote:
> >
> > @@ -337,20 +335,16 @@ void snd_hda_jack_report_sync(struct
> hda_codec *codec)
> >  	jack = codec->jacktbl.list;
> >  	for (i = 0; i < codec->jacktbl.used; i++, jack++)
> >  		if (jack->nid) {
> > -			if (!jack->kctl || jack->block_report)
> > +			if (!jack->jack || jack->block_report)
> >  				continue;
> >  			state = get_jack_plug_state(jack->pin_sense);
> > -			snd_kctl_jack_report(codec->bus->card, jack->kctl,
> state);
> > -#ifdef CONFIG_SND_HDA_INPUT_JACK
> >  			if (jack->jack)
> 
> The check here is superfluous, as you already added in the above.
[Keyon] got it.
> 
> 
> thanks,
> 
> Takashi
