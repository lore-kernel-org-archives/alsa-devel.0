From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: Re: <alsa-dev> RFC for OMAP4 audio driver
Date: Wed, 2 Sep 2009 20:55:16 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90E80FDEDAA@dlee04.ent.ti.com>
References: <baee637d0909011927m5df3bd58uf7cabfc474f50274@mail.gmail.com>
	<20090902120120.GB4012@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id B3415244B7
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Sep 2009 03:55:25 +0200 (CEST)
In-Reply-To: <20090902120120.GB4012@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, hari n <hnagalla@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> > Proposal
> > --------
> > On OMAP4, audio codec functionality is spread between ABE 
> of OMAP4 and 
> > the companion analog audio chip. The interface between the ABE and 
> > Phoenix audio chip is proprietary McPDM interface. The 
> proposal is to 
> > combine both ABE and Phoenix into a codec driver. OMAP4 ABE
> 
> Combining the two seems like it's asking for trouble further 
> along the line.  While it's likely that a lot of board 
> designs will use the reference design combination of devices 
> there will inevitably be some systems that want to do 
> something different for whatever reason.  If that affects the 
> connections between the two parts of the system then there 
> will be problems for a unified driver.
> 
> Otherwise the rest of your design looks good.
> 
> > sound/soc/codecs/abe-twl6030.c: This is the codec driver interface
> >    file for OMAP4 audio. It defines the codec DAIs for the HIFI,
> >    voice and Vibra subdevices. Handles the configuration of Phoenix
> >    companion chip using i2c control interface. Handles the
> >    initialization and configuration of ABE. All codec related widget
> >    controls are also handled in this file. Both, digital (ABE) and
> >    analog (twl6030) widgets will be contained in this same driver.
> 
> Having the ABE as a CODEC does seem like a sensible approach 
> - indeed, there are a number of audio hub CODECs on the 
> market with a very similar feature set to the ABE.

Mark,

I'm not familiar with the concept of an audio hub, but is it
something like a codec that can have 'slave' codecs connected to
it (like in cascade fashion)?
Do we have any audio hub CODEC already in SoC to use as a
reference?

> > Questions
> > ---------
> > How to handle routing of digital audio from ABE to external devices 
> > like Bluetooth/FM connectivity devices which are usually connected 
> > using McBSP interfaces?. In these scenarios, we need another DAI 
> > between the ABE (platform codec) and an external codec.
> 
> > ABE(platform Codec (Digital) -----> Phoenix audio codec
> >                                |
> >                                |
> >                    +--> BT/FM codec
> 
> This is the sort of issue I'm talking about above which is 
> helped by explicitly representing all the DAIs in the system. 
>  With the DAIs visible it should just become a case of 
> hooking up the links between the devices in the usual ASoC fashion.

If the ABE is considered as a separate CODEC, then it should have
its own DAIs for the connection with the processor, even it the
codec itself resides in the processor. What about the client CODECs?
They will also have their DAIs which should be connected to the
physical outputs of ABE (McPDM, McBSP, ...), and that confuses me.
AFAIK, SoC allows to have multiple CODECs attached to the same
processor, but not a CODEC connected to the output of another CODEC.

-Misa
