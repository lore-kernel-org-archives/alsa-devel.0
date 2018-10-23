From: "Tc, Jenny" <jenny.tc@intel.com>
Subject: Re: [PATCH 0/2] Introduce dmic mode switch delay
 parameter
Date: Tue, 23 Oct 2018 17:11:57 +0000
Message-ID: <20ADAB092842284E95860F279283C564568C0050@BGSMSX104.gar.corp.intel.com>
References: <1538459851-17066-1-git-send-email-jenny.tc@intel.com>
 <102a22bc-a054-b07d-23c8-95118d69450f@linux.intel.com>
 <108f2ff1-c000-31ba-0a36-e696a912c6e6@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 47E3B267546
 for <alsa-devel@alsa-project.org>; Tue, 23 Oct 2018 19:12:00 +0200 (CEST)
In-Reply-To: <108f2ff1-c000-31ba-0a36-e696a912c6e6@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@kernel.org>, Matthias Kaehlcke <mka@chromium.org>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

> Allowing some timing adjustments for the clock transitions is a good 
> thing. The way it's done is questionable and raises a number of concerns.
>
> First, there was an Intel internal discussion before my extended break 
> on why this 'dmic-codec' is needed on Intel platforms. To the best of 
> my knowledge we don't control the mics with GPIOs, which was the 
> initial purpose of this driver. We have experimental evidence on 
> ApolloLake and GeminiLake that using the soc-dummy/soc-dummy-dai 
> definitions are enough, and it may be a good thing to agree on the 
> direction here. If you want a parameter, you can still use a machine 
> driver DMI-based kernel quirk and/or pass a kernel parameter, the need 
> to extend this dmic-codec is far from obvious to me.

The driver already exposes another parameter (wakeup-delay-ms) using device tree. 
Enabling ACPI device enumeration provides a way to pass existing parameter
and also cover the new parameter(modeswitch_delay_ms) introduced in this patch set.
Isn't it good to adopt ACPI enumeration if the driver has multiple parameters to handle?
 
> Assuming you still want to use this codec, then there are still major 
> concerns about the ACPI directions. As Mark noted it, "DMIC" does not 
> follow any of the guidelines or accepted definitions with an 
> unambiguous vendor and part ID. We know we already have conflicts 
> between Intel-defined ACPI IDs, e.g. for RT298 on multiple platforms, 
> let's be careful here, shall we?

Agree, need to find proper ACPI ID for the device.
 
>
> And I am coming to my last point. The Skylake driver already contains 
> code to create the dmic devices by hand (see below the git grep 
> results). So I wonder what happens if you use both ACPI-based 
> enumeration AND manually create the dmic device - I view these 
> solutions as mutually incompatible. Either you have not tested against 
> the upstream code or something is missing from your patchset. What am 
> I missing?

Skl driver already registers a DMIC (dmic-codec) device and with ACPI enumeration
one more device (DMIC:00) gets registered. The snd_soc_dai_link  structure populated
in the machine driver decides which codec device to be used in the capture path and 
there by handles the compatibility issue you pointed out. 
 

>I forgot to add another open on ACPI support: what would be the scope of the "DMIC" device? 
>With ACPI we typically have a parent-child relationship, e.g. we put audio codec below the relevant
>I2C/SPI controller in the DSDT definitions. In the absence of a DMIC bus, you need to be careful how
>the DMIC device is added in the DSDT - it'd likely need to be below the scope of the HDaudio controller.

In DSDT, the device is added under the Intel HDA (1f.3 for SKL/KBL) parent device.

-Jenny
