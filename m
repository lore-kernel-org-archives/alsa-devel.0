From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH 02/12] ASoC: dapm: Implement stereo mixer
 control support
Date: Thu, 27 Oct 2016 22:02:39 +0800
Message-ID: <CAGb2v66gyJuakf_5mQJvuQ8VY3rRZtgkk2e=mCJqFT0pFBX=YA@mail.gmail.com>
References: <20161003110804.28235-1-wens@csie.org> <20161003110804.28235-3-wens@csie.org>
 <20161026175052.GE25322@sirena.org.uk>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCMILY6JWQBBBHESZDAAKGQECPV65MI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20161026175052.GE25322-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 27, 2016 at 1:50 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Mon, Oct 03, 2016 at 07:07:54PM +0800, Chen-Yu Tsai wrote:
>
>>       /* find dapm widget path assoc with kcontrol */
>>       dapm_kcontrol_for_each_path(path, kcontrol) {
>> +             /*
>> +              * If status for the second channel was given ( >= 0 ),
>> +              * consider the second and later paths as the second
>> +              * channel.
>> +              */
>> +             if (found && rconnect >= 0)
>> +                     soc_dapm_connect_path(path, rconnect, "mixer update");
>> +             else
>> +                     soc_dapm_connect_path(path, connect, "mixer update");
>>               found = 1;
>> -             soc_dapm_connect_path(path, connect, "mixer update");
>
> This really only works for two channels with the current inteface - the
> comment makes it sound like it'll work for more but we can only pass in
> two (and there's only support for specifying two everywhere).

I could rework it to pass a list of connected status' and the number
of elements instead, but it wouldn't work well for situations where
the number of channels on the kcontrol != the number of paths. I'm not
sure if that's even a valid setup, but it does work with the current
core code.

On the other hand, are there kcontrols that are multi-channel
(> 2 channels)?

I'm inclined to just fixup the comment to make it clear that the
implementation supports stereo, i.e. 2 channels, only.

>
>> -     change = dapm_kcontrol_set_value(kcontrol, val);
>> +     /* This assumes field width < (bits in unsigned int / 2) */
>> +     change = dapm_kcontrol_set_value(kcontrol, val | (rval << width));
>
> That seems like a bit of an assumption in cases where we've got a single
> control for both power and volume?  They're very rare though, I'm not
> even sure any exist.  It'd be good to have a check in the code just in
> case it does come up, it'll likely be a nightmare to debug if someone
> does run into it.

Agreed. I'll put a check and warning before it.

>
> Otherwise I think this makes sense.

Thanks for the review!

Regards
ChenYu
