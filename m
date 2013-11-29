From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC] ALSA: add new alsa control byte extended
Date: Fri, 29 Nov 2013 13:14:59 +0530
Message-ID: <20131129074459.GE8834@intel.com>
References: <1385699397-18662-1-git-send-email-vinod.koul@intel.com>
 <s5hbo13fy6c.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CFC726080A
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 09:42:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hbo13fy6c.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 29, 2013 at 08:46:03AM +0100, Takashi Iwai wrote:
> At Fri, 29 Nov 2013 09:59:57 +0530,
> Vinod Koul wrote:
> > 
> > As discussed in the last Audio uConf we need to improve byte controls to allow
> > larger size data to be sent to DSPs  The modern DSPs require alsa byte controls
> > size which far exceeds the today 512bytes limit. In order for usermode to send
> > larger sizes (few 100s of KBs) along with size information we add extended byte
> > control interface which sends any size bytes parameter buffer for DSPs to use
> > Obviosly the size must be supported by the device and would be required to
> > inform the max size allowed for the control.
> 
> My primary question is -- must this be a control element?
I think yes. With controls we have an easy way to send parameter bytes and a
good support from both kernel and usermode, so leveraging that would make sense.
Mostly here the limit of 512 is hitting folks and IMO arbitrarily increasing
size doesn't help. For DSPs the algorithm coefficients can be larger 

Here i was thinking of just adding a new API in libraries to access this new
control type so that users can send large parameter blobs.

mixer_ctl_set_bytes_ext(struct mixer_ctl *ctl, const void *data, size_t len)
{
	struct snd_ctl_elem_value ev;

	/*usual init code */

	switch (ctl->info->type) {
	case SNDRV_CTL_ELEM_TYPE_BYTES_EXT:
		ev.value.bytes_ext.size = len;
		ev.value.bytes_ext.data = (__u64)data;
	break;
	default:
		return -EINVAL;
	}
	return ioctl(ctl->mixer->fd, SNDRV_CTL_IOCTL_ELEM_WRITE, &ev);
}

in kernel-side, the .put handler for kcontrol implemented in drivers would then
copy the userdata and send it to DSPs.

So in that respect this becomes quite simple to implement without adding lots of
parallel code and uses the infrastruture we already have.

> Why it can't be implemented in hwdep, for example?  In the past, we
> already implemented DSP firmware loader in the hwdep side.  It's a bit
> complicated (and limited) for a few driver usages, but it was more or
> less standardized for them.
> 
> My concern extending control element is that it'd need the rewrite in
> the whole control API in user-space side, too.  alsactl accesses the
> whole control elements and save/restore them, for example.
I am not sure I got your comment on rewriting control API. I though the union
here makes the ABI itself not to change so existing implementations which don't
use this new control type will not be impacted and for newer DSP we can add new
APIs like above to take benifit.

For save-restore part (though i havent looked at alsactl so might be wrong here)
yes, for this new control type, we would have to allocate buffers and then
destroy on restore. Eventually we will need to do so if we need alsactl suppport
for such devices. But shouldnt the change be less intrusive as it would be
limited to one control type.

> 
> Also, sharing scalar data and a reference pointer in the same union is
> a bit error-prone.
Can you elobrate a bit here and if we go down this path then how do we go about
it

One orthogonal question: why do we have bunch of deprecated pointers in the
unions and is anyone still using it? I guess this would be bit of history lesson
:)

--
~Vinod
> 
> 
> Takashi
> 
> > 
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > ---
> >  include/uapi/sound/asound.h |    8 +++++++-
> >  1 files changed, 7 insertions(+), 1 deletions(-)
> > 
> > diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
> > index 9fc6219..8c10359 100644
> > --- a/include/uapi/sound/asound.h
> > +++ b/include/uapi/sound/asound.h
> > @@ -782,7 +782,8 @@ typedef int __bitwise snd_ctl_elem_type_t;
> >  #define	SNDRV_CTL_ELEM_TYPE_BYTES	((__force snd_ctl_elem_type_t) 4) /* byte array */
> >  #define	SNDRV_CTL_ELEM_TYPE_IEC958	((__force snd_ctl_elem_type_t) 5) /* IEC958 (S/PDIF) setup */
> >  #define	SNDRV_CTL_ELEM_TYPE_INTEGER64	((__force snd_ctl_elem_type_t) 6) /* 64-bit integer type */
> > -#define	SNDRV_CTL_ELEM_TYPE_LAST	SNDRV_CTL_ELEM_TYPE_INTEGER64
> > +#define SNDRV_CTL_ELEM_TYPE_BYTES_EXT	((__force snd_ctl_elem_type_t) 7) /* bytes array extended */
> > +#define	SNDRV_CTL_ELEM_TYPE_LAST	SNDRV_CTL_ELEM_TYPE_BYTES_EXT
> >  
> >  typedef int __bitwise snd_ctl_elem_iface_t;
> >  #define	SNDRV_CTL_ELEM_IFACE_CARD	((__force snd_ctl_elem_iface_t) 0) /* global control */
> > @@ -891,6 +892,11 @@ struct snd_ctl_elem_value {
> >  			unsigned char data[512];
> >  			unsigned char *data_ptr;	/* obsoleted */
> >  		} bytes;
> > +		struct {
> > +			unsigned long size;	/* size of buffer */
> > +			__u64 data;	i	/* user data pointer */
> > +		} bytes_ext;
> > +
> >  		struct snd_aes_iec958 iec958;
> >  	} value;		/* RO */
> >  	struct timespec tstamp;
> > -- 
> > 1.7.0.4
> > 

-- 
