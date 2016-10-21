From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [RFC PATCH v3 1/3] ALSA: hda - add DP mst verb
 support
Date: Fri, 21 Oct 2016 06:52:01 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D194FA4A2F6@SHSMSX103.ccr.corp.intel.com>
References: <1476344977-147193-1-git-send-email-libin.yang@linux.intel.com>
 <1476344977-147193-2-git-send-email-libin.yang@linux.intel.com>
 <s5hoa2fghwj.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 93784266042
 for <alsa-devel@alsa-project.org>; Fri, 21 Oct 2016 08:52:11 +0200 (CEST)
In-Reply-To: <s5hoa2fghwj.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, "libin.yang@linux.intel.com" <libin.yang@linux.intel.com>
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Thursday, October 20, 2016 11:27 PM
> To: libin.yang@linux.intel.com
> Cc: alsa-devel@alsa-project.org; Yang, Libin <libin.yang@intel.com>; Lin,
> Mengdong <mengdong.lin@intel.com>
> Subject: Re: [alsa-devel] [RFC PATCH v3 1/3] ALSA: hda - add DP mst verb
> support
> 
> On Thu, 13 Oct 2016 09:49:35 +0200,
> libin.yang@linux.intel.com wrote:
> >
> > From: Libin Yang <libin.yang@linux.intel.com>
> >
> > Add snd_hda_get_dev_select() and snd_hda_set_dev_select() functions
> > for DP MST audio support.
> >
> > Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
> > ---
> >  sound/pci/hda/hda_codec.c | 73
> > ++++++++++++++++++++++++++++++++++++++++++++---
> >  sound/pci/hda/hda_codec.h |  3 ++
> >  2 files changed, 72 insertions(+), 4 deletions(-)
> >
> > diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
> > index 9913be8..caa2c9d 100644
> > --- a/sound/pci/hda/hda_codec.c
> > +++ b/sound/pci/hda/hda_codec.c
> > @@ -311,9 +311,16 @@ int snd_hda_get_conn_index(struct hda_codec
> > *codec, hda_nid_t mux,  }
> EXPORT_SYMBOL_GPL(snd_hda_get_conn_index);
> >
> > -
> > -/* return DEVLIST_LEN parameter of the given widget */ -static
> > unsigned int get_num_devices(struct hda_codec *codec, hda_nid_t nid)
> > +/**
> > + * snd_hda_get_num_devices - get DEVLIST_LEN parameter of the given
> > +widget
> > + *  @codec: the HDA codec
> > + *  @nid: NID of the pin to parse
> > + *
> > + * Get the device entry number on the given widget.
> > + * This is a feature of DP MST audio. Each pin can
> > + * have several device entries in it.
> 
> Try to fill more letters aligned in 80 columns, as we don't need to write a
> Haiku here.

Get it. Thanks :)

Regards,
Libin

> 
> 
> Takashi
