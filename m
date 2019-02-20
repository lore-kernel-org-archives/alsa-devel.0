From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [Sound-open-firmware] [PATCH v4 01/14] ASoC: SOF:
 Add Sound Open Firmware driver core
Date: Wed, 20 Feb 2019 08:35:16 -0600
Message-ID: <19843650-4f58-4aa9-7bf3-c1ce4c72d1c9@linux.intel.com>
References: <20190213220734.10471-1-pierre-louis.bossart@linux.intel.com>
 <20190213220734.10471-2-pierre-louis.bossart@linux.intel.com>
 <s5h1s4abu2n.wl-tiwai@suse.de>
 <ecb982bf-5f45-4551-592c-8375d06415e0@linux.intel.com>
 <20190219153836.GD6319@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190219153836.GD6319@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: Daniel Baluta <daniel.baluta@gmail.com>, andriy.shevchenko@intel.com, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, sound-open-firmware@alsa-project.org, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


>>>> +	/* private data - core does not touch */
>>>> +	void *private; /* FIXME: still SOF-specific, needs to less ambiguous */
>>> Then better to name it sof_private?
>> Ah, this is a mistake in the FIXME comment.
>> initially we had a field called "sof" and Mark made the following comment:
> ...
>
>> so we added a FIXME to track this, then later we moved the field and renamed
>> it 'private' so that it can be used by others if needed but didn't remove
>> the FIXME. Will fix this.
> That doesn't really address the issue - there's multiple drivers using
> any given runtime so none of them can safely use a generically named
> private data field.  Conversely putting a field specific to a given
> driver into the core data structures opens the door to everyone wanting
> their custom stuff in the core which is also a problem for different
> reasons.  This would be a lot easier with the DSP represented as a first
> class device in the system...

I see your point and agree the current direction isn't scalable, but I 
am not sure about the definition of 'first class device'.

Did you mean 'component' at the same level as the 'platforms' and 
'codecs', with all the DSP stuff nicely packaged and maintained in a 
self-contained way?

Or a subcomponent that might be part of those platforms and codecs?
