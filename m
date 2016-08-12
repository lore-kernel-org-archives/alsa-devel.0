From: Laura Abbott <labbott@redhat.com>
Subject: Re: Correct modules for Bay Trail MAX98090 soc?
Date: Fri, 12 Aug 2016 08:51:34 -0700
Message-ID: <6c9c0e51-76e1-b887-c5ea-2937bba116f9@redhat.com>
References: <88774f89-ce4a-1877-db49-b018d725f1cd@redhat.com>
 <3a548725-5b52-4b3e-457a-f6ca93645b15@linux.intel.com>
 <20160812095317.GZ9347@sirena.org.uk>
 <4cba0e60-2dd4-38bd-6353-a6bf5b404d75@linux.intel.com>
 <20160812114905.GE9347@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160812114905.GE9347@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Jie Yang <yang.jie@intel.com>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 08/12/2016 04:49 AM, Mark Brown wrote:
> On Fri, Aug 12, 2016 at 06:37:11AM -0500, Pierre-Louis Bossart wrote:
>> On 8/12/16 4:53 AM, Mark Brown wrote:
>>> On Thu, Aug 11, 2016 at 06:31:27PM -0500, Pierre-Louis Bossart wrote:
>
>>>> If you remove support for all other baytrail options this driver should
>>>> still be there and selectable. We just can't support both this driver for
>>>> Chromebooks and the rest for other machines with the same distribution at
>>>> the moment.
>
>>> That sounds like a regression, what's the plan to fix it.
>
>> The simple fix is easy: disable all other codecs and the
>> BYT_MAX98090 option will be enabled. BYT_MAX98090 relies on the 'old'
>> non-dpcm driver which is used only for Chromebooks with Baytrail, which
>> never enable any other codecs, so there was never any issue before.
>
> That's not really that helpful for a distro kernel (this is for Fedora
> AIUI).
>

Yes, this is unfortunate as it means that something is going to lose sound
support in Fedora. :( It's probably going to be the Chromebook unless another
group starts screaming louder.

Thanks,
Laura
