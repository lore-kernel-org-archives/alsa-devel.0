From: "Fang, Yang A" <yang.a.fang@intel.com>
Subject: Re: [PATCH v3 3/3] ASoC: Intel: fixed TI button
	detection
Date: Wed, 3 Jun 2015 20:54:23 +0000
Message-ID: <0485FB02182A4744A8B06D69AB7BF8E718CFFCA8@ORSMSX113.amr.corp.intel.com>
References: <1432836048-102175-1-git-send-email-yang.a.fang@intel.com>
 <1432925772-117760-1-git-send-email-yang.a.fang@intel.com>
 <1432925772-117760-3-git-send-email-yang.a.fang@intel.com>
 <20150603181551.GR14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id E49B2265DB5
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2015 23:06:52 +0200 (CEST)
In-Reply-To: <20150603181551.GR14071@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Sripathi,
 Srinivas" <srinivas.sripathi@intel.com>, "Koul, Vinod" <vinod.koul@intel.com>, "Jain, Praveen K" <praveen.k.jain@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Iriawan,
 Denny" <denny.iriawan@intel.com>, "Nujella,
 Sathyanarayana" <sathyanarayana.nujella@intel.com>, "kevin.strasser@linux.intel.com" <kevin.strasser@linux.intel.com>, "dgreid@chromium.org" <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Wednesday, June 03, 2015 11:16 AM
> To: Fang, Yang A
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org;
> dgreid@chromium.org; Nujella, Sathyanarayana;
> kevin.strasser@linux.intel.com; Sripathi, Srinivas; Iriawan, Denny; Jain,
> Praveen K; Koul, Vinod
> Subject: Re: [PATCH v3 3/3] ASoC: Intel: fixed TI button detection
> 
> On Fri, May 29, 2015 at 11:56:12AM -0700, yang.a.fang@intel.com wrote:
> 
> > +	if (event & SND_JACK_MICROPHONE) {
> > +
> > +		pin_status = snd_soc_dapm_get_pin_status(&codec->dapm,
> "SHDN");
> > +		if (!pin_status)
> > +			snd_soc_dapm_force_enable_pin(&codec->dapm,
> "SHDN");
> 
> This seems wrong - either we need the pin enabled or we don't.  If it's
> currently enabled for something transient like playback then it might get
> turned off later so we should still force it on.
Got it.  I will remove the condition.
> 
> > +		snd_soc_dapm_disable_pin(&codec->dapm, "MICBIAS");
> > +		snd_soc_dapm_sync(&codec->dapm);
> > +		/**
> > +		* SHDN is max980090 shutdown pin we can not disable
> > +		* it in case we are in the middle of playabck or record
> > +		* we mark it unlock only so dapm will take care of it
> > +		* next time
> > +		*/
> > +		snd_soc_dapm_disable_pin_unlocked(&codec->dapm,
> "SHDN");
> 
> This is wrong, you're mixing locked and unlocked versions of the DAPM
> operations which can't be right - the difference between locked and
> unlocked versions of the operations is that the locked versions is if the locks
> for DAPM are already held and clearly there's no locking code here.  This last
> operation shuld be a normal _disable_pin().
> 
Thanks Mark.  I will use snd_soc_dapm_disable_pin
> I'd also expect it to be before the sync - there's no telling how long it'll be till
> the next sync otherwise and no reason to leave the pin forced on if it's not
> needed.  If it is in use due to some other thing then DAPM should ensure
> that the state doesn't get changed by the disable.
> 
I was thinking widget will be disabled right after calling snd_soc_dapm_sync
I just tried to move SHDN before calling snd_soc_dapm_sync  .as you said 
if it is in use dapm will not turn it off immediately  for example if playback is
 ongoing.It will be turned off few seconds after playback stops.

> Indentation is broken for the comment too.
I will remove the comments since I will move the disable SHDN pin code 
before calling snd_soc_dapm_sync
