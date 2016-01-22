From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] amixer: add support for TLV byte control
	read
Date: Fri, 22 Jan 2016 13:16:23 +0530
Message-ID: <20160122074623.GC11130@localhost>
References: <1453441612-29902-1-git-send-email-vinod.koul@intel.com>
 <s5hoace5e75.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id CB1602604BE
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2016 08:42:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hoace5e75.wl-tiwai@suse.de>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 22, 2016 at 07:19:10AM +0100, Takashi Iwai wrote:
> On Fri, 22 Jan 2016 06:46:52 +0100,
> Vinod Koul wrote:
> > 
> > TLV byte control are new type of byte controls added in kernel where
> > controls can have large sizes.
> >
> > For these controls querying with 4096 size fails, so use the queried size to
> > read the control
> > 
> > This fixes the crash with current cget/contents on these type of controls
> 
> Hmm...  Theoretically the TLV size and the element size are
> independent.  So, it's not good to check only the type being
> SND_CTL_ELEM_TYPE_BYTES.  This can be used legally by other cases,
> too.
> 
> Basically it is an abuse in ASoC side to return the size of
> TLV by the element's info.  Usually such value would lead to crash,
> but the unique point of ASoC ext bytes ctl is that it doesn't have RW
> accesses but only TLV_RW accesses.

But isn't that already checked? Since we are in the code which will be
executed only for tlv as snd_ctl_elem_info_is_tlv_readable() ensures that.
So this is only for tlv + bytes ...

> 
> So, instead of only checking the type being BYTES, check the
> accesses.  Only when all these conditions are met, we may take the
> count as TLV (element) size.  (And still we should have the sanity
> check of the value, too.)
> 
> Yet, this isn't a really "fix" for the crash.  Even without the patch
> it shouldn't crash -- it should receive 4096 bytes, and tries to
> decode.  Where did you get the crash exactly?

in alsa-lib snd_ctl_hw_elem_tlv() when it tries to do memcpy for tlv read.
But the crash is caused as tlv read is large and we have only 4096 size
buffer, so we ensure we give right size buffer here

-- 
~Vinod
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > ---
> >  amixer/amixer.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> > 
> > diff --git a/amixer/amixer.c b/amixer/amixer.c
> > index db1849333da3..cfe13592347f 100644
> > --- a/amixer/amixer.c
> > +++ b/amixer/amixer.c
> > @@ -588,7 +588,7 @@ static int show_control(const char *space, snd_hctl_elem_t *elem,
> >  			int level)
> >  {
> >  	int err;
> > -	unsigned int item, idx, count, *tlv;
> > +	unsigned int item, idx, count, *tlv, tlv_sz;
> >  	snd_ctl_elem_type_t type;
> >  	snd_ctl_elem_id_t *id;
> >  	snd_ctl_elem_info_t *info;
> > @@ -682,13 +682,20 @@ static int show_control(const char *space, snd_hctl_elem_t *elem,
> >  	      __skip_read:
> >  		if (!snd_ctl_elem_info_is_tlv_readable(info))
> >  			goto __skip_tlv;
> > -		tlv = malloc(4096);
> > -		if ((err = snd_hctl_elem_tlv_read(elem, tlv, 4096)) < 0) {
> > +
> > +		if (type == SND_CTL_ELEM_TYPE_BYTES)
> > +			tlv_sz = count + 2 * sizeof(unsigned int);
> > +		else
> > +			tlv_sz = 4096;
> > +
> > +		tlv = malloc(tlv_sz);
> > +
> > +		if ((err = snd_hctl_elem_tlv_read(elem, tlv, tlv_sz)) < 0) {
> >  			error("Control %s element TLV read error: %s\n", card, snd_strerror(err));
> >  			free(tlv);
> >  			return err;
> >  		}
> > -		decode_tlv(strlen(space), tlv, 4096);
> > +		decode_tlv(strlen(space), tlv, tlv_sz);
> >  		free(tlv);
> >  	}
> >        __skip_tlv:
> > -- 
> > 1.9.1
> > 
