From: Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 4/6] ASoC: sun4i-i2s: Add multi-lane functionality
Date: Tue, 13 Mar 2018 09:59:03 +0100
Message-ID: <CAEKpxBn6Zxy5nuMPYkPU_UweCqBm+P4M2fd2UqepdojBiOErbQ@mail.gmail.com>
References: <20180312155753.9478-1-codekipper@gmail.com> <20180312155753.9478-5-codekipper@gmail.com>
 <20180313080026.jtag4w46koxzeqe2@flea> <CAEKpxBkE_Aipa3Z6r0HnVNuU-kmfr1zandotZzQ9Z0AkShR=rw@mail.gmail.com>
 <20180313082337.zekrzyx5utx5lkj6@flea>
Reply-To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCHNXO4F7MHBBWFFT3KQKGQE3WSBRNY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20180313082337.zekrzyx5utx5lkj6@flea>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "Andrea Venturi (pers)" <be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 13 March 2018 at 09:23, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org> wrote:
> On Tue, Mar 13, 2018 at 09:15:49AM +0100, Code Kipper wrote:
>> On 13 March 2018 at 09:00, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org> wrote:
>> > On Mon, Mar 12, 2018 at 04:57:51PM +0100, codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
>> >> From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> >>
>> >> The i2s block supports multi-lane i2s output however this functionality
>> >> is only possible in earlier SoCs where the pins are exposed and for
>> >> the i2s block used for HDMI audio on the later SoCs.
>> >>
>> >> To enable this functionality, an optional property has been added to
>> >> the bindings.
>> >>
>> >> Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> >> ---
>> >>  .../devicetree/bindings/sound/sun4i-i2s.txt        |  3 ++
>> >>  sound/soc/sunxi/sun4i-i2s.c                        | 48 +++++++++++++++++-----
>> >>  2 files changed, 41 insertions(+), 10 deletions(-)
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
>> >> index 48addef65b8f..3f966ac61b9e 100644
>> >> --- a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
>> >> +++ b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
>> >> @@ -33,6 +33,9 @@ Optional properties:
>> >>                               configured to extend the slot width to the
>> >>                               value specified. Min 8, Max 32.
>> >>
>> >> +- allwinner,playback-channels:  if this property is present then the number
>> >> +                             of available channels is extended and the
>> >> +                             outputs enabled.
>> >
>> > Isn't it something that is fixed for each generation of SoCs? Can't we
>> > attach it to the compatible?
>>
>> I'm not sure as the documentation is pretty poor. It looks like it is
>> supported by all of the variations that we've seen but only exposed as
>> pins on A10 and A20. I'm also not sure who would ever use it with
>> external devices.
>
> Well, you were saying that it was the case on the older SoCs in your
> commit log, so this needs to be figured out.
>
>> The reason why I've added it is that it is required by HDMI for
>> supporting surround sound on the newer SoCs.
>
> Why isn't that mentionned in your commit log?
>
> Can you post the whole set of changes needed for HDMI audio? this
> would make things much easier to see where you're going.

Maybe we should drop this change for now as basic HDMI audio for two
channels doesn't require it. I've also not tested multi-channel audio
yet.

To get HDMI audio working the following patches are required for the dts
https://github.com/codekipper/linux-sunxi/commit/997c622ae10ef136bae0a35a0e9bf9c6dd27910a
and
https://github.com/codekipper/linux-sunxi/commit/4a81676d30a0262c57ffc0827e46c7934fb3b358

they don't need this patch but do need the slot-width-override patch.

CK
>
> Maxime
>
> --
> Maxime Ripard, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com
