From: Alexandre Schnegg <aschnegg@digger.ch>
Subject: Re: speaker-test error using sgtl5000 and imx27
Date: Wed, 30 Sep 2015 08:48:04 +0200
Message-ID: <560B85A4.4000206@digger.ch>
References: <039601d0ef9b$d40a0460$7c1e0d20$@digger.ch>
 <560A9F92.4070605@digger.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-sh2.infomaniak.ch (smtp-sh2.infomaniak.ch [128.65.195.6])
 by alsa0.perex.cz (Postfix) with ESMTP id 65D2226069D
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 08:48:05 +0200 (CEST)
Received: from smtp4.infomaniak.ch (smtp4.infomaniak.ch [84.16.68.92])
 by smtp-sh.infomaniak.ch (8.14.5/8.14.5) with ESMTP id t8U6m4sH005339
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 08:48:05 +0200
Received: from [192.168.1.33]
 (86.104.105.92.dynamic.wline.res.cust.swisscom.ch [92.105.104.86])
 (authenticated bits=0)
 by smtp4.infomaniak.ch (8.14.5/8.14.5) with ESMTP id t8U6m3Tf024957
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 08:48:04 +0200
In-Reply-To: <560A9F92.4070605@digger.ch>
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

Here are some more informations:

The SSI unit seems to be configured properly but in the SSI interrupt =

status register, the flag TUE0 is set. From the imx27 reference manual:

    Transmitter Underrun Error 0. This flag is set when the TXSR is
    empty (no data to be transmitted), the
    TDE0 flag is set and a transmit time slot occurs. When a transmit
    underrun error occurs, the previous data
    is retransmitted. In Network mode, each time slot requires data
    transmission (unless masked through
    STMSK register), when the transmitter is enabled (TE is set).
    The TUE0 flag causes an interrupt if TIE and TUE0_EN are set.
    The TUE0 bit is cleared by POR and SSI reset. It is also cleared by
    reading the SISR with TUE0 bit set,
    followed by writing to the STX0 register.
    0 Default interrupt is issued to the Core.
    1 Exception interrupt is issued to the Core.

Since the data should be written in the TX fiffo by the DMA I think the =

problem come from it.

To be sure that the problem doesn't come from the codecs, I have tried =

with a TI's TLV320aic23, still not working.

I have tested "aplay /usr/share/sounds/alsa/Front_Left.wav " with =

"snd-dummy" and the command return as expected, but with any codec with =

"simple-card" the command doesn't return.

With kernel 4.3-rc2 I have an error message that I haven't before:

    [ 2951.569027] fsl-ssi-dai 10010000.ssi: Failed to get DMA channel
    capabilities, falling back to period counting: -6
    [ 2951.590684] fsl-ssi-dai 10010000.ssi: Failed to get DMA channel
    capabilities, falling back to period counting: -6

What does it mean ?

Le 29.09.2015 16:26, Alexandre Schnegg a =E9crit :
> Hello,
>
> After a few researches, it seems to me that the problem come from the =

> DMA. The SSI is set up correctly and waits for data from the DMA, but =

> the DMA doesn't not seem to to do his job.
>
> Does anyone can confirm me that the module imx_pcm_dma is working =

> properly with Freescale imx27 and mainline kernel?
>
> Anyone has got an audio codec working with the Freescale  imx27 and =

> mainline kernel?
>
> Thank you in advance for your help.
>
> Best regards
> Alexandre Schnegg
>
> Le 15.09.2015 11:49, Alexandre Schnegg a =E9crit :
>> Hello,
>>
>>
>> I would like to use the Freescale SGTl5000 audio codec with the =

>> Freescale
>> imx27 processor.
>>
>>
>> Unfortunately, I get this error when I try to run < speaker-test >:
>>
>>
>> # speaker-test
>>
>>
>> speaker-test 1.0.28
>>
>>
>> Playback device is default
>>
>> Stream parameters are 48000Hz, S16_LE, 1 channels
>>
>> Using 16 octaves of pink noise
>>
>> Rate set to 48000Hz (requested 48000Hz)
>>
>> Buffer size range from 128 to 32768
>>
>> Period size range from 64 to 16384
>>
>> Using max buffer size 32768
>>
>> Periods =3D 4
>>
>> was set period_size =3D 8192
>>
>> was set buffer_size =3D 32768
>>
>> 0 - Front Left
>>
>> Write error: -5,Input/output error
>>
>> xrun_recovery failed: -5,Input/output error
>>
>> Transfer failed: Input/output error
>>
>>
>> The codec is connected to SSI2 pins and I would like to use the SSI0
>> internal port in asynchronous mode (4 wires). The command interface =

>> is I2C1.
>> The codec seems to work because it generates both bit and frame =

>> clocks (the
>> codec is the master) but no data are coming from the processor. I'm =

>> using
>> kernel 4.1.7 but I have got the same error with versions 3.19.8, =

>> 4.0.5 and
>> 4.0.9. I have also tried the < imx-sgtl5000 > driver and I get the same
>> error. I can use < alsamixer > with no issue.
>>
>>
>> Here are my device tree bindings:
>>
>>
>>                  sound {
>>
>>                                 compatible =3D "simple-audio-card";
>>
>>                                 simple-audio-card,name =3D =

>> "sgtl5000-audio";
>>
>>                                 simple-audio-card,format =3D "i2s";
>>
>> simple-audio-card,bitclock-master =3D
>> <&dailink0_master>;
>>
>>                                 simple-audio-card,frame-master =3D
>> <&dailink0_master>;
>>
>>
>>                                 simple-audio-card,widgets =3D
>>
>>                                                 "Microphone", "Mic =

>> Jack",
>>
>>                                                 "Headphone", "Headphone
>> Jack";
>>
>>
>>                                 simple-audio-card,routing =3D
>>
>>                                                 "MIC_IN", "Mic Jack",
>>
>>                                                 "Mic Jack", "Mic Bias",
>>
>>                                                 "Headphone Jack", =

>> "HP_OUT";
>>
>>
>>                                 simple-audio-card,cpu {
>>
>>                                                 sound-dai =3D <&ssi1 0>;
>>
>>                                 };
>>
>>
>>                                 dailink0_master: =

>> simple-audio-card,codec {
>>
>>                                                 sound-dai =3D <&sgtl5000=
>;
>>
>>                                                 clocks =3D <&mclk>;
>>
>>                                 };
>>
>>
>>                  };
>>
>>
>>                  mclk: asvmpc {
>>
>>                                 #clock-cells =3D <0>;
>>
>>                                 compatible =3D "fixed-clock";
>>
>>                                 clock-frequency =3D <12288000>;
>>
>>                  };
>>
>>
>> &ssi1 {
>>
>>                  #sound-dai-cells =3D <1>;
>>
>>                  status =3D "okay";
>>
>>                  fsl,audmux-port =3D <MX27_AUDMUX_PPCR2_SSI_PINS_2>;
>>
>>                  fsl,port-config =3D <
>>
>>                                 (IMX_AUDMUX_V1_PCR_SYN |
>>
>>   IMX_AUDMUX_V1_PCR_RXDSEL(MX27_AUDMUX_HPCR1_SSI0))
>>
>>                  >;
>>
>> };
>>
>>
>> &audmux {
>>
>>                  pinctrl-names =3D "default";
>>
>>                  pinctrl-0 =3D <&pinctrl_ssi2>;
>>
>>                  status =3D "okay";
>>
>>                  fsl,audmux-port =3D <MX27_AUDMUX_HPCR1_SSI0>;
>>
>>                  fsl,port-config =3D <
>>
>>                                 (IMX_AUDMUX_V1_PCR_SYN |
>>
>>   IMX_AUDMUX_V1_PCR_TFCSEL(MX27_AUDMUX_PPCR2_SSI_PINS_2) |
>>
>>                                 IMX_AUDMUX_V1_PCR_TFSDIR |
>>
>>                                 IMX_AUDMUX_V1_PCR_TCLKDIR |
>>
>>   IMX_AUDMUX_V1_PCR_RXDSEL(MX27_AUDMUX_PPCR2_SSI_PINS_2))
>>
>>                  >;
>>
>> };
>>
>>
>> &i2c1 {
>>
>>                  clock-frequency =3D <100000>;
>>
>>                  pinctrl-names =3D "default";
>>
>>                  pinctrl-0 =3D <&pinctrl_i2c1>;
>>
>>                  status =3D "okay";
>>
>>
>>                  sgtl5000: sgtl5000@0a {
>>
>>                                 #sound-dai-cells =3D <0>;
>>
>>                                 compatible =3D "fsl,sgtl5000";
>>
>>                                 reg =3D <0x0a>;
>>
>>                                 clocks =3D <&mclk>;
>>
>>                                 micbias-resistor-k-ohms =3D <2>;
>>
>>                                 micbias-voltage-m-volts =3D <2250>;
>>
>>                                 VDDA-supply =3D <&reg_2p8v>;
>>
>>                                  VDDIO-supply =3D <&reg_2p8v>;
>>
>>                  };
>>
>> };
>>
>>
>> pinctrl_ssi2: ssi2grp {
>>
>>                                 fsl,pins =3D <
>>
>> MX27_PAD_SSI2_FS__SSI2_FS 0x0
>>
>>   MX27_PAD_SSI2_RXDAT__SSI2_RXDAT 0x0
>>
>>   MX27_PAD_SSI2_TXDAT__SSI2_TXDAT 0x0
>>
>> MX27_PAD_SSI2_CLK__SSI2_CLK
>> 0x0
>>
>>                                                 >;
>>
>>                  };
>>
>>
>> And the modules I have loaded before running < speaker test > :
>>
>>
>> # modprobe snd-soc-sgtl5000
>>
>> [   23.274351] sgtl5000 0-000a: sgtl5000 revision 0x11
>>
>> # modprobe snd-soc-simple-card
>>
>> # modprobe snd-soc-fsl-ssi
>>
>> [   79.752288] sgtl5000 0-000a: Using internal LDO instead of VDDD
>>
>> # [   79.853711] asoc-simple-card sound: sgtl5000 <-> 10010000.ssi =

>> mapping
>> ok
>>
>> # modprobe snd-soc-imx-audmux
>>
>>
>> Does anybody know what is the mistake?
>>
>>
>> Thank you for your help.
>>
>>
>> Best regards.
>>
>> Alexandre Schnegg
>>
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
