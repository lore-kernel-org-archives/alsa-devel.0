From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: <alsa-dev> RFC for OMAP4 audio driver
Date: Wed, 2 Sep 2009 13:01:21 +0100
Message-ID: <20090902120120.GB4012@sirena.org.uk>
References: <baee637d0909011927m5df3bd58uf7cabfc474f50274@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 16CC1245B0
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Sep 2009 14:01:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <baee637d0909011927m5df3bd58uf7cabfc474f50274@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: hari n <hnagalla@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 01, 2009 at 09:27:30PM -0500, hari n wrote:

> Proposal
> --------
> On OMAP4, audio codec functionality is spread between ABE of OMAP4
> and the companion analog audio chip. The interface between the ABE
> and Phoenix audio chip is proprietary McPDM interface. The proposal
> is to combine both ABE and Phoenix into a codec driver. OMAP4 ABE

Combining the two seems like it's asking for trouble further along the
line.  While it's likely that a lot of board designs will use the
reference design combination of devices there will inevitably be some
systems that want to do something different for whatever reason.  If
that affects the connections between the two parts of the system then
there will be problems for a unified driver.

Otherwise the rest of your design looks good.

> sound/soc/codecs/abe-twl6030.c: This is the codec driver interface
>    file for OMAP4 audio. It defines the codec DAIs for the HIFI,
>    voice and Vibra subdevices. Handles the configuration of Phoenix
>    companion chip using i2c control interface. Handles the
>    initialization and configuration of ABE. All codec related widget
>    controls are also handled in this file. Both, digital (ABE) and
>    analog (twl6030) widgets will be contained in this same driver.

Having the ABE as a CODEC does seem like a sensible approach - indeed,
there are a number of audio hub CODECs on the market with a very similar
feature set to the ABE.

> Questions
> ---------
> How to handle routing of digital audio from ABE to external devices
> like Bluetooth/FM connectivity devices which are usually connected
> using McBSP interfaces?. In these scenarios, we need another DAI
> between the ABE (platform codec) and an external codec.

> ABE(platform Codec (Digital) -----> Phoenix audio codec
>                                |
>                                |
>                    +--> BT/FM codec

This is the sort of issue I'm talking about above which is helped by
explicitly representing all the DAIs in the system.  With the DAIs
visible it should just become a case of hooking up the links between the
devices in the usual ASoC fashion.
