From: Caleb Crome <caleb@crome.org>
Subject: Re: Multiple codecs on one sound card for
	multi-channel sound card
Date: Thu, 10 Sep 2015 11:26:17 -0700
Message-ID: <CAG5mAdz4wygvK+OXpc3XPHyi=no+RAfyBrqzEwcfX_J=+sNV2A@mail.gmail.com>
References: <CAG5mAdyL-xH2ZNTtDMhCWW-nAX_GVtRxFS5b5FANFnK64kE65g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f181.google.com (mail-io0-f181.google.com
 [209.85.223.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 6528826067A
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2015 20:26:38 +0200 (CEST)
Received: by ioiz6 with SMTP id z6so71012292ioi.2
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2015 11:26:37 -0700 (PDT)
In-Reply-To: <CAG5mAdyL-xH2ZNTtDMhCWW-nAX_GVtRxFS5b5FANFnK64kE65g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark Brown,
    Looking back on my email notes, you helped me with this back in 2011
with an old kernel version.  I wonder if mutlti-codec-on-single-DAI
configuration is still unsupported by the ASOC core.  I don't see anything
obvious.

If I were to implement it 'properly', what's the right DTS format to go
with?  Something like what I suggest below (i.e. in the simple-audio-card
section, use multiple codecs in a single sound-dai?  If so, where should
the tdm-slot & clocking information go?  In the codec DTS section itself,
or in the sound-dai section?

Thanks again,
 -Caleb



On Tue, Sep 8, 2015 at 6:02 PM, Caleb Crome <caleb@crome.org> wrote:

> Hi all,
>    What's the current best practices to specify multiple codecs on one
> sound card, with all codecs sharing a single TDM bus?
>
> I have a card with up to 32 TLV320AIC33 codecs on it.  For the moment, we
> can limit the discussion to only 16 codecs, so we don't have to get extra
> serializers involved...
>
> I currently have something like this in my am335x-boneblack.dts file:
>
> (i.e. attempting to set tdm slot width and num in the i2c codec)
>
> but it doesn't seem to be pickin up the fact that I want all the codecs
> linked together as one.
>
> (FYI, the first codec, i.e. tlv32aic3x_a should be the master, and all
> others including the CPU will be slaves).
>
> Thanks for any help!
>
> BTW, I'm happy to use whatever kernel will support me with the minimal
> amount of effort!
>
> Sincerely,
>   -Caleb
>
>
> &i2c1 {
> clock-frequency = <100000>;
> status = "okay";
> pinctrl-names = "default";
> pinctrl-0 = <&i2c1_pins_default>;
> status="okay";
>
> tlv320aic3x_a: tlv320aic3x@18 {
>        #sound-dai-cells = <0>;
> compatible = "ti,tlv320aic3x";
> reg = <0x18>;
> status = "okay";
> dai-tdm-slot-width = <16>;
> dai-tdm-slot-num   = <0>;
> };
> tlv320aic3x_b: tlv320aic3x@19 {
>        #sound-dai-cells = <0>;
> compatible = "ti,tlv320aic3x";
> reg = <0x19>;
> status = "okay";
> dai-tdm-slot-width = <16>;
> dai-tdm-slot-num   = <2>;
> };
> tlv320aic3x_c: tlv320aic3x@1a {
> compatible = "ti,tlv320aic3x";
> reg = <0x1a>;
> status = "okay";
> dai-tdm-slot-width = <16>;
> dai-tdm-slot-num   = <4>;
> };
> tlv320aic3x_d: tlv320aic3x@1b {
> compatible = "ti,tlv320aic3x";
> reg = <0x1b>;
> status = "okay";
> dai-tdm-slot-width = <16>;
> dai-tdm-slot-num   = <6>;
> };
> };
>
> sound {
>      compatible = "simple-audio-card";
>      simple-audio-card,name = "puck audio";
>      // simple-audio-card,widgets=
>      // simple-audio-card,routing=
>      simple-audio-card,mclk-fs = <256>;
>      status="okay";
>      simple-audio-card,bitclock-master = <&tlv320aic3x_a>;
>      simple-audio-card,frame-master    = <&tlv320aic3x_a>;
>      simple-audio-card,dai-link@0 {
>           format = "left_j";
>   cpu {
>     sound-dai = <&mcasp0 0>;
>   };
>
> // *** Here's where I'm really confused -- this part doesn't seem to be
> supported to
> // have all the codecs on a single DAI.
> // The examples given  seem to be for different codec DAIs
> // sharing a single CPU DAI, but not used at the same time.
>
>   codec {
>     #sound-dai-cells = <0>;
>     sound-dai          = <
>     &tlv320aic3x_a
>     &tlv320aic3x_b
>     &tlv320aic3x_c
>       &tlv320aic3x_d
>     >;
>   };
>      };
> };
>
>
