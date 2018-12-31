From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v4 08/11] ASoC: Intel: atom: Make PCI dependency explicit
Date: Mon, 31 Dec 2018 15:42:10 -0600
Message-ID: <765ab3a1-f1f1-3b29-aabb-0f3328abd631@linux.intel.com>
References: <20181230195612.6657-1-okaya@kernel.org>
 <20181230195612.6657-9-okaya@kernel.org>
 <20181231174654.GH1846@sirena.org.uk>
 <CAK9iUCPHu0FV9LqMOKixKi7Cg_DC_F04OeXh50YSHOpgkGKejQ@mail.gmail.com>
 <20181231193017.GN1846@sirena.org.uk>
 <CAK9iUCNf9JqwvtL4O5KVHP9ZN3y66wZOTjOsGcXFc-T_g6xtEQ@mail.gmail.com>
 <d288e6cf-158f-e832-6096-17d3faf9e3e9@linux.intel.com>
 <CAK9iUCNhPg21ZFxkbqquTQ5aRRh7ojsSiFP4_RJ2_MsD4t=cYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK9iUCNhPg21ZFxkbqquTQ5aRRh7ojsSiFP4_RJ2_MsD4t=cYw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <Okaya@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


On 12/31/18 2:35 PM, Sinan Kaya wrote:
> On Mon, Dec 31, 2018 at 11:29 PM Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>>
>> On 12/31/18 1:35 PM, Sinan Kaya wrote:
>>> On Mon, Dec 31, 2018 at 10:30 PM Mark Brown <broonie@kernel.org> wrote:
>>>> On Mon, Dec 31, 2018 at 08:52:52PM +0300, Sinan Kaya wrote:
>>>>> On Mon, Dec 31, 2018 at 8:47 PM Mark Brown <broonie@kernel.org> wrote:
>>>>>> I don't have the cover letter or anything for this series, what's going
>>>>>> on with dependencies?
>>>>> Here is the executive summary:
>>>>> I have a changeset that separates ACPI from PCI on 4.21. CONFIG_ACPI
>>>>> used to select PCI. This is no longer true.
>>>>> You can build an ACPI system without any PCI devices.
>>>> So there's no dependency and I can just apply this?
>>> The plan is to apply this patchset via ACPI tree. Need an Acked-by per patch.
>> Anytime we change the Kconfig settings for audio, we get all kinds of
>> problems with randconfig and 0day/kbuild due to depend/select issues.
>> I'd like to give this a spin first, can you share a link to the entire
>> series? Thanks!
> Sure,
>
> You can find them here
>
> https://lore.kernel.org/patchwork/patch/1028330/
>
> Click related.

Something must be missing, I get compilation errors when PCI is not 
defined? And I see tons of references to pci stuff in drivers/acpi.

drivers/acpi/reboot.c: In function ‘acpi_reboot’:
drivers/acpi/reboot.c:37:10: error: implicit declaration of function 
‘pci_find_bus’; did you mean ‘pci_find_next_bus’? 
[-Werror=implicit-function-declaration]
    bus0 = pci_find_bus(0, 0);
           ^~~~~~~~~~~~
           pci_find_next_bus
drivers/acpi/reboot.c:37:8: warning: assignment makes pointer from 
integer without a cast [-Wint-conversion]
    bus0 = pci_find_bus(0, 0);
         ^
drivers/acpi/reboot.c:45:3: error: implicit declaration of function 
‘pci_bus_write_config_byte’; did you mean ‘pci_write_config_byte’? 
[-Werror=implicit-function-declaration]
    pci_bus_write_config_byte(bus0, devfn,
    ^~~~~~~~~~~~~~~~~~~~~~~~~
    pci_write_config_byte
