From: Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>
Subject: Re: [PATCH v3 2/4] ARM: dts: pbab01: enable I2S audio on phyFLEX-i.MX6
 boards
Date: Wed, 1 Oct 2014 16:52:29 +0300
Message-ID: <542C071D.1030507@sam-solutions.com>
References: <1410537872-17274-1-git-send-email-d.lavnikevich@sam-solutions.com>	<1410854903-26419-1-git-send-email-d.lavnikevich@sam-solutions.com>	<1410854903-26419-3-git-send-email-d.lavnikevich@sam-solutions.com>	<CAOMZO5CgrQ6Wf6kStga40TUKx9dARygCNB4OYSUoG3c8eUYbrA@mail.gmail.com>	<542C0441.5080508@sam-solutions.com> <CAOMZO5BS6X2NTY4q7RKoKdhJNbEANSa2wXur3_Hyxp8nQn5Avw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOMZO5BS6X2NTY4q7RKoKdhJNbEANSa2wXur3_Hyxp8nQn5Avw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Shawn Guo <shawn.guo@freescale.com>, Sascha Hauer <kernel@pengutronix.de>, "robh+dt@kernel.org" <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, perex@perex.cz, Takashi Iwai <tiwai@suse.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On 01/10/14 16:45, Fabio Estevam wrote:
> On Wed, Oct 1, 2014 at 10:40 AM, Dmitry Lavnikevich
> <d.lavnikevich@sam-solutions.com> wrote:
>
>>> No need to have this 'regulator-always-on'
>>>
>>
>> why is there no need for 'regulator-alweys-on'? I see it in
>
> For a regulator that is not GPIO controlled you don't need to pass
> 'regulator-always-on'.

Ok, I will remove it also.

I will wait some time for other notes on patches and resend patchset.
