From: "Murphy, Dan" <dmurphy@ti.com>
Subject: Re: [PATCH v6] ASoC: tas2552: Support TI TAS2552 Amplifier
Date: Mon, 14 Jul 2014 19:33:35 +0000
Message-ID: <00FC9A978A94B7418C33AFAE8A35ED49D80BB3@DFLE09.ent.ti.com>
References: <1405093489-11897-1-git-send-email-dmurphy@ti.com>
 <20140714184321.GW6800@sirena.org.uk>
 <00FC9A978A94B7418C33AFAE8A35ED49D80B10@DFLE09.ent.ti.com>
 <20140714191711.GI6800@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-sound-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Mark

On 07/14/2014 02:17 PM, Mark Brown wrote:
> On Mon, Jul 14, 2014 at 07:07:06PM +0000, Murphy, Dan wrote:
>> On 07/14/2014 01:43 PM, Mark Brown wrote:
>>>> +config SND_SOC_TAS2552
>>>> +	tristate "Texas Instruments TAS2552 Mono Audio amplifier"
>>>> +	depends on I2C
>>>> +
>>>>  endmenu
>>> Keep this and Makefile sorted - since this is a proper CODEC driver it
>>> should be in with the CODECs and also sorted in alphabetical order.
>> OK.  I was trying to stay away from a conflict by adding to the
>> bottom of the file.
> The whole point is to avoid conflicts - if everyone adds at the bottom
> of the file any two adds are pretty much guaranteed to conflict either
> on application or on merge.  Sorting avoids most of these and makes any
> that do occur much clearer.

No worries I will fix it

-- 
------------------
Dan Murphy

