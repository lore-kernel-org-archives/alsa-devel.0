From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v1 1/2] ASoC: SOF: Add Comet Lake PCI ID
Date: Tue, 7 May 2019 16:06:46 -0500
Message-ID: <73ebe767-0371-00aa-bb0b-9cb2ba708a42@linux.intel.com>
References: <20190506225321.74100-1-evgreen@chromium.org>
 <20190506225321.74100-2-evgreen@chromium.org>
 <74e8cfcd-b99f-7f66-48ce-44d60eb2bbca@linux.intel.com>
 <64FD1F8348A3A14CA3CB4D4C9EB1D15F30A7C756@BGSMSX107.gar.corp.intel.com>
 <5c42b741-5e5c-ce00-8321-59df1df115f1@linux.intel.com>
 <CAE=gft5TeW1h3GAT9Gkwdf8eE_p5aoywveE2ddXgYQ+fET8Sdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE=gft5TeW1h3GAT9Gkwdf8eE_p5aoywveE2ddXgYQ+fET8Sdg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Evan Green <evgreen@chromium.org>
Cc: Rajat Jain <rajatja@chromium.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Ben Zhang <benzh@chromium.org>, Mark Brown <broonie@kernel.org>, "M R, Sathya Prakash" <sathya.prakash.m.r@intel.com>, "M, Naveen" <naveen.m@intel.com>
List-Id: alsa-devel@alsa-project.org


>> What we are missing are the PCI IDs for CML PCH-LP (0x02C8) and CML
>> PCH-H (0x06C8).
>>
>> Can we respin this patchset to add support for those last two instead of
>> just the -LP case?
> 
> Sure. So just to clarify, you want the entry for 0x02c8, and you want
> an additional entry for 0x06c8 under the same config. Will do.

I'd like both entries but with different Kconfigs (e.g. CometLake-LP and 
CometLake-H). We have one PCI ID per Kconfig so far.

>>
>> I'll send a patch to add those IDs for the HDaudio legacy driver for
>> consistency.
> 
> Actually I've got that change ready to go too, I'm happy to send that out.

I guess I beat you to it.
Thanks for reporting all this.
-Pierre
