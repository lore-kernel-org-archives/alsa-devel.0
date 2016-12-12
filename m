From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 2/2] ASoC: hdmi-codec: add channel mapping
	control
Date: Mon, 12 Dec 2016 21:12:16 +0900
Message-ID: <562a83ef-0dab-9d30-5d5e-b4446bed96b8@sakamocchi.jp>
References: <1481215067-19362-1-git-send-email-arnaud.pouliquen@st.com>
 <1481215067-19362-3-git-send-email-arnaud.pouliquen@st.com>
 <1cc79b45-d45c-35da-8e85-b349f0338866@sakamocchi.jp>
 <d9d775e9-b077-ae53-6b3f-6c4d6f40c0c3@st.com> <s5hmvg1jwvg.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 3E618266AA4
 for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2016 13:12:20 +0100 (CET)
In-Reply-To: <s5hmvg1jwvg.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "kernel@stlinux.com" <kernel@stlinux.com>, David Airlie <airlied@linux.ie>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "broonie@kernel.org" <broonie@kernel.org>, Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel.vetter@intel.com>
List-Id: alsa-devel@alsa-project.org

On Dec 12 2016 18:54, Takashi Iwai wrote:
>>>> +enum hdmi_codec_cea_spk_placement {
>>>> +	FL  = (1 <<  0),	/* Front Left           */
>>>> +	FC  = (1 <<  1),	/* Front Center         */
>>>> +	FR  = (1 <<  2),	/* Front Right          */
>>>> +	FLC = (1 <<  3),	/* Front Left Center    */
>>>> +	FRC = (1 <<  4),	/* Front Right Center   */
>>>> +	RL  = (1 <<  5),	/* Rear Left            */
>>>> +	RC  = (1 <<  6),	/* Rear Center          */
>>>> +	RR  = (1 <<  7),	/* Rear Right           */
>>>> +	RLC = (1 <<  8),	/* Rear Left Center     */
>>>> +	RRC = (1 <<  9),	/* Rear Right Center    */
>>>> +	LFE = (1 << 10),	/* Low Frequency Effect */
>>>> +};
>>>
>>> BIT() macro in "linux/bitops.h" is available.
>> will be corrected in a v2
>
> One slight caution: BIT() expands to an unsigned long type.

Mmm, indeed. This is my wrong indication, sorry.
Thanks for your correction.


Regards

Takashi Sakamoto
