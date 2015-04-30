From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 2/4] ASoC: Intel: Add Cherrytrail &
 Braswell machine driver cht_bsw_max98090
Date: Thu, 30 Apr 2015 10:40:29 -0500
Message-ID: <55424CED.1080402@linux.intel.com>
References: <1430358238-74659-1-git-send-email-yang.a.fang@intel.com>
 <1430358238-74659-2-git-send-email-yang.a.fang@intel.com>
 <20150430043651.GJ3521@localhost> <20150430062418.GA76535@mocha>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id C226D261A3B
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 17:40:32 +0200 (CEST)
In-Reply-To: <20150430062418.GA76535@mocha>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yang Fang <yang.a.fang@intel.com>, Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, praveen.k.jain@intel.com, praveen.diwakar@intel.com, lgirdwood@gmail.com, denny.iriawan@intel.com, broonie@kernel.org, kevin.strasser@linux.intel.com, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org


>>> +	ret = snd_soc_card_jack_new(runtime->card, "Headset Jack",
>>> +				SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
>>> +				SND_JACK_BTN_0 | SND_JACK_BTN_1 |
>>> +				SND_JACK_BTN_2 | SND_JACK_BTN_3, jack, NULL, 0);
>> Do you really support all those buttons?
> TI driver supports 4 buttons sound/soc/codecs/ts3a227e.c
> google made 4 buttons headsets

Not every codec is capable of handling 4 buttons.
That TI codec was made specifically to detect 4 different levels of 
impedance. Looking at the Max98090, I see support for a single button 
press (change in the status of JKSNS). what makes you think you can 
handle 4 buttons in the codec hardware?
