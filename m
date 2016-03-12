From: Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: [PATCH v8 2/2] ASoc: sun4i-codec: Add FM, Line
 and Mic inputs
Date: Sat, 12 Mar 2016 09:31:11 +0100
Message-ID: <CAEKpxB=pKsEfMgGEh6KHZE-t+2tFxsyJkyDohS7OkmPCdNhoCg@mail.gmail.com>
References: <20151221123148.1ab6480b@dayas>
	<20151221123416.51aa938e@dayas>
	<20151227182157.GI30359@lukather>
	<20151228040649.475a742f@dayas>
	<20160106220908.GE9631@lukather>
	<20160109164832.515d69b0@dayas>
	<20160312085222.226d89bf@scratchpost.org>
Reply-To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCHNXO4F7MHBBUFHR63QKGQE3Y75EPY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20160312085222.226d89bf-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi Danny,
I've got some patches to go which covers pretty much everything that
we can manage with the sun4i-codec. I'm only lacking testing of
certain bits as I don't have capable hardware(i.e. FM capture). I've
ignored the phone out part of the A20 as I couldn't find the pins.
I'll try to upload them to my github this weekend. You should have
authorship on some of these so when I send the link feel free to
claim.
BR,
CK

On 12 March 2016 at 08:52, Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org> wrote:
> Hi,
>
> does anyone know the answer to the questions below?
>
>> The other direction (making two controls which both do the same and update
>> each other's value) doesn't seem to be easily available.
>
>> Should I write a _put handler that does it manually?
>
>> (Or should that be handled by alsa-lib mixer modules instead?)
>
>> Is it possible to merge the "Left Mixer" control and respective
>> "Right Mixer" control into one selem in alsamixer?
>>
>> Because alsamixer actually has support for one-sided muting.
>
> If that's unknown, I can post v9 without doing the grouping-together of mixer controls and we can use it like that - I don't want the patch to stall indefinitely on mere usability issues...
>
> Regards,
>     Danny
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
> For more options, visit https://groups.google.com/d/optout.
