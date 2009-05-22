From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: Re: Disabling HFL/R outputs in twl4030
Date: Fri, 22 May 2009 05:31:35 -0500
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705F6769AA3@dlee07.ent.ti.com>
References: <2C7D3DF36ADFFC479B44490D912B616705F6AC2661@dlee07.ent.ti.com>,
	<200905221248.28656.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 668691038FC
	for <alsa-devel@alsa-project.org>;
	Fri, 22 May 2009 12:31:44 +0200 (CEST)
In-Reply-To: <200905221248.28656.peter.ujfalusi@nokia.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> > Currently, handsfree amplifiers are turned-on when the HandsfreeL/R
> > muxes are powered by the framework. I was thinking in adding a
> > dapm switch to select whether or not handsfree amplifiers should
> > be powered, but the switch probably is not the correct approach to
> > handle this situation. Maybe a regular kcontrol could be the answer.

> It has to be DAPM switch for muting the HFL and the HFR.
> In order to execute the pop removal on the HF outputs the bits in the HF
> registers has to be configured in a specific order (REF_EN, RAMP_EN, LOOP_EN
> and HB_EN)

> The DAPM switch should not change any register bits, but should have variable
> in the twl4030_priv struct to change.

Is it possible to have a dapm switch that doesn't affect register bits? I mean that the
kcontrol associated to the switch doesn't affect any register?

> I have the re-written HFL/R pop removal thing without the DAPM mute switch. I
> still need to test it on different HWs, but at least it does look promising at
> the moment.
