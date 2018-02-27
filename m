From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] Applied "ASoC: topology: Fix logical inversion in
 set_link_hw_format()" to the asoc tree
Date: Tue, 27 Feb 2018 07:13:17 -0800
Message-ID: <a5bdbfc8-6abd-6757-6afd-68e27d6a9697@linux.intel.com>
References: <E1eqGmV-0005Rk-Jt@debutante>
 <20180226183407.22335-1-k.marinushkin@gmail.com>
 <e25d592b-0fab-68f8-d9e0-e5061c54f4e0@linux.intel.com>
 <20180227103848.GA11822@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180227103848.GA11822@sirena.org.uk>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Kirill Marinushkin <k.marinushkin@gmail.com>, alsa-devel@alsa-project.org, Pan Xiuli <xiuli.pan@linux.intel.com>, stable@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 2/27/18 2:38 AM, Mark Brown wrote:
> On Mon, Feb 26, 2018 at 06:30:15PM -0800, Pierre-Louis Bossart wrote:
>> On 2/26/18 10:34 AM, Kirill Marinushkin wrote:
> 
>>> According to the comment, the existing functionality works correctly "WRT the
>>> interface". The suggested commit doesn't fix the behaviour: instead, it reverts
>>> the logic to "WRT the codec". But the existing implementation is also valid.
> 
>> Look at all the machine drivers, they always use the mask by looking at the
>> codec side. The comment on top means that the SOC side ('the interface') is
>> the dual of the codec side.
> 
>> This issue was found during the development of SOF (Sound Open Firmware)
>> where we get the reverse of the intended behavior when using the same
>> conventions in topology files as in machine drivers.
> 
> Is this perhaps something that the earlier firmware is handling inside
> the firmware?

For SKL+ the SSP settings come from binary blobs read from ACPI/NHLT 
tables so I am wondering if this inversion is compensated for in the 
tools used to generate the blobs.
