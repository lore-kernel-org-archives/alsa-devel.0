From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH] ASoC: Add accessor macros for TLV items
Date: Tue, 27 Mar 2018 14:08:24 -0700
Message-ID: <1522184904.2236.14.camel@linux.intel.com>
References: <20180327183945.6551-1-ranjani.sridharan@linux.intel.com>
 <s5hh8p18fsw.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FE0326719A
 for <alsa-devel@alsa-project.org>; Tue, 27 Mar 2018 23:08:26 +0200 (CEST)
In-Reply-To: <s5hh8p18fsw.wl-tiwai@suse.de>
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
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2018-03-27 at 21:43 +0200, Takashi Iwai wrote:
> On Tue, 27 Mar 2018 20:39:45 +0200,
> Ranjani Sridharan wrote:
> > 
> > This patch adds macros for accessing the type, length, min, mute
> > and step items in TLV data. These will be used by drivers to
> > extract
> > the TLV data while loading topology.
> > 
> > Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com
> > >
> 
> The subject is wrongly prefixed.  This is ALSA core API stuff, not
> about ASoC.

Will fix this in v2. 
> 
> And about the change...
> 
> > --- a/include/sound/tlv.h
> > +++ b/include/sound/tlv.h
> > @@ -49,6 +49,11 @@
> >  
> >  #define TLV_DB_GAIN_MUTE		SNDRV_CTL_TLVD_DB_GAIN_MUT
> > E
> >  
> > +#define TLV_ITEM_TYPE			SNDRV_CTL_TLVD_ITEM_T
> > YPE
> > +#define TLV_ITEM_LEN			SNDRV_CTL_TLVD_ITEM_LE
> > N
> > +#define TLV_DB_MIN			SNDRV_CTL_TLVD_DB_SCALE_
> > MIN
> > +#define TLV_DB_MUTE_AND_STEP		SNDRV_CTL_TLVD_DB_SCAL
> > E_MUTE_AND_STEP
> 
> What's the reason of these redundant redefinitions?

I followed the other definitions in this file which were aliases to the
ones in uapi/sound/tlv.h. I suppose these can be avoided. I'll fix this
 in v2.
> 
> 
> > --- a/include/uapi/sound/tlv.h
> > +++ b/include/uapi/sound/tlv.h
> > @@ -60,6 +60,13 @@
> >  	unsigned int name[] = { \
> >  		SNDRV_CTL_TLVD_DB_SCALE_ITEM(min, step, mute) \
> >  	}
> > +/* Accessor macros for TLV type and len */
> > +#define SNDRV_CTL_TLVD_ITEM_TYPE		0
> > +#define SNDRV_CTL_TLVD_ITEM_LEN			1
> > +
> > +/* Accessor macros for min, mute and step values from dB scale
> > type TLV */
> > +#define SNDRV_CTL_TLVD_DB_SCALE_MIN		2
> > +#define SNDRV_CTL_TLVD_DB_SCALE_MUTE_AND_STEP	3
> 
> These are no "macros" but constants.  And, they use the same prefix
> SNDRV_CTL_TLVD_* as other existing macros.  SNDTV_CTL_TLVD_*() is a
> macro to define/expand a TLV descriptor.  It's not for defining the
> offset value as added in the patch.
> 
> That is, better to choose another unique prefix to distinguish the
> definitions clearly.

Sure, will change the prefix as well. Thanks!
> 
> 
> thanks,
> 
> Takashi
