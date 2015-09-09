From: Caleb Crome <caleb@crome.org>
Subject: Multiple codecs on one sound card for multi-channel
	sound card
Date: Tue, 8 Sep 2015 18:02:27 -0700
Message-ID: <CAG5mAdyL-xH2ZNTtDMhCWW-nAX_GVtRxFS5b5FANFnK64kE65g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f182.google.com (mail-io0-f182.google.com
 [209.85.223.182])
 by alsa0.perex.cz (Postfix) with ESMTP id D559D2650F7
 for <alsa-devel@alsa-project.org>; Wed,  9 Sep 2015 03:02:47 +0200 (CEST)
Received: by iofb144 with SMTP id b144so4922706iof.1
 for <alsa-devel@alsa-project.org>; Tue, 08 Sep 2015 18:02:46 -0700 (PDT)
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

Hi all,
   What's the current best practices to specify multiple codecs on one
sound card, with all codecs sharing a single TDM bus?

I have a card with up to 32 TLV320AIC33 codecs on it.  For the moment, we
can limit the discussion to only 16 codecs, so we don't have to get extra
serializers involved...

I currently have something like this in my am335x-boneblack.dts file:

(i.e. attempting to set tdm slot width and num in the i2c codec)

but it doesn't seem to be pickin up the fact that I want all the codecs
linked together as one.

(FYI, the first codec, i.e. tlv32aic3x_a should be the master, and all
others including the CPU will be slaves).

Thanks for any help!

BTW, I'm happy to use whatever kernel will support me with the minimal
amount of effort!

Sincerely,
  -Caleb


&i2c1 {
clock-frequency = <100000>;
status = "okay";
pinctrl-names = "default";
pinctrl-0 = <&i2c1_pins_default>;
status="okay";

tlv320aic3x_a: tlv320aic3x@18 {
       #sound-dai-cells = <0>;
compatible = "ti,tlv320aic3x";
reg = <0x18>;
status = "okay";
dai-tdm-slot-width = <16>;
dai-tdm-slot-num   = <0>;
};
tlv320aic3x_b: tlv320aic3x@19 {
       #sound-dai-cells = <0>;
compatible = "ti,tlv320aic3x";
reg = <0x19>;
status = "okay";
dai-tdm-slot-width = <16>;
dai-tdm-slot-num   = <2>;
};
tlv320aic3x_c: tlv320aic3x@1a {
compatible = "ti,tlv320aic3x";
reg = <0x1a>;
status = "okay";
dai-tdm-slot-width = <16>;
dai-tdm-slot-num   = <4>;
};
tlv320aic3x_d: tlv320aic3x@1b {
compatible = "ti,tlv320aic3x";
reg = <0x1b>;
status = "okay";
dai-tdm-slot-width = <16>;
dai-tdm-slot-num   = <6>;
};
};

sound {
     compatible = "simple-audio-card";
     simple-audio-card,name = "puck audio";
     // simple-audio-card,widgets=
     // simple-audio-card,routing=
     simple-audio-card,mclk-fs = <256>;
     status="okay";
     simple-audio-card,bitclock-master = <&tlv320aic3x_a>;
     simple-audio-card,frame-master    = <&tlv320aic3x_a>;
     simple-audio-card,dai-link@0 {
          format = "left_j";
  cpu {
    sound-dai = <&mcasp0 0>;
  };

// *** Here's where I'm really confused -- this part doesn't seem to be
supported to
// have all the codecs on a single DAI.
// The examples given  seem to be for different codec DAIs
// sharing a single CPU DAI, but not used at the same time.

  codec {
    #sound-dai-cells = <0>;
    sound-dai          = <
    &tlv320aic3x_a
    &tlv320aic3x_b
    &tlv320aic3x_c
      &tlv320aic3x_d
    >;
  };
     };
};
