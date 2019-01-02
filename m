From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v4 08/11] ASoC: Intel: atom: Make PCI
 dependency explicit
Date: Wed, 2 Jan 2019 10:34:54 -0600
Message-ID: <30fa73b0-33e0-29ed-3d80-f2365b7cd88c@linux.intel.com>
References: <20181230195612.6657-1-okaya@kernel.org>
 <20181230195612.6657-9-okaya@kernel.org>
 <20181231174654.GH1846@sirena.org.uk>
 <CAK9iUCPHu0FV9LqMOKixKi7Cg_DC_F04OeXh50YSHOpgkGKejQ@mail.gmail.com>
 <20181231193017.GN1846@sirena.org.uk>
 <CAK9iUCNf9JqwvtL4O5KVHP9ZN3y66wZOTjOsGcXFc-T_g6xtEQ@mail.gmail.com>
 <d288e6cf-158f-e832-6096-17d3faf9e3e9@linux.intel.com>
 <CAK9iUCNhPg21ZFxkbqquTQ5aRRh7ojsSiFP4_RJ2_MsD4t=cYw@mail.gmail.com>
 <765ab3a1-f1f1-3b29-aabb-0f3328abd631@linux.intel.com>
 <CAK9iUCOJxws-gAgHT4RWxHMZKUHq-p4X9USpEO-6N_oZPht1GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK9iUCOJxws-gAgHT4RWxHMZKUHq-p4X9USpEO-6N_oZPht1GQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <Okaya@kernel.org>
Cc: "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


> Please check out this tag next-20181224 and apply the patches afterwards.
Thanks, will do. I think this patchset will uncover additional 
inconsistencies, e.g. for legacy Haswell/Broadwell/Baytrail the machine 
drivers depend on X86_INTEL_LPSS, which depends in turn on PCI, but the 
platform drivers only depend on ACPI, so there is a risk of creating a 
config that makes no sense (or should only be used for COMPILE_TEST)
