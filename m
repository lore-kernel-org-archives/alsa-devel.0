From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v1 08/11] ASoC: Intel: Make PCI dependency explicit
Date: Sat, 22 Dec 2018 09:34:57 +0100
Message-ID: <cda9b574-375a-10c7-7a24-9f6fe4aa62b7@kernel.org>
References: <20181222001452.7474-1-okaya@kernel.org>
 <20181222001452.7474-9-okaya@kernel.org>
 <eb27ab03-4f42-2e2e-9873-16d9a6927e2b@infradead.org>
 <CAK9iUCN77U5tQn-WWaL27v244GkEAgRBxKK1H_+xUhOZ2aCERw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK9iUCN77U5tQn-WWaL27v244GkEAgRBxKK1H_+xUhOZ2aCERw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 12/22/2018 7:26 AM, Sinan Kaya wrote:
> On Sat, Dec 22, 2018 at 4:19 AM Randy Dunlap<rdunlap@infradead.org>  wrote:
>> On 12/21/18 4:14 PM, Sinan Kaya wrote:
>>> IOSF_MBI driver depends on CONFIG_PCI set but this is not specified
>>> anywhere.
>> wrong patch description...?
> Not really...
> Code does unconditional select for IOSF_MBI.
> 

I'll put the above comment into the commit message to make this change cleaner.
