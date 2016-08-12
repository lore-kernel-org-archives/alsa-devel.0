From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] Correct modules for Bay Trail MAX98090 soc?
Date: Fri, 12 Aug 2016 14:26:31 -0500
Message-ID: <390ded29-9be2-ba24-b24e-25ed3db26430@linux.intel.com>
References: <88774f89-ce4a-1877-db49-b018d725f1cd@redhat.com>
 <3a548725-5b52-4b3e-457a-f6ca93645b15@linux.intel.com>
 <20160812095317.GZ9347@sirena.org.uk>
 <4cba0e60-2dd4-38bd-6353-a6bf5b404d75@linux.intel.com>
 <20160812114905.GE9347@sirena.org.uk>
 <6c9c0e51-76e1-b887-c5ea-2937bba116f9@redhat.com>
 <20160812161219.GG9347@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160812161219.GG9347@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Laura Abbott <labbott@redhat.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 8/12/16 11:12 AM, Mark Brown wrote:
> On Fri, Aug 12, 2016 at 08:51:34AM -0700, Laura Abbott wrote:
>> On 08/12/2016 04:49 AM, Mark Brown wrote:
>
>>> That's not really that helpful for a distro kernel (this is for Fedora
>>> AIUI).
>
>> Yes, this is unfortunate as it means that something is going to lose sound
>> support in Fedora. :( It's probably going to be the Chromebook unless another
>> group starts screaming louder.
>
> Debian will be in the same boat too, there's another release coming
> soon.

It's not necessarily terribly complicated to enable this codec:
- we could borrow code from the existing code from the 
cht_bsw_max98090_ti machine driver which relies on the dpcm driver.
- the patches developed for Baytrail-Cr will provide support for the 
19.2MHz MCLK needed by this codec, they should land on the alsa-devel 
mailing list this afternoon or early next week.
The main issue is to find hardware and someone with bandwidth to do the 
changes.
