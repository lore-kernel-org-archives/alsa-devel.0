From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [RFC PATCH 3/3] ucm: Execute sequence of component
	devices
Date: Wed, 16 Nov 2016 07:36:58 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8819A700B@shsmsx102.ccr.corp.intel.com>
References: <cover.1479195801.git.mengdong.lin@linux.intel.com>
 <b610787835a8530f0b3105321e8f15661fc55b0b.1479195801.git.mengdong.lin@linux.intel.com>
 <1479199798.7823.14.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 42F822665B6
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2016 08:37:04 +0100 (CET)
In-Reply-To: <1479199798.7823.14.camel@loki>
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
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Liam Girdwood [mailto:liam.r.girdwood@linux.intel.com]
> Sent: Tuesday, November 15, 2016 4:50 PM

> > @@ -341,13 +348,22 @@ static int execute_cset(snd_ctl_t *ctl, const char
> *cset, unsigned int type)
> >   * \brief Execute the sequence
> >   * \param uc_mgr Use case manager
> >   * \param seq Sequence
> > + * \param cdev_in input cdev,  parenet's cdev for a component device,
> > + *				or NULL for a machine device.
> >   * \return zero on success, otherwise a negative error code
> > + *
> > + * A machine device's sequence can enable or disable a component device.
> > + * But the enable/disable sequence of a component device does not
> > + define
> > + * cdev, the card device. So when executing a component device's
> > + sequence,
> > + * we need to pass the cdev defined by the sequence of its parent,
> > + the
> > + * machine device. And for machine device, cdev should be set to NULL.
> >   */
> >  static int execute_sequence(snd_use_case_mgr_t *uc_mgr,
> >  			    struct list_head *seq,
> >  			    struct list_head *value_list1,
> >  			    struct list_head *value_list2,
> > -			    struct list_head *value_list3)
> > +			    struct list_head *value_list3,
> > +			    char *cdev_in)
> 
> Could the current cdev be embedded in uc_mgr ?

Yes, it could and there will be less code change. 
Actually I found the machine devices always set the same cdev name in their sequences.

> > @@ -366,7 +382,16 @@ static int execute_sequence(snd_use_case_mgr_t
> *uc_mgr,
> >  		case SEQUENCE_ELEMENT_TYPE_CSET:
> >  		case SEQUENCE_ELEMENT_TYPE_CSET_BIN_FILE:
> >  		case SEQUENCE_ELEMENT_TYPE_CSET_TLV:
> > -			if (cdev == NULL) {
> > +			if (cdev == NULL && cdev_in) {
> > +				/* Sequence of a component device, should
> use
> > +				 * the input cdev defined by sequence of its
> > +				 * parent, the machine device.
> > +				 */
> > +				cdev = strdup(cdev_in);
> > +				if (cdev == NULL)
> > +					goto __fail_nomem;
> > +
> > +			} else if (cdev == NULL) {
> >  				char *playback_ctl = NULL;
> >  				char *capture_ctl = NULL;
> >
> > @@ -405,7 +430,9 @@ static int execute_sequence(snd_use_case_mgr_t
> *uc_mgr,
> >  					free(capture_ctl);
> >  				} else
> >  					cdev = capture_ctl;
> > +
> >  			}
> > +
> 
> Looks like this formatting change was added by mistake ?

Yes, it was added by mistake. I'll remove it.

> > +/* Execute enable or disable sequence of a component device.
> > + *
> > + * For a component device (a codec or embedded DSP), its sequence
> > +doesn't
> > + * specify the sound card device 'cdev', because a component can be
> > +reused
> > + * by different sound cards (machines). So when executing its
> > +sequence, a
> > + * parameter 'cdev_in' is used to pass cdev defined by the sequence
> > +of its
> > + * parent, the machine device.
> > + */
> > +static int execute_component_seq(snd_use_case_mgr_t *uc_mgr,
> > +				 struct component_sequence *cmpt_seq,
> > +				 struct list_head *value_list1,
> > +				 struct list_head *value_list2,
> > +				 struct list_head *value_list3,
> > +				 char *cdev_in)
> > +{
> > +	struct use_case_device *device = cmpt_seq->device;
> > +	struct list_head *seq;
> > +	int err;
> > +
> > +
> > +	if (cmpt_seq->enable)
> > +		seq = &device->enable_list;
> > +	else
> > +		seq = &device->disable_list;
> 
> What happens here if there is only an enable sequence and no disable
> sequence ? i.e. will seq be NULL ?

The device's enable_list or disable_list will be empty, assured by the UCM parser.
And so 'seq' will be an empty list and the following execute_sequence() will exit without doing anything.
> 
> > +
> > +	err = execute_sequence(uc_mgr, seq,
> > +			       &device->value_list,
> > +			       &uc_mgr->active_verb->value_list,
> > +			       &uc_mgr->value_list,
> > +			       cdev_in);
> > +	return err;
> > +}
> > +

Thanks
Mengdong
