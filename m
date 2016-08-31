From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: Re: [PATCH v9 2/2] Add mixer controls: Line-In,
 FM-In, Mic 2, Capture Source, Differential Line-In.
Date: Wed, 31 Aug 2016 15:55:46 +0800
Message-ID: <CAGb2v66jkd7+GMUbihQjA0ec9nDZc=k2yDT3afD1q6qo57PVVA@mail.gmail.com>
References: <20160830054403.7878-1-dannym@scratchpost.org> <20160830054403.7878-3-dannym@scratchpost.org>
 <CAGb2v64zA3iSOe7ku=pF0RhJkvErxt_tbPWG4H8D6r5UEUJAMQ@mail.gmail.com>
 <20160831094044.1c3227d6@scratchpost.org> <CAGb2v67YGiZEzBezub5HcEBZ5689uF1yQYj2xJkbVdHyEpOm5Q@mail.gmail.com>
 <20160831094959.2e5e6ae7@scratchpost.org>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCMILY6JWQBBBGU3TK7AKGQEST75THY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20160831094959.2e5e6ae7-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 31, 2016 at 3:49 PM, Danny Milosavljevic
<dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org> wrote:
> Hi Chen-Yu,
>
>> My apologies. I didn't notice that VMIC was already in the driver.
>> In that your original patch did everything right.
>
> Don't worry about it :)
>
> But I have a question:
>
> If I replace DAPM_INPUT by DAPM_MIC it wants a callback that is supposed to
> fiddle with the bias.
> Do I provide one?
> If so, will it conflict with the supply?
>
> Or do I leave it as DAPM_INPUT ?

I think leaving it as DAPM_INPUT will do. Also, if you use DAPM_MIC or any
other widget type that takes a callback, the callback can be NULL.

I took a quick look at other drivers. The codecs only use non-endpoint
types, like INPUT/OUTPUT. It's up to the card to provide endpoints
(HP/SPEAKER/LINE/MIC) and route them to the codec INPUT/OUTPUTs.


Regards
ChenYu
