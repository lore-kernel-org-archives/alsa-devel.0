From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH v2 3/3] ASoC: da7213: Add bindings
 documentation for codec driver
Date: Thu, 8 Oct 2015 16:31:26 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337D4609B73@SW-EX-MBX01.diasemi.com>
References: <cover.1444223905.git.Adam.Thomson.Opensource@diasemi.com>
 <bfc7c5e61d8c398bc4cfa56a7908032dc3bdf82f.1444223905.git.Adam.Thomson.Opensource@diasemi.com>
 <CAL_JsqL0R0jVSm6w0V=F5c1Odw3RKATjcq96QaUcA99JJmD2Xw@mail.gmail.com>
 <2E89032DDAA8B9408CB92943514A0337D4609A3A@SW-EX-MBX01.diasemi.com>
 <CAL_JsqKnDVTONB4pUWiKV8Nhz=wWyQytkGjtak5BdT1K+RrOPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta14.messagelabs.com (mail1.bemta14.messagelabs.com
 [193.109.254.112])
 by alsa0.perex.cz (Postfix) with ESMTP id DB8F0264F03
 for <alsa-devel@alsa-project.org>; Thu,  8 Oct 2015 18:31:41 +0200 (CEST)
In-Reply-To: <CAL_JsqKnDVTONB4pUWiKV8Nhz=wWyQytkGjtak5BdT1K+RrOPg@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh@kernel.org>, "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Support Opensource <Support.Opensource@diasemi.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Kumar Gala <galak@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On October 08, 2015 14:16, Rob Herring wrote:

> >> > +- dlg,micbias1-lvl : Voltage (mV) for Mic Bias 1
> >> > +       [<1600>, <2200>, <2500>, <3000>]
> >> > +- dlg,micbias2-lvl : Voltage (mV) for Mic Bias 2
> >> > +       [<1600>, <2200>, <2500>, <3000>]
> >>
> >> Please append the units (-microvolt).
> >
> > Given that a user needs to read the bindings document to understand what is
> > available, and what they're for, this seems a little unnecessary.
> 
> You may think so, but it is standard practice.
 
I can find a number of situations in the kernel, where this just isn't followed,
for device specific bindings. What percentage have to follow this for it to be
'standard'? Is this documented somewhere so it's clear for those writing
drivers which need to use DT bindings? I had a quick look and couldn't find
anything on this.

> >>
> >> > +- dlg,dmic-clkrate : DMIC clock frequency (MHz).
> >> > +       [<1500000>, <3000000>]
> >>
> >> So 1.5GHz or 3GHz?
> >>
> >> Add units (-hz).
> >
> > Agreed, the description of MHz is misleading so will update to Hz. Thanks.
> > Again though, I don't see what the suffix gives you, and would prefer to leave
> > the binding as is.
> 
> It tells someone reading the dts what the units are without having to
> find the documentation and helps prevent people using properties with
> differing units.

For a lot of device specific bindings, you will need to read the associated
documentation, and possibly the datasheet, to understand what it's for, and what
values are valid. I don't see this suffix really saving you any time. For
standard frameworks ok, but here it seems overkill.
