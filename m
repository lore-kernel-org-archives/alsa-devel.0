From: "Fang, Yang A" <yang.a.fang@intel.com>
Subject: Re: [PATCH 2/4] ASoC: Intel: Add Cherrytrail &
 Braswell machine driver cht_bsw_max98090
Date: Thu, 30 Apr 2015 17:43:42 +0000
Message-ID: <0485FB02182A4744A8B06D69AB7BF8E718CC596B@ORSMSX113.amr.corp.intel.com>
References: <1430358238-74659-1-git-send-email-yang.a.fang@intel.com>
 <1430358238-74659-2-git-send-email-yang.a.fang@intel.com>
 <20150430043651.GJ3521@localhost> <20150430062418.GA76535@mocha>
 <55424CED.1080402@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 1EDF0260418
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 19:44:06 +0200 (CEST)
In-Reply-To: <55424CED.1080402@linux.intel.com>
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
To: 'Pierre-Louis Bossart' <pierre-louis.bossart@linux.intel.com>, "Koul,
 Vinod" <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Jain,
 Praveen K" <praveen.k.jain@intel.com>, "Diwakar,
 Praveen" <praveen.diwakar@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Iriawan,
 Denny" <denny.iriawan@intel.com>, "broonie@kernel.org" <broonie@kernel.org>, "kevin.strasser@linux.intel.com" <kevin.strasser@linux.intel.com>, "dgreid@chromium.org" <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Pierre-Louis Bossart [mailto:pierre-louis.bossart@linux.intel.com]
> Sent: Thursday, April 30, 2015 8:40 AM
> To: Fang, Yang A; Koul, Vinod
> Cc: alsa-devel@alsa-project.org; Jain, Praveen K; Diwakar, Praveen;
> lgirdwood@gmail.com; Iriawan, Denny; broonie@kernel.org;
> kevin.strasser@linux.intel.com; dgreid@chromium.org
> Subject: Re: [alsa-devel] [PATCH 2/4] ASoC: Intel: Add Cherrytrail & Braswell
> machine driver cht_bsw_max98090
> 
> 
> >>> +	ret = snd_soc_card_jack_new(runtime->card, "Headset Jack",
> >>> +				SND_JACK_HEADPHONE |
> SND_JACK_MICROPHONE |
> >>> +				SND_JACK_BTN_0 | SND_JACK_BTN_1 |
> >>> +				SND_JACK_BTN_2 | SND_JACK_BTN_3, jack,
> NULL, 0);
> >> Do you really support all those buttons?
> > TI driver supports 4 buttons sound/soc/codecs/ts3a227e.c google made 4
> > buttons headsets
> 
> Not every codec is capable of handling 4 buttons.
> That TI codec was made specifically to detect 4 different levels of impedance.
> Looking at the Max98090, I see support for a single button press (change in
> the status of JKSNS). what makes you think you can handle 4 buttons in the
> codec hardware?

This machine driver will also probe TI driver as an aux device.  So Ti driver will handle
Buttons event .

Thanks,
Yang
