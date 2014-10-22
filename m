From: Jonathan Bennett <jbscience87@gmail.com>
Subject: Re: Help with wm8731 support for the Utilite (imx6q)
Date: Wed, 22 Oct 2014 08:32:24 -0500
Message-ID: <CAB-pspcoyzQNWhGf_1ex86f2E9spotPGVJzDR0i2=98eMXfxiw@mail.gmail.com>
References: <CAB-pspc5KZ0sTB-7uxjBq+PEFxFdAPO5NAXof_+uwQBJ_JCejg@mail.gmail.com>
 <CAOMZO5C-EG+beiK1M10vX0Xhg4avYLExxG7MZOQq8gM6gRnANw@mail.gmail.com>
 <CAB-pspcNOuW=JN9_avEvyPFUvTfs99PB=ah43YdqMC65mZ8psQ@mail.gmail.com>
 <CAB-pspei1a3TbuFGBT-kupEWU5UY10kQoTtiV895WTi-j+-dzQ@mail.gmail.com>
 <CAOMZO5AVr0xJjf9JjYNuXG-jJC3ft84+fO-5ToSieP9NFP=-+g@mail.gmail.com>
 <CAOMZO5CU+Y8cGJsn4O1ccFZUSjLM1iH3QN2fAv4UyaLMk5yAEg@mail.gmail.com>
 <CAB-pspdvzFX-KjYSC3z3xoDMPvq4g3iFhBG76Y=DGy=YBf5dow@mail.gmail.com>
 <54464C32.8020100@compulab.co.il>
 <CAB-pspcaMh9DL8bND1kSmphZfMYNOvPS_CYZ8UYZ2EZuVjjksg@mail.gmail.com>
 <CAOMZO5A=RSodq=JmjrjHTJSg9QaEx42uu7vAbON=Jk5-Gmiv9Q@mail.gmail.com>
 <CAB-pspcmxQAzR=jX1_fp06UUgNbC_LXFDN4g6RnOn6vTTvJjTw@mail.gmail.com>
 <CAB-pspcZ8bhLMPDS2NbDOEugfzO+TZfOnA_h05pvkU5ZPv6qVQ@mail.gmail.com>
 <544764F4.8070904@compulab.co.il>
 <CAB-pspeg-sP4Ebk+SF8WAxOJwobEk_rgeYnPr=thK2j7O638QA@mail.gmail.com>
 <CAOMZO5A_K9MV+Y5cBWcoLDOCnBH9VX7tkOmBTQh43UdqAtLzGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f178.google.com (mail-ie0-f178.google.com
 [209.85.223.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D15D265192
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 15:32:26 +0200 (CEST)
Received: by mail-ie0-f178.google.com with SMTP id rl12so3333953iec.23
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 06:32:24 -0700 (PDT)
In-Reply-To: <CAOMZO5A_K9MV+Y5cBWcoLDOCnBH9VX7tkOmBTQh43UdqAtLzGA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Aaron Kling <webgeek1234@gmail.com>, Igor Grinberg <grinberg@compulab.co.il>, Valentin Raevsky <valentin@compulab.co.il>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 22, 2014 at 7:17 AM, Fabio Estevam <festevam@gmail.com> wrote:

> Hi Jonathan,
>
> On Wed, Oct 22, 2014 at 10:13 AM, Jonathan Bennett
> <jbscience87@gmail.com> wrote:
>
> >  BRILLIANT!!!
> > We've got sound. Thank you for the answer.
>
> Good job :-)
>
> > Questions:
> > First, what is the best way to set that to on by default? I know "alsactl
> > store wm8731audio" Makes it survive reboots. On a fresh install, though,
> > that should probably default to on.
> >
> > Second: I would love to see support for this get mainlined. Should I go
> back
> > and try to get simple-audio-card working, or stick with the compulab glue
> > driver?
>
> Yes, please try implementing simple-audio-card support.
>
Applying what I've learned back to the simple-audio-card, I can get a
muffled pop in the headphones, like something is powering up. That's about
it. When playing to the card, things think they play fine, but no real
audio. I've checked volume levels, and also used Valentin's hint.

Sound bits from dts:

       sound {
                compatible = "simple-audio-card";
                simple-audio-card,model = "wm8731-audio";
                simple-audio-card,format = "i2s";
                simple-audio-card,audio-routing =
                        "Line Out", "LOUT",
                        "Line Out", "ROUT",
                        "LLINEIN","Line In",
                        "RLINEIN","Line In";
                simple-audio-card,cpu {
                        sound-dai = <&ssi2>;
                        bitclock-master;
                        frame-master;
                };
                simple-audio-card,codec {
                        sound-dai = <&codec>;
                };
        };

/* i2c3 */
&i2c3 {
   pinctrl-names = "default";
   pinctrl-0 = <&pinctrl_i2c3>;
   status = "okay";
   eeprom@50 {
      compatible = "at24,24c02";
      reg = <0x50>;
      pagesize = <16>;
   };

   codec: wm8731@1a {
      #sound-dai-cells = <0>;
      compatible = "wlf,wm8731";
      reg = <0x1a>;
      AVDD-supply = <&reg_3p3v>;
      HPVDD-supply = <&reg_3p3v>;
      DCVDD-supply = <&reg_3p3v>;
      DBVDD-supply = <&reg_3p3v>;
   };
};

&ssi2 {
        status = "okay";
        #sound-dai-cells = <0>;
};


&audmux {
        status = "okay";
        ssi2 {
                fsl,audmux-port = <1>;
                fsl,port-config = <
                        (IMX_AUDMUX_V2_PTCR_SYN |
                        IMX_AUDMUX_V2_PTCR_TFSDIR |
                        IMX_AUDMUX_V2_PTCR_TFSEL(3) |
                        IMX_AUDMUX_V2_PTCR_RCLKDIR |
                        IMX_AUDMUX_V2_PTCR_RCSEL(3 | 0x8) |
                        IMX_AUDMUX_V2_PTCR_TCLKDIR |
                        IMX_AUDMUX_V2_PTCR_TCSEL(3))
                        IMX_AUDMUX_V2_PDCR_RXDSEL(3)
                >;
        };
        pins4 {
                fsl,audmux-port = <3>;
                fsl,port-config = <
                        (IMX_AUDMUX_V2_PTCR_SYN |
                        IMX_AUDMUX_V2_PTCR_RCLKDIR |
                        IMX_AUDMUX_V2_PTCR_RCSEL(1 | 0x8) |
                        IMX_AUDMUX_V2_PTCR_TCLKDIR |
                        IMX_AUDMUX_V2_PTCR_TCSEL(1))
                        IMX_AUDMUX_V2_PDCR_RXDSEL(1)
                >;
        };

};
