From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH v2] ALSA: hda - Update chmap tlv to report
 sink's capability
Date: Mon, 4 Apr 2016 10:27:16 +0530
Message-ID: <20160404045715.GC25935@subhransu-desktop>
References: <1459505931-20012-1-git-send-email-subhransu.s.prusty@intel.com>
 <s5hzitdbjlz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 11BBA26074D
 for <alsa-devel@alsa-project.org>; Mon,  4 Apr 2016 06:57:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hzitdbjlz.wl-tiwai@suse.de>
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

On Fri, Apr 01, 2016 at 02:26:32PM +0200, Takashi Iwai wrote:
> On Fri, 01 Apr 2016 12:18:51 +0200,
> Subhransu S. Prusty wrote:
> > -			dst += 2;
> > -			size -= 8;
> > -			count += 8;
> > -			if (size < chs_bytes)
> > -				return -ENOMEM;
> > -			size -= chs_bytes;
> > -			count += chs_bytes;
> > -			chmap->ops.cea_alloc_to_tlv_chmap(chmap, cap,
> > -						tlv_chmap, chs);
> > -			if (copy_to_user(dst, tlv_chmap, chs_bytes))
> > -				return -EFAULT;
> > -			dst += chs;
> > -		}
> > -	}
> > +
> > +	if (size < 8)
> > +		return -ENOMEM;
> > +
> > +	spk_alloc = chmap->ops.get_spk_alloc(chmap->hdac, pcm_idx);
> > +	cap = get_cap_from_spk_alloc(spk_alloc);
> > +	chs = cap->channels;
> > +
> > +	chs_bytes = chs * 4;
> > +	type = chmap->ops.chmap_cea_alloc_validate_get_type(chmap, cap, chs);
> > +	if (type < 0)
> > +		return -ENODEV;
> > +
> > +	if (put_user(type, dst) ||
> > +	    put_user(chs_bytes, dst + 1))
> > +		return -EFAULT;
> > +
> > +	dst += 2;
> > +	size -= 8;
> > +	count += 8;
> > +	if (size < chs_bytes)
> > +		return -ENOMEM;
> > +
> > +	count += chs_bytes;
> > +	chmap->ops.cea_alloc_to_tlv_chmap(chmap, cap, tlv_chmap, chs);
> > +	if (copy_to_user(dst, tlv_chmap, chs_bytes))
> > +		return -EFAULT;
> > +
> >  	if (put_user(count, tlv + 1))
> >  		return -EFAULT;
> > +
> >  	return 0;
> 
> So, this change means that TLV returns only a single channel map
> corresponding to the given speaker bits?  This doesn't sound right.
> TLV should return the all possible channel maps the device are capable
> of.  A device with four channels can drive also two channels streams,
> too, for example.

Hi Takashi,

The device does report only the speaker allocation i.e. only the channels it
support. So I think it is good to return only a single channel map that best
matches the device's capability. As the device reports the channels it is
capable of, user should be able to set any number of channels in any order
looking at this map.

Please let me know if you are ok with this. Otherwise, I will change to what
you suggest.

Regards,
Subhransu

> 
> 
> Takashi

-- 
