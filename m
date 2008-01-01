From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Tue, 1 Jan 2008 12:42:42 -0500
Message-ID: <9e4733910801010942y47e4cdbfge5e0d3e44ab96760@mail.gmail.com>
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by alsa0.perex.cz (Postfix) with ESMTP id ADFD524502
	for <alsa-devel@alsa-project.org>; Tue,  1 Jan 2008 18:42:43 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so8045713wag.8
	for <alsa-devel@alsa-project.org>; Tue, 01 Jan 2008 09:42:42 -0800 (PST)
In-Reply-To: <9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 1/1/08, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 12/19/07, Timur Tabi <timur@freescale.com> wrote:
> > +               ssi@16000 {
> > +                       compatible = "fsl,ssi";
> > +                       cell-index = <0>;
> > +                       reg = <16000 100>;
> > +                       interrupt-parent = <&mpic>;
> > +                       interrupts = <3e 2>;
> > +                       fsl,mode = "i2s-slave";
> > +                       codec {
> > +                               compatible = "cirrus,cs4270";
> > +                               /* MCLK source is a stand-alone oscillator */
> > +                               bus-frequency = <bb8000>;
> > +                       };
> > +               };
>
> Does this need to be bus-frequency? It's always called MCLK in all of
> the literature.
>
> In my case the MCLK comes from a chip on the i2c bus that is
> programmable How would that be encoded?.

Looking at the cs4270 codec driver it is controlled by i2c (supports
SPI too).  What happened to the conversation about putting codecs on
the controlling bus and then linking them to the data bus?

If that's the case the cs4270 should be in the i2c bus node (missing
currently) and then a link from the SSI bus would point to it.

cs4270 is still an old style i2c driver which is going to get
deprecated. It takes about thirty minutes to convert it to new style.
If was new style it could pick up its i2c address from the device tree
instead of searching for it.

-- 
Jon Smirl
jonsmirl@gmail.com
