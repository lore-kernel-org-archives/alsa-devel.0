From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] ASoC: intel: make Kconfig selects depend on ACPI
Date: Tue, 29 Mar 2016 12:01:13 -0700
Message-ID: <56FAD0F9.1030708@infradead.org>
References: <56FAB111.2070503@infradead.org>
 <20160329165146.GR2350@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160329165146.GR2350@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: moderated for non-subscribers <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Liam Girdwood <lgirdwood@gmail.com>, Jie Yang <yang.jie@linux.intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On 03/29/16 09:51, Mark Brown wrote:
> On Tue, Mar 29, 2016 at 09:45:05AM -0700, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Prevent SND_SST_IPC_ACPI from being selected when CONFIG_ACPI is
>> not enabled.  This fixes the kconfig warning:
> 
> These are drivers which can't be instantiated without ACPI...
> 

so it sounds like they should depend on ACPI...?

-- 
~Randy
