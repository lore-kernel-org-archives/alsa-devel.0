From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH 1/5] ASoC: da7213: add ACPI support
Date: Mon, 13 Mar 2017 22:43:31 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A03370142A9AE19@SW-EX-MBX01.diasemi.com>
References: <1489105142-25878-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1489105142-25878-2-git-send-email-pierre-louis.bossart@linux.intel.com>
 <2E89032DDAA8B9408CB92943514A03370142A9AD76@SW-EX-MBX01.diasemi.com>
 <5c0818d5-13c3-10e5-71da-7e7ec6ab3d3d@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com
 [195.245.230.176])
 by alsa0.perex.cz (Postfix) with ESMTP id CB5CA266D01
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 23:43:34 +0100 (CET)
In-Reply-To: <5c0818d5-13c3-10e5-71da-7e7ec6ab3d3d@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "vinod.koul@intel.com" <vinod.koul@intel.com>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 13 March 2017 19:08, Pierre-Louis Bossart wrote:

> > As a general comment, it would be nice if the current of_property_read_* calls
> > could be converted to device_property_read_* calls instead, so both ACPI and DT
> > initialisation of bindings is supported.
> 
> It's something we can test with the MinnowBoard by just adding _DSD
> properties to the ACPI definitions. But I am not too hot on doing this
> myself since I have no ARM platform to test for non-regressions.
> 

Ok, will follow up with a patch for this, so both ACPI and DT initialisations
are supported. I can certainly verify the DT part still works on my side.
