From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] linux-next: Tree for Dec 21
 (SND_HDA_INTEL_DSP_DETECTION)
Date: Fri, 21 Dec 2018 14:39:11 -0600
Message-ID: <ff6289e5-64c8-5787-0556-4e339205b5f6@linux.intel.com>
References: <20181221193244.3a6ed685@canb.auug.org.au>
 <4d04710b-d661-fea7-2542-8e9c46f59173@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4d04710b-d661-fea7-2542-8e9c46f59173@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, moderated for non-subscribers <alsa-devel@alsa-project.org>, Jie Yang <yang.jie@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


On 12/21/18 12:02 PM, Randy Dunlap wrote:
> On 12/21/18 12:32 AM, Stephen Rothwell wrote:
>> Hi all,
>>
>> News: there will be no linux-next release until Jan 2.  Have a good break.
>>
>> Changes since 20181220:
>>
> on x86_64:
>
> A new group of Kconfig "select"s is causing kconfig warnings:
>
> WARNING: unmet direct dependencies detected for SND_HDA_INTEL_DSP_DETECTION_CFL
>    Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_HDA [=n] && SND_HDA_INTEL [=n]
>    Selected by [y]:
>    - SND_SOC_INTEL_SKYLAKE_COMMON [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_INTEL_SST_TOPLEVEL [=y] && SND_SOC_INTEL_SKYLAKE_FAMILY [=y] && SND_SOC_INTEL_CFL [=y]

Ack, thanks for the report. This shouldn't have any functional impact 
but we can easily remove the warnings. will send a patch shortly.

-Pierre
