From: Hui Wang <hui.wang@canonical.com>
Subject: Re: [PATCH v2] ALSA: hda - Fix Skylake codec timeout
Date: Fri, 17 Jul 2015 08:57:41 +0800
Message-ID: <55A85305.5080802@canonical.com>
References: <1437035964-5658-1-git-send-email-david.henningsson@canonical.com>
 <96A12704CE18D347B625EE2D4A099D19687270@SHSMSX103.ccr.corp.intel.com>
 <55A7CE55.5010700@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B1008260629
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2015 02:57:52 +0200 (CEST)
In-Reply-To: <55A7CE55.5010700@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>, "Yang, Libin" <libin.yang@intel.com>, "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lin, Mengdong" <mengdong.lin@intel.com>, "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

On 07/16/2015 11:31 PM, David Henningsson wrote:
>
>
> On 2015-07-16 17:14, Yang, Libin wrote:
>>> -----Original Message-----
>>> From: David Henningsson [mailto:david.henningsson@canonical.com]
>>> Sent: Thursday, July 16, 2015 4:39 PM
>>> To: tiwai@suse.de; hui.wang@canonical.com; alsa-devel@alsa-
>>> project.org; Yang, Libin; Lin, Mengdong
>>> Cc: David Henningsson
>>> Subject: [PATCH v2] ALSA: hda - Fix Skylake codec timeout
>>>
>>> When the controller is powered up but the HDMI codec is powered
>>> down
>>> on Skylake, the power well is turned off. When the codec is then
>>> powered up again, we need to poke the codec a little extra to make
>>> sure it wakes up. Otherwise we'll get sad "no response from codec"
>>> messages and broken audio.
>>
>> Thanks for finding this issue.
>>
>> Could you please give us you test case? We didn't meet such issue
>> before. I would like do a full test on it.
>
> The test case is:
>
>  - Install Ubuntu 15.04.
>  - Upgrade to kernel 4.1.
>  - Boot the new kernel.
>
> Note: I believe Hui tested with 4.1 and got this error. In my case I 
> have been running a hybrid kernel: Ubuntu 15.04, kernel 3.19.0-23.24 
> (which has a backported i915 driver), and then the alsa-daily DKMS on 
> top of that.
>
> I can email you off-list with details about the machine I tested it 
> on, if you like.
>

Here is a dmesg log, it is generated on a skl laptop with 
drm-intel-nightly kernel (v4.2), searching the keyword "timeout" in the 
text, you will find lots of timeout errors.

http://paste.ubuntu.com/11890651/
