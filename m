From: Jarkko Nikula <jarkko.nikula@intel.com>
Subject: Re: Intel Baytrail Linux Audio
Date: Thu, 25 Jun 2015 09:38:16 +0300
Message-ID: <558BA1D8.8040508@intel.com>
References: <5589D025.7090700@gmail.com> <20150624101115.GI19530@localhost>
 <558ABDB6.4010702@gmail.com> <20150624160314.GM19530@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 284ED2602AD
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2015 08:38:20 +0200 (CEST)
In-Reply-To: <20150624160314.GM19530@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Tyler Yeomans <tyeo098@gmail.com>
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

On 06/24/2015 07:03 PM, Vinod Koul wrote:
> On Wed, Jun 24, 2015 at 10:24:54AM -0400, Tyler Yeomans wrote:
>> Vinod,
>>
>> Thank you for looking into this.
>> I have attached the dmesg for this device.
>> Please note I have tried kernels 3.16/19 4.0 and 4.1, all with same result.
>> The attached dmesg file is from booting kernel 4.1/amd64:
>> Linux mykro 4.1.0-040100-generic #201506220235 SMP Mon Jun 22
>> 06:36:19 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
>> On Ubuntu 15.04
> I can see these errors:
> [    6.012196] (NULL device *): ipc: error DSP boot timeout
> [    6.012386] byt-rt5640 byt-rt5640: ASoC: CPU DAI baytrail-pcm-audio not
> registered
>
> Jarrko, can you see why DSP boot fails, perhpas some resources are
> missing/wrong
>
Very likely BIOS defines the DSP-host interrupt in another index what 
code is using currently. Could you try does changing irqindex_host_ipc 
from 5 to 0 help? Like how it is done here:

http://mailman.alsa-project.org/pipermail/alsa-devel/2015-June/093129.html

-- 
Jarkko
---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
