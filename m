From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [RFC v3 7/7] ASoC: hdmi-codec: Add ELD control
Date: Tue, 19 Jan 2016 14:47:33 +0200
Message-ID: <569E3065.9060505@ti.com>
References: <1452613096-8116-1-git-send-email-p.zabel@pengutronix.de>
 <1452613096-8116-8-git-send-email-p.zabel@pengutronix.de>
 <569E2545.9010602@ti.com> <s5h8u3ldbb4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id E6987260561
 for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2016 13:47:41 +0100 (CET)
In-Reply-To: <s5h8u3ldbb4.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, kernel@pengutronix.de, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Koro Chen <koro.chen@mediatek.com>, Daniel Kurtz <djkurtz@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org, Philipp Zabel <p.zabel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, Cawa Cheng <cawa.cheng@mediatek.com>
List-Id: alsa-devel@alsa-project.org

On 01/19/16 14:05, Takashi Iwai wrote:
> On Tue, 19 Jan 2016 13:00:05 +0100,
> Jyri Sarha wrote:
>>
>> On 01/12/16 17:38, Philipp Zabel wrote:
>>> Exporting the ELD bytes to userspace allows an application to select
>>> an appropriate audio format depending on the current capabilities of
>>> the connected HDMI sink device.
>>>
>>
>> This looks good, but I was unable to test it. Obviously amixer or
>> alsamixer is unable to show anything about an ELD mixer element,
>
> You can use amixer cget command to retrieve the information.
>
>> but
>> shouldn't there be something about it shown under /proc/asound/card0/,
>> or am I mistaken.
>
> It's specific to driver.  HD-audio has one, but it doesn't show the
> whole ELD but only parsed contents.
>
>

Thanks,
I managed the read the ELD bytes with:

amixer -c0 cget iface=PCM,name='ELD',device=0

And the numbers change a bit when I connect to a different TV, so:

Reviewed-by: Jyri Sarha <jsarha@ti.com>
Tested-by: Jyri Sarha <jsarha@ti.com>

Cheers,
Jyri
