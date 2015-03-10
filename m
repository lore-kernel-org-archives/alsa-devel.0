From: "Lu, Han" <han.lu@intel.com>
Subject: Re: [PATCH 7/8] ASoC: Intel: add kcontrol to set
 parameter to sound effect module waves
Date: Tue, 10 Mar 2015 02:42:12 +0000
Message-ID: <B51200AC81AB024499A3C2C9A1BB90A836F421@SHSMSX101.ccr.corp.intel.com>
References: <1425281778-17513-1-git-send-email-han.lu@intel.com>
 <1425281778-17513-7-git-send-email-han.lu@intel.com>
 <20150306113509.GK21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id C628B261B25
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2015 03:42:23 +0100 (CET)
In-Reply-To: <20150306113509.GK21293@sirena.org.uk>
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
To: 'Mark Brown' <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Friday, March 6, 2015 7:35 PM
> To: Lu, Han
> Cc: alsa-devel@alsa-project.org; Girdwood, Liam R
> Subject: Re: [PATCH 7/8] ASoC: Intel: add kcontrol to set parameter to sound
> effect module waves
> 
> On Mon, Mar 02, 2015 at 03:36:17PM +0800, han.lu@intel.com wrote:
> 
> > +static int hsw_waves_param_get(struct snd_kcontrol *kcontrol,
> > +				struct snd_ctl_elem_value *ucontrol) {
> > +	/* keep an empty function here to match alsa-lib calling */
> > +	return 0;
> > +}
> 
> No, if it's valid to omit this we should be able to remove the function
> - but I'd really expect to always be able to read the current state of any
> control.  Applications should be able to do that and then write the value back
> without changing anything.  Either we should actually read things back or this
> should return an error (which is presumably what the core does if the
> function is missing).

[Han Lu] OK. I made patch v2 against current code, and remove unnecessary logs. For the read back kcontrol, I do not modify patch 7/8 but add actual read back code on patch 8/8, (merge patch 7 and 8 may make the patch too long and unclear?) please review. Thanks.
