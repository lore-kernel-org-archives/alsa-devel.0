From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [RESEND PATCH v2 3/3] ucm: Execute sequence of
 component devices
Date: Mon, 28 Nov 2016 03:12:26 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8819AD0DE@shsmsx102.ccr.corp.intel.com>
References: <cover.1479446217.git.mengdong.lin@linux.intel.com>
 <5c28a80cf70a75472ed001cc71c4d3be4199f40f.1479446217.git.mengdong.lin@linux.intel.com>
 <1479989029.23022.133.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D0582665A6
 for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2016 04:12:30 +0100 (CET)
In-Reply-To: <1479989029.23022.133.camel@loki>
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
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, "mengdong.lin@linux.intel.com" <mengdong.lin@linux.intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Liam Girdwood [mailto:liam.r.girdwood@linux.intel.com]
> Sent: Thursday, November 24, 2016 8:04 PM
> >
> >  /*
> >   * misc
> > @@ -48,6 +49,30 @@ static int get_value3(char **value,
> >  		      struct list_head *value_list2,
> >  		      struct list_head *value_list3);
> >
> > +/* enter component domain and store cdev for the component */ #define
> > +ENTER_COMPONENT_DOMAIN(uc_mgr, cdev) \
> > +	do {\
> > +		(uc_mgr)->in_component_domain = 1;\
> > +		(uc_mgr)->cdev = (cdev);\
> > +	} while (0)
> > +
> > +/* exit component domain and clear cdev */ #define
> > +EXIT_COMPONENT_DOMAIN(uc_mgr) \
> > +	do {\
> > +		(uc_mgr)->in_component_domain = 0;\
> > +		(uc_mgr)->cdev = NULL;\
> > +	} while (0)
> > +
> 
> Do we need these macros ? It seems like we only use these once.

I'll remove these macros. Yes, we only use them once.

> 
> > +#define IN_COMPONENT_DOMAIN(uc_mgr) \
> > +	((uc_mgr)->in_component_domain)
> > +
> 
> cant see where we use this ? Is it not just better to use "if (uc_mgr-
> >in_component_domain)"

We use it only once in execute_sequence() in the code below. I'll replace the macro with "if ..." as you suggested.

Thanks
Mengdong

> 
> > @@ -366,7 +391,19 @@ static int execute_sequence(snd_use_case_mgr_t
> *uc_mgr,
> >  		case SEQUENCE_ELEMENT_TYPE_CSET:
> >  		case SEQUENCE_ELEMENT_TYPE_CSET_BIN_FILE:
> >  		case SEQUENCE_ELEMENT_TYPE_CSET_TLV:
> > -			if (cdev == NULL) {
> > +			if (cdev == NULL &&
> IN_COMPONENT_DOMAIN(uc_mgr)) {
> > +				/* For sequence of a component device, use
> > +				 * parent's cdev stored by ucm manager.
> > +				 */
> > +				if (uc_mgr->cdev == NULL) {
> > +					uc_error("cdev is not defined!");
> > +					return err;
> > +				}
> > +
> > +				cdev = strndup(uc_mgr->cdev, PATH_MAX);
> > +				if (!cdev)
> > +					return -ENOMEM;
> > +			} else if (cdev == NULL) {
> >  				char *playback_ctl = NULL;
> >  				char *capture_ctl = NULL;
> >
