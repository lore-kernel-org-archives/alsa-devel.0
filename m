From: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>
Subject: Re:
	=?utf-8?q?No_sound_captured_with_SGTL5000_on_i=2EMX6?=
	=?utf-8?q?_in_I=C2=B2S_master_mode?=
Date: Thu, 9 Oct 2014 17:14:24 +0200
Message-ID: <CAL8zT=j=hXA8oCFGfhW=NwuFX6w70_GT+r5qHMk+tCLX7YOocg@mail.gmail.com>
References: <20140918170524.GA6080@Asurada>
 <CAOMZO5AqtNm3kwndUYszAuMfJ4CMOz4pwZRmE+04cEDtz98agg@mail.gmail.com>
 <20140918174935.GB6432@Asurada>
 <CAOMZO5AXN4p01=oGCydHUm6sPdt5NRNXO+4EOKQ1T7ZKUwVfMw@mail.gmail.com>
 <20140918180742.GC6432@Asurada>
 <CAOMZO5AvWecqimJkZcwysvsmPiq8Fa2Hm_XppCH3E1+vyjVzFQ@mail.gmail.com>
 <20140918183910.GF6432@Asurada>
 <CAOMZO5BJbzizB4r8vvtJEBzv+DhsyRmYMUoQL2D-dQhBorGkzA@mail.gmail.com>
 <20140918235045.GA4148@Asurada>
 <CAL8zT=hdT0otjqkQeBmfQgNsfdoapCv3NnHMwNxfxydu1+44Ww@mail.gmail.com>
 <20140919075228.GA4376@Asurada>
 <CAL8zT=jWQ4ZTGpohWHGTfbxgj547ukcZEUg7XdQsWzwq1=JiVA@mail.gmail.com>
 <CAL8zT=gELK8+LOgVn6qXnaTm=Vcx=zn8OxfQBh_9m28NQtR2pA@mail.gmail.com>
 <CAL8zT=gEMwbJq=3Tf6FAg2_fyAK4Q07-hVn5eYZKFSBfC-8iBQ@mail.gmail.com>
 <CAOMZO5CWZdyLHzc=EpQ3LYE3ixiRXbp-WTCT=2JKgQK0sEc_gw@mail.gmail.com>
 <CAL8zT=jUbck2OTpskna3rjgo-NGWw6VX2cuDHP9bDunbS_qGBg@mail.gmail.com>
 <CAOMZO5CBPcQ1O-o2sMxcSzudJrju+aevheJbWw2m_QH7UyHzXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f42.google.com (mail-oi0-f42.google.com
 [209.85.218.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 644C626007E
 for <alsa-devel@alsa-project.org>; Thu,  9 Oct 2014 17:14:41 +0200 (CEST)
Received: by mail-oi0-f42.google.com with SMTP id a141so3394360oig.1
 for <alsa-devel@alsa-project.org>; Thu, 09 Oct 2014 08:14:40 -0700 (PDT)
In-Reply-To: <CAOMZO5CBPcQ1O-o2sMxcSzudJrju+aevheJbWw2m_QH7UyHzXw@mail.gmail.com>
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
Cc: Shengjiu Wang <shengjiu.wang@freescale.com>, Lars-Peter Clausen <lars@metafoo.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, Michael Trimarchi <michael@amarulasolutions.com>, Shawn Guo <shawn.guo@freescale.com>
List-Id: alsa-devel@alsa-project.org

2014-10-09 17:06 GMT+02:00 Fabio Estevam <festevam@gmail.com>:
> On Thu, Oct 9, 2014 at 11:26 AM, Jean-Michel Hautbois
> <jean-michel.hautbois@vodalys.com> wrote:
>> 2014-10-09 16:18 GMT+02:00 Fabio Estevam <festevam@gmail.com>:
>>> On Thu, Oct 9, 2014 at 11:02 AM, Jean-Michel Hautbois
>>> <jean-michel.hautbois@vodalys.com> wrote:
>>>
>>>> Here is an extract of the DT :
>>>> / {
>>>>     sound {
>>>>         compatible = "fsl,imx6q-vbx3-sgtl5000",
>>>>                  "fsl,imx-audio-sgtl5000";
>>>
>>> I am confused here: you say you use the simple-card, but your DTS
>>> still shows imx-audio-sgtl5000.
>>
>> I mentioned fsl-asoc-card, not simple card ?
>
> Yes, right, but for using fsl-asoc-card you should reference
> 'audio-cpu' instead of 'ssi-controller'.
>
> That's what Documentation/devicetree/bindings/sound/fsl-asoc-card.txt mentions.

Ouch, nice catch :).

Here is what I understand, in my cas, sgtl5000 has its clock routed
through a FPGA.
If the FPGA has not yet be probed, then, the module fails in loading :
[    4.985762] sgtl5000: probe of 1-000a failed with error -5

This is why after removing it and probing it again manually, it works.

This module should be able to defer probing too, is it going to be
done by someone or do I try to send some patch for this ?

BTW, I don't have sound on the microphone input, and I think there is
no way to select micbias voltage level neither from the source code
nor the DT ?
It could be interetsing to have something like sgtl5000-micbias-vg
which would give control on the voltage bias parameter ?
And maybe also something for bias resistor too ?

I can try to patch something.
Thanks,
JM
