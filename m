From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH v2] ALSA: core api: define offsets for TLV
	items
Date: Wed, 28 Mar 2018 21:07:13 -0700
Message-ID: <1522296433.2236.29.camel@linux.intel.com>
References: <20180328170904.19845-1-ranjani.sridharan@linux.intel.com>
 <63485cbc-83ec-7177-b586-986ae1e4a380@sakamocchi.jp>
 <0dd6157c-9ccd-2aaa-d34a-869326d00989@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id C9EAA267063
 for <alsa-devel@alsa-project.org>; Thu, 29 Mar 2018 06:07:16 +0200 (CEST)
In-Reply-To: <0dd6157c-9ccd-2aaa-d34a-869326d00989@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2018-03-29 at 04:30 +0900, Takashi Sakamoto wrote:
> On Mar 29 2018 04:05, Takashi Sakamoto wrote:
> > > diff --git a/include/uapi/sound/tlv.h b/include/uapi/sound/tlv.h
> > > index be5371f09a62..1fd786a5e57b 100644
> > > --- a/include/uapi/sound/tlv.h
> > > +++ b/include/uapi/sound/tlv.h
> > > @@ -98,4 +98,12 @@
> > >   #define SNDRV_CTL_TLVD_DB_GAIN_MUTE    -9999999
> > > +/* Accessor offsets for TLV data items */
> > > +#define SNDRV_CTL_TLV_OFFSET_TYPE        0
> > > +#define SNDRV_CTL_TLV_OFFSET_LEN        1
> > 
> > I suggest you to use these macros in declaration of 
> > 'SNDRV_CTL_TLVD_ITEM()' for self-described header. In short, I
> > mean:
> > 
> > $ diff --git a/include/uapi/sound/tlv.h b/include/uapi/sound/tlv.h
> > index be5371f09a62..76598609f349 100644
> > --- a/include/uapi/sound/tlv.h
> > +++ b/include/uapi/sound/tlv.h
> > @@ -37,8 +37,15 @@
> >    *        block_length = (length + (sizeof(unsigned int) - 1)) &
> >    *                       ~(sizeof(unsigned int) - 1)) ....
> >    */
> > +
> > +/* Accessor offsets for TLV data items */
> > +#define SNDRV_CTL_TLV_OFFSET_TYPE      0
> > +#define SNDRV_CTL_TLV_OFFSET_LEN       1
> > +
> >   #define SNDRV_CTL_TLVD_ITEM(type, ...) \
> > -       (type), SNDRV_CTL_TLVD_LENGTH(__VA_ARGS__), __VA_ARGS__
> > +       [SNDRV_CTL_TLV_OFFSET_TYPE] = (type), \
> > +       [SNDRV_CTL_TLV_OFFSET_LEN] =
> > SNDRV_CTL_TLVD_LENGTH(__VA_ARGS__), \
> > +       __VA_ARGS__
> >   #define SNDRV_CTL_TLVD_LENGTH(...) \
> >          ((unsigned int)sizeof((const unsigned int[]) { __VA_ARGS__
> > }))
> > 
> > > +/* Accessor offsets for min, mute and step items in dB scale
> > > type TLV */
> > > +#define SNDRV_CTL_TLV_OFFSET_DB_MIN        2
> > > +#define SNDRV_CTL_TLV_OFFSET_DB_MUTE_AND_STEP    3
> > > +
> > >   #endif
> > 
> > I wonder why you add the above macros just for data of 
> > 'SNDRV_CTL_TLVT_DB_MINMAX_MUTE'. In fact, this header defines
> > below 
> > types of TLV data.
> >   - SNDRV_CTL_TLVT_CONTAINER
> >   - SNDRV_CTL_TLVT_DB_SCALE
> >   - SNDRV_CTL_TLVT_DB_LINEAR
> >   - SNDRV_CTL_TLVT_DB_RANGE
> >   - SNDRV_CTL_TLVT_DB_MINMAX
> >   - SNDRV_CTL_TLVT_DB_MINMAX_MUTE
> > 
> > Would I request you to your reason not to add such offset macros
> > for the 
> > others? At least, we should have a care for
> > 'SNDRV_CTL_TLVT_DB_LINEAR' 
> > to keep consistency of defined macros.

Thanks for your comments, Takashi. 
Maybe this patch was a bit shortsighted, after all.

Let me step back and explain my motivation.

While working on decoding the tlv data in topology in the sof driver,
it was suggested that it would make the code easier to follow if the 
offsets were replaced with constants defining what each offset stood
for. 
At the moment, sof supports only dB scale type TLV, so thats the reason
for me not considering the other types.
> 
> Oops. I missed nested-data such like 'SNDRV_CTL_TLVT_CONTAINER' or 
> 'SNDRV_CTL_TLVT_DB_RANGE'. These macros expands data including data 
> expanded by the other macros, thus offsets on the element data are 
> different from a case of single declaration. I mean:
> 
> static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(range,
>           0,   4, SNDRV_CTL_TLVD_DB_SCALE_ITEM(-5940, 44, 1),
>           4,  22, SNDRV_CTL_TLVD_DB_SCALE_ITEM(-5636, 60, 0),
>          22,  33, SNDRV_CTL_TLVD_DB_SCALE_ITEM(-4556, 76, 0),
>          33,  37, SNDRV_CTL_TLVD_DB_SCALE_ITEM(-4072, 44, 0),
>          37,  48, SNDRV_CTL_TLVD_DB_SCALE_ITEM(-3832, 76, 0),
>          48,  66, SNDRV_CTL_TLVD_DB_SCALE_ITEM(-2996, 60, 0),
>          66,  84, SNDRV_CTL_TLVD_DB_SCALE_ITEM(-2204, 44, 0),
>          84,  95, SNDRV_CTL_TLVD_DB_SCALE_ITEM( -836, 60, 0),
>          95,  99, SNDRV_CTL_TLVD_DB_SCALE_ITEM( -176, 76, 0),
>          100, 10000, SNDRV_CTL_TLVD_DB_SCALE_ITEM(0, 0, 0),
> );
> 
> This kind of declaration includes several elements for each type of 
> data. Here, my concern is that your macros can confuse developers in 
> userspace in this case or not. If you assume quite simple usecases
> of 
> TLV macros (single declaration), it's better to have more discussion 
> about your changes.

Yes, single declaration is only one of interest to me at the moment. So
I'd appreciate suggestions. Thanks again!

> 
> 
> Regards
> 
> Takashi Sakamoto
