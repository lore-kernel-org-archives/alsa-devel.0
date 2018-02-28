From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Applied "ASoC: topology: Fix logical inversion in
 set_link_hw_format()" to the asoc tree
Date: Tue, 27 Feb 2018 22:22:08 -0800
Message-ID: <d1343157-c310-78e3-1709-2f5baaa5e27c@linux.intel.com>
References: <E1eqGmV-0005Rk-Jt@debutante>
 <20180226183407.22335-1-k.marinushkin@gmail.com>
 <e25d592b-0fab-68f8-d9e0-e5061c54f4e0@linux.intel.com>
 <20180227103848.GA11822@sirena.org.uk>
 <a5bdbfc8-6abd-6757-6afd-68e27d6a9697@linux.intel.com>
 <20180227155758.GD11822@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E8C9267608
 for <alsa-devel@alsa-project.org>; Wed, 28 Feb 2018 07:22:10 +0100 (CET)
In-Reply-To: <20180227155758.GD11822@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Pan Xiuli <xiuli.pan@linux.intel.com>, Kirill Marinushkin <k.marinushkin@gmail.com>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 2/27/18 7:57 AM, Mark Brown wrote:
> On Tue, Feb 27, 2018 at 07:13:17AM -0800, Pierre-Louis Bossart wrote:
>> On 2/27/18 2:38 AM, Mark Brown wrote:
>>> On Mon, Feb 26, 2018 at 06:30:15PM -0800, Pierre-Louis Bossart wrote:
> 
>>>> This issue was found during the development of SOF (Sound Open Firmware)
>>>> where we get the reverse of the intended behavior when using the same
>>>> conventions in topology files as in machine drivers.
> 
>>> Is this perhaps something that the earlier firmware is handling inside
>>> the firmware?
> 
>> For SKL+ the SSP settings come from binary blobs read from ACPI/NHLT tables
>> so I am wondering if this inversion is compensated for in the tools used to
>> generate the blobs.
> 
> Ugh, I'm confused here.  Is this a case of SoF differing from the
> regular firmware somehow - presumably the stuff coming from the NHLT
> table is the same for both firmwares?

no we are not using the NHLT info for now but using the one provided in 
topology files. the SOF firmware does not rely on blobs but programs the 
registers based on masks and settings passed. This difference is 
precisely how we exposed a difference in behavior.
