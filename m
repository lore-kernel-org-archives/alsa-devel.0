From: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Subject: Re: [PATCH v5] ASoC: TSCS42xx: Add support for Tempo
 Semiconductor's TSCS42xx audio CODEC
Date: Tue, 12 Dec 2017 10:35:34 -0600
Message-ID: <20171212163533.hna2oqlbh5oouwvs@localhost.localdomain>
References: <20171211195403.3irxp7g3n326ub3g@localhost.localdomain>
 <20171212130401.nugvjnko6x3c3apn@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f193.google.com (mail-ot0-f193.google.com
 [74.125.82.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E2CF266DF0
 for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2017 17:35:45 +0100 (CET)
Received: by mail-ot0-f193.google.com with SMTP id y10so18285899otg.10
 for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2017 08:35:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171212130401.nugvjnko6x3c3apn@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 12, 2017 at 01:04:01PM +0000, Charles Keepax wrote:
> On Mon, Dec 11, 2017 at 01:54:25PM -0600, Steven Eckhoff wrote:
> > Currently there is no support for the TSCS42xx audio CODEC.
> > 
> > Add support for it.
> > 
> > v5 attempts to address all issues raised in the previous reviews.
> > 
> > Thank you to everyone who has invested their time reviewing these
> > patches.
> > 
> > Acked-by: Philippe Ombredanne <pombredanne@nexb.com>
> > Signed-off-by: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
> > ---
> > +int bytes_tlv_callback(struct snd_kcontrol *kcontrol, int op_flag,
> > +	unsigned int size, unsigned int __user *tlv)
> > +{
> > +	struct tscs_dsp_ctl *ctl =
> > +		(struct tscs_dsp_ctl *)kcontrol->private_value;
> > +	struct soc_bytes_ext *params = &ctl->bytes_ext;
> > +	unsigned int count = size < params->max ? size : params->max;
> > +	int ret = -ENXIO;
> > +
> > +	switch (op_flag) {
> > +	case SNDRV_CTL_TLV_OP_READ:
> > +		if (params->get)
> > +			ret = params->get(kcontrol, tlv, count);
> > +		break;
> > +	case SNDRV_CTL_TLV_OP_WRITE:
> > +		if (params->put)
> > +			ret = params->put(kcontrol, tlv, count);
> > +		break;
> > +	}
> > +	return ret;
> > +}
> 
> Should this function be removed, I am assuming it is a hang over
> from the earlier TLV implementation?
> 
> Thanks,
> Charles

Thanks for the review! bytes_tlv_callback will be removed in the next
version.
