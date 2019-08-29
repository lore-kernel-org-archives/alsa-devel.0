From: =?utf-8?B?U2h1bWluZyBb6IyD5pu46YqYXQ==?= <shumingf@realtek.com>
Subject: Re: [PATCH 2/2] ASoC: rt1011: ADCDAT pin config
	modification
Date: Thu, 29 Aug 2019 05:54:00 +0000
Message-ID: <10317AB43303BA4884D7AF9C2EBCFF4002BE6083@RTITMBSVM07.realtek.com.tw>
References: <20190826090120.1937-1-shumingf@realtek.com>
 <20190828104938.GF4298@sirena.co.uk>
 <10317AB43303BA4884D7AF9C2EBCFF4002BE5727@RTITMBSVM07.realtek.com.tw>
 <20190828132055.GJ4298@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AC3C1F89824
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2019 07:54:11 +0200 (CEST)
In-Reply-To: <20190828132055.GJ4298@sirena.co.uk>
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

> > > > ADCDAT pin config sets to output mode in default.
> > > > And the driver creates the kcontrol to control ADCDAT pin configuration.
> 
> > > Why would this change at runtime?  I'd expect this to be controlled
> > > by the machine driver or a DT property.
> 
> > It will not change at runtime in the normal case.
> > I think we may use it to test the feedback signal in factory mode.
> 
> So really this is setting up a loopback for testing?

We would not like to change ADCDAT pin to input mode in normal case.
That's why the driver enables ADCDAT pin to the output mode in default.
The rt1011 supports the feedback signal which could be playback data or I/V data, etc.
If the system wants the AEC reference data, rt1011 could feedback the playback data.

The product could connect 2/4/6/8 rt1011 chips on the same I2S bus.
In a test or debug mode, we could toggle ADCDAT pin to input mode that also
helps HW engineer check the slot of feedback signal for each rt1011.

> ------Please consider the environment before printing this e-mail.
