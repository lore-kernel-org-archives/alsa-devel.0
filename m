From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [RFC PATCH 2/3] ucm: Parse sequence of component
	devices
Date: Wed, 16 Nov 2016 07:16:54 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8819A6FD5@shsmsx102.ccr.corp.intel.com>
References: <cover.1479195801.git.mengdong.lin@linux.intel.com>
 <9baaf7a3d55a86e417826715e8e63d1a76582156.1479195801.git.mengdong.lin@linux.intel.com>
 <1479199551.7823.11.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CC082665B6
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2016 08:16:59 +0100 (CET)
In-Reply-To: <1479199551.7823.11.camel@loki>
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
> Sent: Tuesday, November 15, 2016 4:46 PM
 
> > @@ -306,6 +381,30 @@ static int parse_sequence(snd_use_case_mgr_t
> *uc_mgr ATTRIBUTE_UNUSED,
> >  			continue;
> >  		}
> >
> > +		if (strcmp(cmd, "enadev") == 0) {
> > +			/* need to enable a component device */
> > +			curr->type = SEQUENCE_ELEMENT_TYPE_CMPT_SEQ;
> > +			err = parse_component_seq(uc_mgr, n, 1,
> > +						&curr->data.cmpt_seq);
> > +			if (err < 0) {
> > +				uc_error("error: enadev requires a valid
> device!");
> > +				return err;
> > +			}
> > +			continue;
> > +		}
> > +
> > +		if (strcmp(cmd, "disdev") == 0) {
> 
> Do we need to document enadev and disdev anywhere ?
> 
> Liam

Maybe we could document this in the description of function parse_sequence() and parse_verb()?
parse_verb() has an example of EnableSequence and DisableSequence.

Thanks
Mengdong
