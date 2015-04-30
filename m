From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [PATCH 2/4] ASoC: Intel: Add Cherrytrail &
 Braswell machine driver cht_bsw_max98090
Date: Thu, 30 Apr 2015 09:39:12 -0700
Message-ID: <CAEUnVG78u7NUGYpT5QgnjcN7EmpnsjYbPTwHtHrfdUH0pOzFPA@mail.gmail.com>
References: <1430358238-74659-1-git-send-email-yang.a.fang@intel.com>
 <1430358238-74659-2-git-send-email-yang.a.fang@intel.com>
 <20150430043651.GJ3521@localhost>
 <20150430062418.GA76535@mocha> <55424CED.1080402@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vn0-f52.google.com (mail-vn0-f52.google.com
 [209.85.216.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 910462602AD
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 18:39:34 +0200 (CEST)
Received: by vnbf1 with SMTP id f1so7915535vnb.0
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 09:39:33 -0700 (PDT)
In-Reply-To: <55424CED.1080402@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Denny Iriawan <denny.iriawan@intel.com>, Yang Fang <yang.a.fang@intel.com>, Praveen K Jain <praveen.k.jain@intel.com>, "Diwakar,
 Praveen" <praveen.diwakar@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, kevin.strasser@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 30, 2015 at 8:40 AM, Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>>>> +       ret = snd_soc_card_jack_new(runtime->card, "Headset Jack",
>>>> +                               SND_JACK_HEADPHONE | SND_JACK_MICROPHONE
>>>> |
>>>> +                               SND_JACK_BTN_0 | SND_JACK_BTN_1 |
>>>> +                               SND_JACK_BTN_2 | SND_JACK_BTN_3, jack,
>>>> NULL, 0);
>>>
>>> Do you really support all those buttons?
>>
>> TI driver supports 4 buttons sound/soc/codecs/ts3a227e.c
>> google made 4 buttons headsets
>
>
> Not every codec is capable of handling 4 buttons.
> That TI codec was made specifically to detect 4 different levels of
> impedance. Looking at the Max98090, I see support for a single button press
> (change in the status of JKSNS). what makes you think you can handle 4
> buttons in the codec hardware?

The 98090 isn't involved in the button or jack detection in this case.
The ts3a227e handles all jack and button events and posts them to the
jack.

>
