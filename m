From: Caleb Crome <caleb@crome.org>
Subject: Re: Multiple codecs on one sound card for
	multi-channel sound card
Date: Mon, 14 Sep 2015 18:07:39 -0700
Message-ID: <CAG5mAdzyQgOmTcAmHrjWRQzuv-ih9p-qXQsYxdTD_Qmr-Fep3A@mail.gmail.com>
References: <CAG5mAdyL-xH2ZNTtDMhCWW-nAX_GVtRxFS5b5FANFnK64kE65g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f173.google.com (mail-io0-f173.google.com
 [209.85.223.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 9092E2606CB
 for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2015 03:08:00 +0200 (CEST)
Received: by iofb144 with SMTP id b144so186563399iof.1
 for <alsa-devel@alsa-project.org>; Mon, 14 Sep 2015 18:07:59 -0700 (PDT)
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

(re-sending hope it's not a duplicate -- I think I must have had HTML
in my previous email and it was ignored)

 Hi all,
    What are the current best practices to specify multiple codecs on
one sound card, with all codecs sharing a single TDM bus?

 I have a card with up to 32 TLV320AIC33 codecs on it.  For the
moment, we can limit the discussion to only 16 codecs, so we don't
have to get extra serializers involved...

 I currently have something like this in my am335x-boneblack.dts file:

 (i.e. attempting to set tdm slot width and num in the i2c codec)

 but it doesn't seem to be picking up the fact that I want all the
codecs linked together as one.

 (FYI, the first codec, i.e. tlv32aic3x_a should be the master, and
all others including the CPU will be slaves).

 Thanks for any help!

 BTW, I'm happy to use whatever kernel will support me with the
minimal amount of effort, currently using 4.1



Thank you!
   -Caleb

&i2c1 {
 ...
tlv320aic3x_a: tlv320aic3x@18 {
#sound-dai-cells = <1>;
compatible = "ti,tlv320aic3x";
reg = <0x18>;
tdm-offset = <0>;
status = "okay";
};
tlv320aic3x_b: tlv320aic3x@19 {
#sound-dai-cells = <1>;
compatible = "ti,tlv320aic3x";
reg = <0x19>;
tdm-offset = <32>;
status = "okay";
};
tlv320aic3x_c: tlv320aic3x@1a {
#sound-dai-cells = <1>;
compatible = "ti,tlv320aic3x";
reg = <0x1a>;
tdm-offset = <64>;
status = "okay";
};
tlv320aic3x_d: tlv320aic3x@1b {
#sound-dai-cells = <1>;
compatible = "ti,tlv320aic3x";
reg = <0x1b>;
tdm-offset = <96>;
status = "okay";
};
};

&mcasp0 {
#sound-dai-cells = <0>;
pinctrl-names = "default";
pinctrl-0 = <&mcasp_0_pins_default>;
status = "okay";

op-mode = <0>;          /* MCASP_IIS_MODE */
tdm-slots = <16>;
num-serializer = <16>;
serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
0 0 1 2
0 0 0 0
0 0 0 0
0 0 0 0
>;
tx-num-evt = <1>;
rx-num-evt = <1>;
};

/ {
sound {
compatible = "simple-audio-card";
simple-audio-card,name = "puppy-audio";
simple-audio-card,mclk-fs = <256>;
system-clock-frequency = <12288000>;
status = "okay";
simple-audio-card,bitclock-master = <&tlv320aic3x_a>;
      simple-audio-card,frame-master    = <&tlv320aic3x_a>;
simple-audio-card,widgets =
"Line", "Line Out",
"Line", "Line In";
simple-audio-card,routing =
"Line Out",       "HPLOUT",
"Line Out",       "HPROUT",
"Line In",        "LINE1L",
"Line In",        "LINE1R";

simple-audio-card,dai-link@0 {
format = "left_j";
cpu {
sound-dai = <&mcasp0>;
};
codec {
sound-dai = <&tlv320aic3x_a 0>;
dai-tdm-slot-num = <0>;
dai-tdm-slot-width = <16>;
};
};
/**** The stuff below doesn't work -- I can't figure out how to get
the name_prefixes set
 on each codec... .How do I set up so that each codec gets its own name prfix
and so that the soc core thinks all codecs are on the same DAI?
**** */

// simple-audio-card,dai-link@1 {
// format = "left_j";
// cpu {
// sound-dai = <&mcasp0>;
// };
// codec {
// sound-dai = <&tlv320aic3x_b 0>;
// dai-tdm-slot-num = <2>;
// dai-tdm-slot-width = <16>;
// };
// };
// simple-audio-card,dai-link@2 {
// format = "left_j";
// cpu {
// sound-dai = <&mcasp0>;
// };
// codec {
// sound-dai = <&tlv320aic3x_c>;
// dai-tdm-slot-num = <4>;
// dai-tdm-slot-width = <16>;
// };
// };
// simple-audio-card,dai-link@3 {
// format = "left_j";
// cpu {
// sound-dai = <&mcasp0>;
// };
// codec {
// sound-dai = <&tlv320aic3x_d>;
// dai-tdm-slot-num = <6>;
// dai-tdm-slot-width = <16>;
// };
// };
};
};
