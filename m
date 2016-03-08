From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [RFC PATCH 4/4] ALSA - hda: add DP MST support
Date: Tue, 8 Mar 2016 06:47:20 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D190467FC9A@SHSMSX103.ccr.corp.intel.com>
References: <1457362666-53937-1-git-send-email-libin.yang@linux.intel.com>
 <1457362666-53937-5-git-send-email-libin.yang@linux.intel.com>
 <s5hsi02e2o3.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id B1109261298
 for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2016 07:47:25 +0100 (CET)
In-Reply-To: <s5hsi02e2o3.wl-tiwai@suse.de>
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

Hi Takashi,

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Monday, March 07, 2016 11:19 PM
> To: libin.yang@linux.intel.com
> Cc: alsa-devel@alsa-project.org; Lin, Mengdong; Yang, Libin
> Subject: Re: [alsa-devel] [RFC PATCH 4/4] ALSA - hda: add DP MST
> support
> 
> On Mon, 07 Mar 2016 15:57:46 +0100,
> libin.yang@linux.intel.com wrote:
> >
> > From: Libin Yang <libin.yang@linux.intel.com>
> >
> > This patch adds the DP MST support in hdmi audio driver.
> > ---
> >  sound/pci/hda/hda_codec.c  |   3 +
> >  sound/pci/hda/patch_hdmi.c | 167
> +++++++++++++++++++++++++++++++--------------
> >  2 files changed, 120 insertions(+), 50 deletions(-)
> >
> > diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
> > index 1a42c51..7244f87 100644
> > --- a/sound/pci/hda/hda_codec.c
> > +++ b/sound/pci/hda/hda_codec.c
> > @@ -589,6 +589,9 @@ static int read_pin_defaults(struct hda_codec
> *codec)
> >  		pin->nid = nid;
> >  		pin->cfg = snd_hda_codec_read(codec, nid, 0,
> >
> AC_VERB_GET_CONFIG_DEFAULT, 0);
> > +		/* all device entries are the same widget control so far
> > +		 * fixme: if any codec is different, need fix here
> > +		 */
> >  		pin->ctrl = snd_hda_codec_read(codec, nid, 0,
> >
> AC_VERB_GET_PIN_WIDGET_CONTROL,
> >  					       0);
> > diff --git a/sound/pci/hda/patch_hdmi.c
> b/sound/pci/hda/patch_hdmi.c
> > index 11be04a..26f5efd 100644
> > --- a/sound/pci/hda/patch_hdmi.c
> > +++ b/sound/pci/hda/patch_hdmi.c
> > @@ -144,7 +144,9 @@ struct hdmi_spec {
> >  	struct snd_array cvts; /* struct hdmi_spec_per_cvt */
> >  	hda_nid_t cvt_nids[4]; /* only for haswell fix */
> >
> > -	int num_pins;
> > +	int num_pins; /* number of pins (including device entries) */
> > +	int num_nids; /* number of pin nids*/
> > +	int dev_num;
> 
> These new definitions are unclear to me.  Please give a bit more
> detailed comments there.  e.g. what actually means "including device
> entries"?  You can give some example there.  I suppose num_nids is the
> actual number of pins, right?  Also what is dev_num?  It's not an
> index, right?

OK. I will add more comments in the code. For this case:
1. num_pins is the virtual pin number. For example, 
    there are 3 pins and each pin has 4 device entry, the num_pins will be 12.
2. num_nids is the actual number of pins. For the above case it will be 3
3. dev_num is the device entry number on each pin. For the above case, it is 4.
    dev_num is used to decide to create how many pcms (as we talked before,
    num_nids + dev_num - 1, on Intel platform, it is 5 pcms)
    For more complex case (not sure there is such case in reality), pin 1 has 2
    device entries, pin 2 and pin 3 has 3 device entries. The dev_num is 3.
    And 5 pcms will be created.

For device entry index, the index is located in per_pin struct.

Regards,
Libin

> 
> 
> thanks,
> 
> Takashi
