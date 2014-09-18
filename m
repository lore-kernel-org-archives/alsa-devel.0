From: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>
Subject: Re:
	=?utf-8?q?No_sound_captured_with_SGTL5000_on_i=2EMX6?=
	=?utf-8?q?_in_I=C2=B2S_master_mode?=
Date: Thu, 18 Sep 2014 18:09:50 +0200
Message-ID: <CAL8zT=igU9F=MZ0dQSgqgkq-T=PV-jbXAZeYAaMDs1ot_1MjCg@mail.gmail.com>
References: <CAL8zT=hSCpBZpqVGQ5uBdXJe25hqoNkmiPh_Ge3RCrGALkaoZg@mail.gmail.com>
 <CAOMZO5CReW7-8L7zx=z1TshwJSzcfGThCjws7fTfbZJKCnCZLg@mail.gmail.com>
 <CAOf5uwmrsuXSCpUXhf3pTCRt0=4pprwfiP5MDDukE=WRzOk2WA@mail.gmail.com>
 <CAL8zT=jw4QQSzoq_8d0j-SXYEWzsNgz279dhDzjTHHr-jutP=Q@mail.gmail.com>
 <CAOf5uw=R0oHGDyFhueepoftfDb_d4vccO_751apBLg7S3gzGjg@mail.gmail.com>
 <CAL8zT=gcYkCRE9TU+2w+qBDtM+gYKqr-0KRDy7UxQXJ0P3LutQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f177.google.com (mail-ig0-f177.google.com
 [209.85.213.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A4AF26549B
 for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2014 18:10:08 +0200 (CEST)
Received: by mail-ig0-f177.google.com with SMTP id uq10so1478104igb.4
 for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2014 09:10:06 -0700 (PDT)
In-Reply-To: <CAL8zT=gcYkCRE9TU+2w+qBDtM+gYKqr-0KRDy7UxQXJ0P3LutQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Shengjiu Wang <shengjiu.wang@freescale.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawn.guo@freescale.com>
List-Id: alsa-devel@alsa-project.org

<snip>

>> I forget that you see the clock out. BTW too late. What I'm trying to
>> said is that even if pins are configured and routed they can be routed
>> in the wrong direction. Right now you try to generate both clock from
>> the cpu and you can see them but receive path can be configured in
>> syncronous mode or it can work take the clock from another pin. What
>> is your configuration?
>
> The master clock is provided by the CPU but I just found out
> something. I have a FPGA between sgtl5000 and i.MX6. It is here in
> order to route signals. And when imx-audmux is probed, it does not
> find the clock, because the FPGA is not configured yet.
> And as this driver is not returning EPROBE_DEFER, it does not try a
> little bit later (when the clock will really be here).
> I don't know if this is the explanation of my issue, but at least this
> is an interesting catch.
> I will try and get you informed.

Well, audmux is not getting clock, this is normal I think, the clock I
was mentionning is the MCLK of SGTL5000 and this one is linked to
FPGA, but found after all.
I now had a further look into sound/soc/fsl/fsl_ssi.c and I see this :

    sprop = of_get_property(np, "fsl,mode", NULL);
    if (sprop) {
        if (!strcmp(sprop, "ac97-slave"))
            ssi_private->dai_fmt = SND_SOC_DAIFMT_AC97;
        else if (!strcmp(sprop, "i2s-slave"))
            ssi_private->dai_fmt = SND_SOC_DAIFMT_I2S |
                SND_SOC_DAIFMT_CBM_CFM;
    }

I may have missed something, but it seems that i2s-master is not
parsed, and does not set dai_fmt ?
Or maybe is it done later ?
I tried :
                else if (!strcmp(sprop, "i2s-slave"))
                        ssi_private->dai_fmt = SND_SOC_DAIFMT_I2S |
                                SND_SOC_DAIFMT_CBM_CFM;
+               else if (!strcmp(sprop, "i2s-master"))
+                       ssi_private->dai_fmt = SND_SOC_DAIFMT_I2S |
+                               SND_SOC_DAIFMT_CBM_CFS;
        }

But this is not better :


arecord -v -V stereo -f cd -D hw:0,0 somefile.wav
Recording WAVE 'somefile.wav' : Signed 16 bit Little Endian, Rate
44100 Hz, Stereo
Hardware PCM card 0 'imx6q-vbx3-sgtl5000' device 0 subdevice 0
Its setup is:
  stream       : CAPTURE
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 16
  buffer_size  : 16384
  period_size  : 4096
  period_time  : 92879
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 4096
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 16384
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
  appl_ptr     : 0
  hw_ptr       : 0
arecord: pcm_read:2031: read error: Input/output error

JM
