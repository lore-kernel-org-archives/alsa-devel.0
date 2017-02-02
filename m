From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 2/2] ASoc: Add devictree bindings for CS35L35 CODEC
Date: Thu, 2 Feb 2017 09:46:57 -0600
Message-ID: <CAL_JsqL2GiMh4_9dtsxjKBq3xCyoW=rovifO3HjA-ff-rzr41Q@mail.gmail.com>
References: <1485360798-15523-1-git-send-email-brian.austin@cirrus.com>
 <c3224f63-e5d1-4874-8317-c5df53d0207d@EX3.ad.cirrus.com> <20170130201655.zuozjbg5jnhwrezy@rob-hp-laptop>
 <b4c5fd4d-cc0b-4e17-923e-87048f391cec@EX3.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <b4c5fd4d-cc0b-4e17-923e-87048f391cec-XU/xxMRwCJnfk+Ne4bZl5AC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Cc: Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 30, 2017 at 2:39 PM, Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org> wrote:
> On Mon, 30 Jan 2017, Rob Herring wrote:
>
>> On Wed, Jan 25, 2017 at 10:13:18AM -0600, Brian Austin wrote:
>> > Add devicetree bindings documentatin for
>> > Cirrus Logic CS35L35 Boosted Amplifier
>> >
>> > Signed-off-by: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
>> > ---
>> >  .../devicetree/bindings/sound/cs35l35.txt          | 171 +++++++++++++++++++++
>> >  1 file changed, 171 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/sound/cs35l35.txt
>>
>> This looks similar to the CS35L33. Please align the property names and
>> perhaps combine into a single binding doc.
>>
>> Rob
>>
> I can make sure the names are consistent for some of them but most of it
> would be messy to combine into a single doc IMO. I know it looks similar
> for some of them like the algorithm nodes but they are very different in
> parameters and operation.
>
> Would it suffice to just make sure the properties that are the same be
> reflected across both docs?

That would be move in the right direction. Then we can see how
different they are.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
