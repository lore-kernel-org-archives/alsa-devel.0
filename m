From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [RFC V2 PATCH 4/5] ALSA: hda - add in_use flag in
 hda_pcm
Date: Wed, 25 Nov 2015 06:50:59 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D1977F3B1@SHSMSX103.ccr.corp.intel.com>
References: <1448287774-146673-1-git-send-email-libin.yang@linux.intel.com>
 <1448287774-146673-6-git-send-email-libin.yang@linux.intel.com>
 <s5hy4dozpdw.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 07EA5265326
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2015 07:51:10 +0100 (CET)
In-Reply-To: <s5hy4dozpdw.wl-tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "mengdong.lin@linux.intel.com" <mengdong.lin@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Monday, November 23, 2015 11:50 PM
> To: libin.yang@linux.intel.com
> Cc: alsa-devel@alsa-project.org; mengdong.lin@linux.intel.com; Yang,
> Libin
> Subject: Re: [alsa-devel] [RFC V2 PATCH 4/5] ALSA: hda - add in_use flag
> in hda_pcm
> 
> On Mon, 23 Nov 2015 15:09:33 +0100,
> libin.yang@linux.intel.com wrote:
> >
> > From: Libin Yang <libin.yang@linux.intel.com>
> >
> > Add in_use flag in struct hda_pcm for HD Audio dynamic PCM
> assignment.
> >
> > Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
> 
> This should be folded into the last patch.  The addition of the flag
> alone doesn't make much sense.

Get it. Thanks.

Regards,
Libin

> 
> 
> Takashi
> 
> > ---
> >  sound/pci/hda/hda_codec.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
> > index 373fcad..ee97401 100644
> > --- a/sound/pci/hda/hda_codec.h
> > +++ b/sound/pci/hda/hda_codec.h
> > @@ -167,6 +167,7 @@ enum {
> >  /* for PCM creation */
> >  struct hda_pcm {
> >  	char *name;
> > +	bool in_use;
> >  	struct hda_pcm_stream stream[2];
> >  	unsigned int pcm_type;	/* HDA_PCM_TYPE_XXX */
> >  	int device;		/* device number to assign */
> > --
> > 1.9.1
> >
