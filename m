From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: Configuring codec PCM port question
Date: Fri, 28 Jan 2011 13:19:02 +0000
Message-ID: <20110128131902.GE10350@opensource.wolfsonmicro.com>
References: <12D0C12AF19E15409D57F22566E88EF50937515E81@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 01CCA2456C
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2011 14:18:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <12D0C12AF19E15409D57F22566E88EF50937515E81@bgsmsx501.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Babu, Ramesh" <ramesh.babu@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 28, 2011 at 06:30:59PM +0530, Babu, Ramesh wrote:

> I am thinking of following two options to configure PCM1 port:

> 1. AlSA Mixer control:  Create mixer control and provide options like VOICE_HS,
> 	VOICE_IHF, VOICE_EP and VOICE_DISABLE. Application will use one of the option to
> 	Configure the PCM1 port.

> 2. IOCTL : Application invokes IOCTL in hardware specific driver code and then it enables
> 	PCM1 port (cross-path DAPM ?) 

> Which is the best way to implement it?
> Are there any other existing way to implement it?

The current mainline solution to this is to do something like the
OpenMoko GTA02 or Samsung Aquilla and Goni do and represent the modem as
a dummy CPU DAI then use application code like this:

  http://opensource.wolfsonmicro.com/~gg/bluetooth-pcm/bluetooth_pcm.c

to start the audio - ie, run through everything except DMA.

There's some updates that I'd expect to see soon which will allow the
configuration for the hw_params() for the link to be baked into the
machine driver (I'll be doing that in the next couple of weeks) and
which will allow DAPM to propagate power over links between CODECs (Liam
has some work for that in his git, though he's still working on tidying
it up for mainline) which should make life much easier but it may be
easier for you to submit something now and then update later as the
support for this scenario improves.
