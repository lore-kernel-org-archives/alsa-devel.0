From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] Uninitialized id returned
	by	saffirepro_both_clk_src_get.
Date: Mon, 27 Oct 2014 22:41:13 +0900
Message-ID: <544E4B79.90407@sakamocchi.jp>
References: <1414237241-18984-1-git-send-email-vogelchr@vogel.cx>
 <1414237241-18984-2-git-send-email-vogelchr@vogel.cx>
 <544E40D4.4090705@sakamocchi.jp> <s5hbnox4pvq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 04085261171
 for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2014 14:41:20 +0100 (CET)
In-Reply-To: <s5hbnox4pvq.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Christian Vogel <vogelchr@vogel.cx>
List-Id: alsa-devel@alsa-project.org

Hi,

On Oct 27 2014 22 13  Takashi Iwai wrote:
> About the patch:
>>> +/* Value maps between registers and labels for SaffirePro 10/26. */
>>> +static const char saffirepro_clk_maps[][SAFFIREPRO_CLOCK_SOURCE_COUNT] = {
>>> +	/* SaffirePro 10 */
>>> +	[0] = {
>>> +		[SAFFIREPRO_CLOCK_SOURCE_INTERNAL]  =  0,
>>> +		[SAFFIREPRO_CLOCK_SOURCE_SKIP]      = -1, /* not supported */
> 
> If you need to handle a negative value, you must specify "signed
> char".  Without "signed" prefix, it might be unsigned, depending on
> the architecture, in the case of char.
>
>>>  static int
>>>  saffirepro_both_clk_src_get(struct snd_bebob *bebob, unsigned int *id)
>>>  {
>>>  	int err;
>>> -	u32 value;
>>> +	u32 value;       /* clock source read from hw register */
>>> +	const char *map;
> 
> Ditto.

Yep, exactly. I missed them...

Thanks for your indication and applying to the branch, C.C.ed to stable:
http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/?h=for-linus&id=d1d0b6b668818571122d30d68a0b3f768bd83a52


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
