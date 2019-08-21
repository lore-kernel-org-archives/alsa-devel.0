From: "Uimonen, Jaska" <jaska.uimonen@intel.com>
Subject: Re: [PATCH] ASoC: SOF: topology: fix get control data
 return type and arguments
Date: Wed, 21 Aug 2019 13:30:02 +0000
Message-ID: <E2FAA01B96908D4ABFB182B6E1AD75D6A1FC15F7@IRSMSX102.ger.corp.intel.com>
References: <20190821123252.30920-1-jaska.uimonen@linux.intel.com>
 <20190821125956.GJ5128@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B353FF80157
 for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2019 15:30:12 +0200 (CEST)
In-Reply-To: <20190821125956.GJ5128@sirena.co.uk>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>, Jaska Uimonen <jaska.uimonen@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Wednesday, August 21, 2019 4:00 PM
> To: Jaska Uimonen <jaska.uimonen@linux.intel.com>
> Cc: alsa-devel@alsa-project.org; Uimonen, Jaska <jaska.uimonen@intel.com>
> Subject: Re: [PATCH] ASoC: SOF: topology: fix get control data return type and
> arguments
> 
> On Wed, Aug 21, 2019 at 03:32:52PM +0300, Jaska Uimonen wrote:
> 
> > +static int sof_get_control_data(struct snd_sof_dev *sdev,
> > +				struct snd_soc_dapm_widget *widget,
> > +				struct sof_widget_data *wdata,
> > +				size_t *size)
> >  {
> >  	const struct snd_kcontrol_new *kc;
> >  	struct soc_mixer_control *sm;
> >  	struct soc_bytes_ext *sbe;
> >  	struct soc_enum *se;
> > -	size_t size = 0;
> >  	int i;
> 
> 
> > -		size += wdata[i].pdata->size;
> > +		/* don't accept 0 size for data */
> > +		if (!wdata[i].pdata->size)
> > +			return -EINVAL;
> 
> This should really be a separate change.
[Uimonen, Jaska] 
Ok will remove from this patch.
> 
> > +
> > +		*size += wdata[i].pdata->size;
> 
> We appear to be requiring that the size passed in is zero initialized
> which is a bit unusual and seems likely to break even if it happens to
> work right now.
[Uimonen, Jaska] 
Same comments I got from Pierre, obviously I'm not very good listener.
Will initialize size to 0.
---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
