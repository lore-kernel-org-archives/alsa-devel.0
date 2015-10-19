From: Oder Chiou <oder_chiou@realtek.com>
Subject: Re: [PATCH v4] ASoC: rt5645: Add the HW EQ for the
	customized speaker output of Google Celes
Date: Mon, 19 Oct 2015 06:34:52 +0000
Message-ID: <7EB0DE829A537248AF2ED30C97D12694F9DE17@RTITMBSV03.realtek.com.tw>
References: <1444803300-31699-1-git-send-email-oder_chiou@realtek.com>
 <20151016151618.GQ14956@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id AF652265701
 for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2015 08:34:59 +0200 (CEST)
In-Reply-To: <20151016151618.GQ14956@sirena.org.uk>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Gary_lin <gary_lin@realtek.com>, John Lin <john.lin@realtek.com>, "woojoo.lee@samsung.com" <woojoo.lee@samsung.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> The userspace interface is now what I'd expec tbut I'm still quite
> confused by this.  Why is this not a normal bytes control?  There's
> something going on with private data here but I'm not sure what it's
> supposed to do over writing to the device - a changelog might've
> helped...
> 
We want to set the register table to the following struct byte-by-byte.
struct rt5645_eq_param_s {
	unsigned short reg;
	unsigned short val;
};
Due to the length and target registers of the table are variant, we allocate
the maximum size of register settings to store the data, and they should be
controlled by DAPM for following the sequence, so the settings will be
applied to the hardware in the speaker event of DAPM.

> There's a validation function below - we should be using it when the
> user supplies data so they can tell if their settings took effect.
> 
We will add the validation function in the function "rt5645_hweq_put", if
the settings are validated, it will be copied to the private data "eq_param".

> Why is the hweq setting part of platform data (and why is the platform
> data for a specific system being set as part of this patch)?  This is
> just a setting that can be set, there's nothing system specific about it
> and it's not like we're even passing in a system specific tuning here.
> 
In the default, we want to disable the HW EQ function, and it is only enabled
by the customers' request, so we set it in the platform data. The parameters
of the HW EQ only can be passed by ALSA binary control.
