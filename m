From: =?utf-8?B?U2h1bWluZyBb6IyD5pu46YqYXQ==?= <shumingf@realtek.com>
Subject: Re: [PATCH 2/2] ASoC: rt1011: ADCDAT pin config
	modification
Date: Mon, 2 Sep 2019 04:34:05 +0000
Message-ID: <10317AB43303BA4884D7AF9C2EBCFF4002BE9C67@RTITMBSVM07.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2CCF8F8011E
 for <alsa-devel@alsa-project.org>; Mon,  2 Sep 2019 06:34:16 +0200 (CEST)
Content-Language: zh-TW
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: 'Mark Brown' <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "cychiang@google.com" <cychiang@google.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, =?utf-8?B?RGVyZWsgW+aWueW+t+e+qV0=?= <derek.fang@realtek.com>, "sathya.prakash.m.r@intel.com" <sathya.prakash.m.r@intel.com>, "Flove(HsinFu)" <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> > > So really this is setting up a loopback for testing?
> 
> > We would not like to change ADCDAT pin to input mode in normal case.
> > That's why the driver enables ADCDAT pin to the output mode in default.
> > The rt1011 supports the feedback signal which could be playback data or I/V
> data, etc.
> > If the system wants the AEC reference data, rt1011 could feedback the
> playback data.
> 
> > The product could connect 2/4/6/8 rt1011 chips on the same I2S bus.
> > In a test or debug mode, we could toggle ADCDAT pin to input mode that
> > also helps HW engineer check the slot of feedback signal for each rt1011.
> 
> I think this needs more than just a straight userspace control on one device,
> these use cases make sense but they'll need to be configured over multiple
> chips simultaneously otherwise there's some possibility of hardware damage
> (eg, if two chips try to drive the signal at the same time).  If this really can be
> usefully varied at runtime then the driver bit of this should probably be an API
> that the machine driver can call, the machine driver can then expose a control
> that sets all the chips involved up together.

I understand your concerns and comments.
In a design-in project, we will provide the proper control settings
to arrange the slot location of ADCDAT signal for each rt1011.
HW engineer will confirm the ADCDAT signal, too.
So, the customer should not make two chips drive the signal
at the same slot and at the same time.
But, there is a chance to happen if the customer sets the wrong control settings.
We will take your suggestion to make it as API call.
The machine driver knows how many rt1011 chips connect and
make pin config change together.
Thanks.

> ------Please consider the environment before printing this e-mail.
