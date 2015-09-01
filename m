From: Shadi Abdu-Rahman <transienta@gmail.com>
Subject: Beaglebone Black: Transmit buffer underflows when
 trying to play audio using an externally attached codec board (simple-card,
 davinci-mcasp, cs4270)
Date: Tue, 1 Sep 2015 12:49:17 +0200
Message-ID: <55E582AD.1000804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f170.google.com (mail-lb0-f170.google.com
 [209.85.217.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 142EB264F1D
 for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2015 12:49:20 +0200 (CEST)
Received: by lbbtg9 with SMTP id tg9so76493795lbb.1
 for <alsa-devel@alsa-project.org>; Tue, 01 Sep 2015 03:49:19 -0700 (PDT)
Received: from ShadiMBP.local (c-82-209-133-73.cust.bredband2.com.
 [82.209.133.73])
 by smtp.googlemail.com with ESMTPSA id b3sm1268936lak.26.2015.09.01.03.49.18
 for <alsa-devel@alsa-project.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 01 Sep 2015 03:49:18 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

I'm having trouble using an audio codec board with a custom device tree =

overlay (see below) with the Beaglebone Black (kernel 4.1.3-bone15). =

When exporting the overlay, the codecs seem to register fine:

    dmesg:
    [ 1375.144463] bone_capemgr bone_capemgr: part_number
    'BB-BONE-XA-SK-AU', version 'N/A'
    [ 1375.152305] bone_capemgr bone_capemgr: slot #4: override
    [ 1375.157799] bone_capemgr bone_capemgr: Using override eeprom data
    at slot 4
    [ 1375.164864] bone_capemgr bone_capemgr: slot #4: 'Override Board
    Name,00A0,Override Manuf,BB-BONE-XA-SK-AU'
    [ 1375.206351] bone_capemgr bone_capemgr: slot #4: dtbo
    'BB-BONE-XA-SK-AU-00A0.dtbo' loaded; overlay id #0
    [ 1375.464260] cs4270 2-0048: found device at i2c address 48
    [ 1375.469699] cs4270 2-0048: hardware revision 3
    [ 1375.485782] cs4270 2-0049: found device at i2c address 49
    [ 1375.491222] cs4270 2-0049: hardware revision 3
    [ 1375.504744] (NULL device *): Setting gpio_int_masterclk_enable =3D 0
    [ 1375.513334] asoc-simple-card ocp:sound: cs4270-hifi <->
    48038000.mcasp mapping ok
    [ 1375.521095] (NULL device *): Setting gpio_int_masterclk_enable =3D 0
    [ 1375.529893] asoc-simple-card ocp:sound: cs4270-hifi <->
    48038000.mcasp mapping ok

    aplay -l:
    **** List of PLAYBACK Hardware Devices ****
    card 0: XMOSAudioSlice [XMOS-Audio-Slice], device 0:
    davinci-mcasp.0-cs4270-hifi-a cs4270-hifi-0 []
       Subdevices: 1/1
       Subdevice #0: subdevice #0
    card 0: XMOSAudioSlice [XMOS-Audio-Slice], device 1:
    davinci-mcasp.0-cs4270-hifi-b cs4270-hifi-1 []
       Subdevices: 1/1
       Subdevice #0: subdevice #0

    lsmod:
    snd_soc_davinci_mcasp    14391  2
    snd_soc_simple_card     8156  0
    snd_soc_edma            1150  1 snd_soc_davinci_mcasp
    snd_soc_cs4270          6875  2
    snd_soc_omap            2573  1 snd_soc_davinci_mcasp
    snd_soc_core          156881  5
    snd_soc_davinci_mcasp,snd_soc_edma,snd_soc_omap,snd_soc_simple_card,snd=
_soc_cs4270
    snd_compress           11668  1 snd_soc_core
    snd_pcm_dmaengine       5061  2 snd_soc_core,snd_soc_omap
    snd_pcm                77081  4
    snd_soc_davinci_mcasp,snd_soc_core,snd_soc_omap,snd_pcm_dmaengine
    snd_timer              16860  1 snd_pcm
    snd                    56902  4
    snd_soc_core,snd_timer,snd_pcm,snd_compress
    soundcore               6869  1 snd
    pvrsrvkm              147014  0
    omap_aes               13089  0
    omap_sham              19190  0
    tda998x                11683  1
    tilcdc                 27919  0
    omap_rng                4354  0
    rng_core                7270  1 omap_rng
    drm_kms_helper        106610  3 tda998x,tilcdc
    uio_pdrv_genirq         3317  0
    leds_gpio               3102  0
    uio                     8330  1 uio_pdrv_genirq||

||

|
|but when I try to play an audio file I get a stream of transmit buffer =

underflows and no audio:

    aplay test128.wav:
    Playing WAVE 'test128.wav' : Signed 16 bit Little Endian, Rate 48000
    Hz, Stereo
    underrun!!! (at least 1.630 ms long)
    underrun!!! (at least 5.413 ms long)
    underrun!!! (at least 0.636 ms long)
    underrun!!! (at least 5.369 ms long)
    underrun!!! (at least 0.217 ms long)
    underrun!!! (at least 0.641 ms long)
    underrun!!! (at least 5.254 ms long)

    dmesg:
    [ 1493.190031] davinci-mcasp 48038000.mcasp: Transmit buffer underflow
    [ 1493.201647] davinci-mcasp 48038000.mcasp: Transmit buffer underflow
    [ 1493.218719] davinci-mcasp 48038000.mcasp: Transmit buffer underflow
    [ 1493.229946] davinci-mcasp 48038000.mcasp: Transmit buffer underflow
    [ 1493.245328] davinci-mcasp 48038000.mcasp: Transmit buffer underflow
    [ 1493.259411] davinci-mcasp 48038000.mcasp: Transmit buffer underflow
    [ 1493.270549] davinci-mcasp 48038000.mcasp: Transmit buffer underflow

Using a software oscilloscope, I can see that the frame clock starts on =

mcasp0_fsx frame clock line but stops after a few periods. There=92s no =

activity on the on the mcasp0_axr2 audio out line.

I'm not sure if I'm missing something trivial or if this is a general =

with audio out on the Beaglebone Black and 4.1.x kernels. Any pointers =

or help would be much appreciated.

Additional information:
I=92m using the v4.1.3-bone15 linux kernel with =

debian-8.1-minimal-armhf-2015-06-09 compiled as per Robert C Nelsons =

instructions (https://eewiki.net/display/linuxonarm/BeagleBone+Black).

The board I=92m using is an XMOS XA-SK-AUDIO slice and consists of two =

Cirrus Logic cs4270 codecs and an onboard oscillator generating the =

master clock. I=92ve interfaced the board to a XMOS micro controller to =

make sure the board is in working order (and it is). When connected to =

the BBB, reset de-assertion and some initial i2c codec configuration =

(setting the codecs in software mode) are handled by the same XMOS micro =

controller.

The overlay I=92m using looks like this:

    /dts-v1/;
    /plugin/;

    / {
         compatible =3D "ti,beaglebone", "ti,beaglebone-black";
         part-number =3D "BB-BONE-XA-SK-AU";
         version =3D "00A0";

         exclusive-use =3D
             /* pin header usage */
             "P9.25",    /* mcasp0_ahclkx <- MCLK */
             "P9.31",    /* mcasp0_aclkx <-> BCLK*/
             "P9.29",    /* mcasp0_fsx <-> LRCLK */
             "P9.30",    /* mcasp0_axr0 <- ADC_DATA0 */
             "P9.41",    /* mcasp0_axr1 <- ADC_DATA1 */
             "P9.28",    /* mcasp0_axr2 -> DAC_DATA0 */
             "P9.27",    /* mcasp0_axr3 -> DAC_DATA1 */
             /* hardware ip usage */
             "gpio0_15",    /* ext-mclk-sel -> MCLK_FSEL */
             "gpio0_20", /* CLKOUT2 disabled */
             "gpio1_27", /* internal 24.576 MHz oscillator disabled */
             "mcasp0";

         fragment@0 {
             target =3D <&am33xx_pinmux>;
             __overlay__ {
                 i2c2_pins: pinmux_i2c2_pins {
                     pinctrl-single,pins =3D <
                         /* Pullup resistors available on codec board */
                         0x17c 0x2b        /* i2c2_scl, (PIN_INPUT |
    MUX_MODE3) */
                         0x178 0x2b        /* i2c2_sda, (PIN_INPUT |
    MUX_MODE3) */
                     >;
                 };

                 mcasp0_pins: pinmux_mcasp0_pins {
                     pinctrl-single,pins =3D <
                         0x1ac 0x20        /* mcasp0_ahclkx,
    (PIN_INPUT_PULLDOWN | MUX_MODE0) */
                         0x190 0x20        /* mcasp0_aclkx,
    (PIN_INPUT_PULLDOWN | MUX_MODE0) */
                         0x194 0x20        /* mcasp0_fsx,
    (PIN_INPUT_PULLDOWN | MUX_MODE0) */
                         0x198 0x20        /* mcasp0_axr0,
    (PIN_INPUT_PULLDOWN | MUX_MODE0) */
                         0x1a8 0x20        /* mcasp0_axr1,
    (PIN_INPUT_PULLDOWN | MUX_MODE0) */
                         0x19c 0x02        /* mcasp0_axr2,
    (PIN_OUTPUT_PULLDOWN | MUX_MODE2) */
                         0x1a4 0x02        /* mcasp0_axr3,
    (PIN_OUTPUT_PULLDOWN | MUX_MODE2) */
                         /* disable internal 24.576 MHz oscillator */
                         0x06c 0x07      /* gpio1_27,
    (PIN_OUTPUT_PULLDOWN | MUX_MODE7) */
                     >;
                 };

                 gpio_pins: pinmux_gpio_pins {
                     pinctrl-single,pins =3D <
                         /* ext-mclk-sel */
                         0x184 0x17        /* gpio0_15,
    (PIN_OUTPUT_PULLUP | MUX_MODE7) */
                         /* disable CLKOUT2 to allow usage of
    mcasp0_axr1 on P9_41 */
                         0x1b4 0x2b        /* gpio0_20, (PIN_INPUT |
    MUX_MODE3) */
                     >;
                 };
             };
         };

         fragment@1 {
             target =3D <&i2c2>;
             __overlay__ {
                 pinctrl-names =3D "default";
                 pinctrl-0 =3D <&i2c2_pins>;
                 status =3D "okay";
                 #address-cells =3D <1>;
                 #size-cells =3D <0>;
                 clock-frequency =3D <100000>;

                 cs4270m: cs4270@48 {
                     compatible =3D "cirrus,cs4270";
                     status =3D "okay";
                     #sound-dai-cells =3D <0>;
                     reg =3D <0x48>;
                     name-prefix =3D "a";
                     va-supply =3D <&ldo4_reg>;
                     vd-supply =3D <&ldo4_reg>;
                     vlc-supply =3D <&ldo4_reg>;
                 };

                 cs4270s: cs4270@49 {
                     compatible =3D "cirrus,cs4270";
                     status =3D "okay";
                     #sound-dai-cells =3D <0>;
                     reg =3D <0x49>;
                     name-prefix =3D "b";
                     va-supply =3D <&ldo4_reg>;
                     vd-supply =3D <&ldo4_reg>;
                     vlc-supply =3D <&ldo4_reg>;
                 };
             };
         };

         fragment@2 {
             target =3D <&mcasp0>;
             __overlay__ {
                 pinctrl-names =3D "default";
                 pinctrl-0 =3D <&mcasp0_pins>;
                 status =3D "okay";
                 #sound-dai-cells =3D <0>;
                 op-mode =3D <0>;    // MCASP_IIS_MODE
                 tdm-slots =3D <2>;
                 num-serializer =3D <4>;
                 serial-dir =3D <        // 0: INACTIVE, 1: TX, 2: RX
                     2 2 1 1
                 >;
                 tx-num-evt =3D <1>;
                 rx-num-evt =3D <1>;
             };
         };

         fragment@3 {
             target =3D <&ocp>;
             __overlay__ {
                 sound {
                     compatible =3D "simple-audio-card";
                     simple-audio-card,name =3D "XMOS-Audio-Slice";

                     simple-audio-card,widgets =3D
                         "Line", "Line In 1",
                         "Line", "Line Out 1",
                         "Line", "Line In 2",
                         "Line", "Line Out 2"
                         ;
                     simple-audio-card,routing =3D
                         "a AINA", "Line In 1",
                         "a AINB", "Line In 1",
                         "Line Out 1", "a AOUTA",
                         "Line Out 1", "a AOUTB",
                         "b AINA", "Line In 2",
                         "b AINB", "Line In 2",
                         "Line Out 2", "b AOUTA",
                         "Line Out 2", "b AOUTB"
                         ;

                     simple-audio-card,int-masterclk-enable =3D <&gpio1 27 =
0>;

                     simple-audio-card,dai-link@1 {
                         format =3D "i2s";
                         frame-master =3D <&cpu_node1>;
                         bitclock-master =3D <&cpu_node1>;
                         cpu_node1: cpu {
                             sound-dai =3D <&mcasp0>;
                             system-clock-frequency =3D <24576000>;
                         };
                         codec_node1: codec {
                             sound-dai =3D <&cs4270s>;
                             system-clock-frequency =3D <24576000>;
                         };
                     };

                     simple-audio-card,dai-link@0 {
                         format =3D "i2s";
                         frame-master =3D <&cpu_node0>;
                         bitclock-master =3D <&cpu_node0>;
                         cpu_node0: cpu {
                             sound-dai =3D <&mcasp0>;
                             system-clock-frequency =3D <24576000>;
                         };
                         codec_node0: codec {
                             sound-dai =3D <&cs4270m>;
                             system-clock-frequency =3D <24576000>;
                         };
                     };
                 };
             };
         };
    };


I've also made modifications to cs4270.c, simple-card.c, and soc-core.c =

to add a mechanism to disable the internal BBB master clock (in =

simple-card.c), as well as to fix issues with missing source/sink =

widgets (this seems to be a bug in cs4270.c):

    [  137.408549] cs4270 2-0048: ASoC: no source widget found for AINA
    [  137.414737] cs4270 2-0048: ASoC: Failed to add route AINA ->
    direct -> Capture
    [  137.422016] cs4270 2-0048: ASoC: no source widget found for AINB
    [  137.428137] cs4270 2-0048: ASoC: Failed to add route AINB ->
    direct -> Capture
    [  137.435477] cs4270 2-0048: ASoC: no sink widget found for AOUTA
    [  137.441445] cs4270 2-0048: ASoC: Failed to add route Playback ->
    direct -> AOUTA
    [  137.448928] cs4270 2-0048: ASoC: no sink widget found for AOUTB
    [  137.454922] cs4270 2-0048: ASoC: Failed to add route Playback ->
    direct -> AOUTB

and name collisions, arising from using two identical codecs (by hacking =

together name-prefix support in simple-card):

    [   51.364492] asoc-simple-card ocp:sound: control 2:0:0:Master
    Playback Volume:0 is already present
    [   51.373469] cs4270 2-0049: ASoC: Failed to add Master Playback
    Volume: -16
    ...
    [   51.393905] ------------[ cut here ]------------
    [   51.398561] WARNING: CPU: 0 PID: 44 at fs/sysfs/dir.c:31
    sysfs_warn_dup+0x51/0x5c()
    [   51.406281] sysfs: cannot create duplicate filename
    '/devices/platform/ocp/ocp:sound/davinci-mcasp.0-cs4270-hifi'

The modifications are as follows:

    diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
    index e6d4ff9..4805747 100644
    --- a/sound/soc/codecs/cs4270.c
    +++ b/sound/soc/codecs/cs4270.c
    @@ -140,11 +140,11 @@ struct cs4270_private {
      };

      static const struct snd_soc_dapm_widget cs4270_dapm_widgets[] =3D {
    -SND_SOC_DAPM_INPUT("AINL"),
    -SND_SOC_DAPM_INPUT("AINR"),
    +SND_SOC_DAPM_INPUT("AINA"),
    +SND_SOC_DAPM_INPUT("AINB"),

    -SND_SOC_DAPM_OUTPUT("AOUTL"),
    -SND_SOC_DAPM_OUTPUT("AOUTR"),
    +SND_SOC_DAPM_OUTPUT("AOUTA"),
    +SND_SOC_DAPM_OUTPUT("AOUTB"),
      };

      static const struct snd_soc_dapm_route cs4270_dapm_routes[] =3D {
    diff --git a/sound/soc/generic/simple-card.c
    b/sound/soc/generic/simple-card.c
    index 33feee9..1383b0f 100644
    --- a/sound/soc/generic/simple-card.c
    +++ b/sound/soc/generic/simple-card.c
    @@ -28,6 +28,7 @@ struct simple_card_data {
              struct asoc_simple_dai codec_dai;
          } *dai_props;
          unsigned int mclk_fs;
    +    int gpio_int_masterclk_enable;
          int gpio_hp_det;
          int gpio_hp_det_invert;
          int gpio_mic_det;
    @@ -50,7 +51,7 @@ static int asoc_simple_card_startup(struct
    snd_pcm_substream *substream)
          ret =3D clk_prepare_enable(dai_props->cpu_dai.clk);
          if (ret)
              return ret;
    -
    +
          ret =3D clk_prepare_enable(dai_props->codec_dai.clk);
          if (ret)
              clk_disable_unprepare(dai_props->cpu_dai.clk);
    @@ -167,6 +168,12 @@ static int asoc_simple_card_dai_init(struct
    snd_soc_pcm_runtime *rtd)
          if (ret < 0)
              return ret;

    +    /* TODO: Logic for enabling internal clock if specified in DT*/
    +    if (gpio_is_valid(priv->gpio_int_masterclk_enable)) {
    +        dev_info(NULL, "Setting gpio_int_masterclk_enable =3D 0");
    +        gpio_set_value(priv->gpio_int_masterclk_enable, 0);
    +    }
    +
          if (gpio_is_valid(priv->gpio_hp_det)) {
              snd_soc_card_jack_new(rtd->card, "Headphones",
                            SND_JACK_HEADPHONE,
    @@ -195,16 +202,18 @@ static int asoc_simple_card_dai_init(struct
    snd_soc_pcm_runtime *rtd)
      }

      static int
    -asoc_simple_card_sub_parse_of(struct device_node *np,
    -                  struct asoc_simple_dai *dai,
    -                  struct device_node **p_node,
    -                  const char **name,
    -                  int *args_count)
    +asoc_simple_card_sub_parse_of(struct simple_card_data *priv,
    +                    struct device_node *np,
    +                    struct asoc_simple_dai *dai,
    +                    struct device_node **p_node,
    +                    const char **name,
    +                    int *args_count, bool codec_device, int idx)
      {
          struct of_phandle_args args;
          struct clk *clk;
          u32 val;
          int ret;
    +    const char *str =3D NULL;

          /*
           * Get node via "sound-dai =3D <&phandle port>"
    @@ -225,6 +234,18 @@ asoc_simple_card_sub_parse_of(struct
    device_node *np,
          if (ret < 0)
              return ret;

    +    /* get name-prefix */
    +    if (codec_device) {
    +        /* NULL bypasses the device name check in soc-core */
    +        priv->snd_card.codec_conf[idx].dev_name =3D NULL;
    +        priv->snd_card.codec_conf[idx].of_node =3D *p_node;
    +        of_property_read_string(*p_node, "name-prefix", &str);
    +        if (str)
    +            priv->snd_card.codec_conf[idx].name_prefix =3D str;
    +        else
    +            priv->snd_card.codec_conf[idx].name_prefix =3D NULL;
    +    }
    +
          /* Parse TDM slot */
          ret =3D snd_soc_of_parse_tdm_slot(np, &dai->slots,
    &dai->slot_width);
          if (ret)
    @@ -334,16 +355,16 @@ static int asoc_simple_card_dai_link_of(struct
    device_node *node,
          if (ret < 0)
              goto dai_link_of_err;

    -    ret =3D asoc_simple_card_sub_parse_of(cpu, &dai_props->cpu_dai,
    +    ret =3D asoc_simple_card_sub_parse_of(priv, cpu, &dai_props->cpu_d=
ai,
                              &dai_link->cpu_of_node,
                              &dai_link->cpu_dai_name,
    -                        &cpu_args);
    +                        &cpu_args, false, idx);
          if (ret < 0)
              goto dai_link_of_err;

    -    ret =3D asoc_simple_card_sub_parse_of(codec, &dai_props->codec_dai,
    +    ret =3D asoc_simple_card_sub_parse_of(priv, codec,
    &dai_props->codec_dai,
                              &dai_link->codec_of_node,
    -                        &dai_link->codec_dai_name, NULL);
    +                        &dai_link->codec_dai_name, NULL, true, idx);
          if (ret < 0)
              goto dai_link_of_err;

    @@ -357,8 +378,10 @@ static int asoc_simple_card_dai_link_of(struct
    device_node *node,

          /* DAI link name is created from CPU/CODEC dai name */
          name =3D devm_kzalloc(dev,
    -                strlen(dai_link->cpu_dai_name)   +
    -                strlen(dai_link->codec_dai_name) + 2,
    +                strlen(dai_link->cpu_dai_name) +
    +                strlen(dai_link->codec_dai_name) +
    +                (priv->snd_card.codec_conf[idx].name_prefix ?
    + strlen(priv->snd_card.codec_conf[idx].name_prefix) + 3 : 2),
                      GFP_KERNEL);
          if (!name) {
              ret =3D -ENOMEM;
    @@ -367,6 +390,9 @@ static int asoc_simple_card_dai_link_of(struct
    device_node *node,

          sprintf(name, "%s-%s", dai_link->cpu_dai_name,
                      dai_link->codec_dai_name);
    +    if (priv->snd_card.codec_conf[idx].name_prefix)
    +        sprintf(name, "%s-%s", name,
    +                priv->snd_card.codec_conf[idx].name_prefix);
          dai_link->name =3D dai_link->stream_name =3D name;
          dai_link->ops =3D &asoc_simple_card_ops;
          dai_link->init =3D asoc_simple_card_dai_init;
    @@ -459,6 +485,15 @@ static int asoc_simple_card_parse_of(struct
    device_node *node,
                  return ret;
          }

    +    /* request GPIO to control internal 24.576MHz oscillator */
    +    priv->gpio_int_masterclk_enable =3D of_get_named_gpio_flags(node,
    +                "simple-audio-card,int-masterclk-enable", 0, &flags);
    +
    +    if (priv->gpio_int_masterclk_enable =3D=3D -EPROBE_DEFER)
    +        return -EPROBE_DEFER;
    +    gpio_request_one(priv->gpio_int_masterclk_enable,
    GPIOF_OUT_INIT_LOW,
    +                   "Internal Clock Enable Pin");
    +
          priv->gpio_hp_det =3D of_get_named_gpio_flags(node,
                      "simple-audio-card,hp-det-gpio", 0, &flags);
          priv->gpio_hp_det_invert =3D !!(flags & OF_GPIO_ACTIVE_LOW);
    @@ -498,13 +533,18 @@ static int asoc_simple_card_probe(struct
    platform_device *pdev)
          struct snd_soc_dai_link *dai_link;
          struct device_node *np =3D pdev->dev.of_node;
          struct device *dev =3D &pdev->dev;
    -    int num_links, ret;
    +    int num_links =3D (np && of_get_child_by_name(np,
    +                    "simple-audio-card,dai-link")) ?
    +                    of_get_child_count(np) : 1;
    +    struct snd_soc_codec_conf codec_conf[num_links];
    +    int ret;

    -    /* Get the number of DAI links */
    +    /* Get the number of DAI links
          if (np && of_get_child_by_name(np, "simple-audio-card,dai-link"))
              num_links =3D of_get_child_count(np);
          else
              num_links =3D 1;
    +    */

          /* Allocate the private data and the DAI link array */
          priv =3D devm_kzalloc(dev,
    @@ -519,6 +559,8 @@ static int asoc_simple_card_probe(struct
    platform_device *pdev)
          dai_link =3D priv->dai_link;
          priv->snd_card.dai_link =3D dai_link;
          priv->snd_card.num_links =3D num_links;
    +    priv->snd_card.codec_conf =3D codec_conf;
    +    priv->snd_card.num_configs =3D num_links;

          priv->gpio_hp_det =3D -ENOENT;
          priv->gpio_mic_det =3D -ENOENT;
    @@ -589,6 +631,11 @@ static int asoc_simple_card_remove(struct
    platform_device *pdev)
          struct snd_soc_card *card =3D platform_get_drvdata(pdev);
          struct simple_card_data *priv =3D snd_soc_card_get_drvdata(card);

    +    if (gpio_is_valid(priv->gpio_int_masterclk_enable)) {
    +        gpio_set_value(priv->gpio_int_masterclk_enable, 0);
    +        gpio_free(priv->gpio_int_masterclk_enable);
    +    }
    +
          if (gpio_is_valid(priv->gpio_hp_det))
              snd_soc_jack_free_gpios(&simple_card_hp_jack, 1,
                          &simple_card_hp_jack_gpio);
    diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
    index 2373252..4808089 100644
    --- a/sound/soc/soc-core.c
    +++ b/sound/soc/soc-core.c
    @@ -1102,6 +1102,9 @@ static void soc_set_name_prefix(struct
    snd_soc_card *card,

          for (i =3D 0; i < card->num_configs; i++) {
              struct snd_soc_codec_conf *map =3D &card->codec_conf[i];
    +
    +        if (!map->name_prefix)
    +            continue;
              if (map->of_node && component->dev->of_node !=3D map->of_node)
                  continue;
              if (map->dev_name && strcmp(component->name, map->dev_name))

Another possible bug:
Adding name-prefix support to simple-card uncovers a possible bug. =

You'll notice in the device tree overlay that I'v listed the =

simple-audio-card dai-links in reverse order, with dai-link@1 before =

dai-link@0. I've done so because using the normal order the wrong prefix =

gets assigned to the wrong dai-link. I'm not really sure where this =

happens, and it's not a huge issue for me, but I thought I'd report it.

Kind Regards
Shadi Abdu-Rahman
