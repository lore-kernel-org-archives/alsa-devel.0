From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH v3 5/5] ALSA: hda - hdmi setup pin when
 monitor hotplug in pcm dynamic assignment mode
Date: Mon, 14 Dec 2015 08:16:58 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D197B11D4@SHSMSX103.ccr.corp.intel.com>
References: <1449712332-106365-1-git-send-email-libin.yang@linux.intel.com>
 <1449712332-106365-6-git-send-email-libin.yang@linux.intel.com>
 <s5h37v9l09x.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F194260523
 for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2015 09:17:04 +0100 (CET)
In-Reply-To: <s5h37v9l09x.wl-tiwai@suse.de>
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
> Sent: Friday, December 11, 2015 6:59 PM
> To: libin.yang@linux.intel.com
> Cc: alsa-devel@alsa-project.org; Lin, Mengdong; Yang, Libin
> Subject: Re: [alsa-devel] [PATCH v3 5/5] ALSA: hda - hdmi setup pin when
> monitor hotplug in pcm dynamic assignment mode
> 
> On Thu, 10 Dec 2015 02:52:12 +0100,
> libin.yang@linux.intel.com wrote:
> >
> > From: Libin Yang <libin.yang@linux.intel.com>
> >
> > Setup pin configuration when monitor is hotplugged
> > in pcm dynamic assignment if the PCM is in open state.
> >
> > When monitor is disconnect, The pin will be reset.
> >
> > Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
> > ---
> >  sound/pci/hda/hda_codec.h  |  1 +
> >  sound/pci/hda/patch_hdmi.c | 82
> +++++++++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 79 insertions(+), 4 deletions(-)
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
> 
> No need to add such a flag in a common object.  (And actually it's
> wrong to add here, it should be per stream.)
> 
> The check is needed only for HDMI/DP, thus it can be put in
> hdmi_spec.  And it can be a bit flag protected via your new pcm_lock.

Yes, I will put it in hdmi_spec.

Regards,
Libin

> 
> 
> Takashi
