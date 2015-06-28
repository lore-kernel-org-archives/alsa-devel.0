From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH 3/6] ASoC: fsl_ssi: enable AC'97 asymmetric rates
Date: Sun, 28 Jun 2015 21:12:19 +0200
Message-ID: <55904713.4020101@maciej.szmigiero.name>
References: <558FFAC4.2060608@maciej.szmigiero.name> <558FFE4E.703@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <558FFE4E.703@tabi.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Timur Tabi <timur@tabi.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

W dniu 28.06.2015 16:01, Timur Tabi pisze:
> Maciej S. Szmigiero wrote:
>>       /* Are the RX and the TX clocks locked? */
>>       if (!of_find_property(np, "fsl,ssi-asynchronous", NULL)) {
>> -        ssi_private->cpu_dai_drv.symmetric_rates = 1;
>> +        if (!fsl_ssi_is_ac97(ssi_private))
>> +            ssi_private->cpu_dai_drv.symmetric_rates = 1;
>> +
> 
> Is this necessary?  Why not just add fsl,ssi-asynchronous to the AC97 device tree node?

Because in the AC'97 mode the driver supports only one channel config and one sample format
anyway the remaining settings controlled by this property don't do anything.

Since it should be safe to enable asymmetric rates with any AC'97 CODEC I think it is good
to do it in driver than to add "fsl,ssi-asynchronous" to every AC'97 DT node.

Also the description of this property in fsl,ssi.txt looks like that it only makes sense in
non-AC'97 mode.

Best regards,
Maciej Szmigiero
