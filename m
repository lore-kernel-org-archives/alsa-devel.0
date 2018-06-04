From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH] ASoC: pcm512x: enable set_sysclk
 callback
Date: Mon, 4 Jun 2018 13:14:10 -0500
Message-ID: <f2e83538-31a1-60af-44f4-6e9f1e59c0b9@linux.intel.com>
References: <20180601212643.20101-1-pierre-louis.bossart@linux.intel.com>
 <20180604104029.GA7536@sirena.org.uk>
 <a933ad0d-70a8-b046-a0a0-3bdf5fb07d2e@linux.intel.com>
 <20180604162757.GH7536@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 782F4267892
 for <alsa-devel@alsa-project.org>; Mon,  4 Jun 2018 20:14:13 +0200 (CEST)
In-Reply-To: <20180604162757.GH7536@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org



On 06/04/2018 11:27 AM, Mark Brown wrote:
> On Mon, Jun 04, 2018 at 08:48:40AM -0500, Pierre-Louis Bossart wrote:
>
>> What I find odd is the selection between the two static clocks. I have
>> nothing against the clock API, I just find that the Pi solution isn't
>> terribly elegant. The machine driver selects the 44.1 or 48kHz oscillator by
>> configuring GPIO using registers exposed by the codec driver, the clock API
>> implementation does nothing related to hardware, so we have three entities
>> involved to flip 2 GPIOs.
> That just sounds like a not great implementation decision in that
> platform code rather than a fundamental problem.
>
>> And even if I use this solution, I still don't know how to tell the codec
>> driver which sclk to use in an ACPI environment (this is to enable HiFiberry
>> cards on Up/Up^2). At the moment the code does
>> pcm512x->sclk = devm_clk_get(dev, NULL);
>> and I don't have a moral equivalent for ACPI. I can add information for the
>> codec driver to get from the DSDT, I'd need however a agreed solution based
>> on _DSD or some property, and the thread with AMD on their 'mclk_name' topic
>> for DA7219 didn't go anywhere, did it?
> For systems out in the wild now you're going to need to have a bit of
> platform glue code anyway so I'm not sure there's that big an overhead
> (other than the data tables, but that seems idiomatic for ACPI).  It's
> a bit of work to get something set up but I'd not expect it to be that
> bad, but perhaps I'm missing something there.
>
>> Bottom line there is an 'easy' solution for this specific case and a more
>> complicated one but potentially more generic based on the clock API - hence
>> the RFC.
> As far as I can see the two aren't that far off - creating a fixed
> frequency clock based on DMI data shouldn't be that much harder than
> doing a set_sysclk().
Not sure how DMI could be used for devices with connectors? The 
information should come from the additional ASL code that we typically 
add to SSDT or initrd, e.g. [1]. This ASL code can add additional 
information clock as needed, e.g. with _DSD properties, but the link 
with the clock API isn't there atm.

[1] https://github.com/plbossart/acpi-scripts/blob/master/Up2/PCM512X.asl
