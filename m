From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Merging the new firmware files for CA0132 into
 alsa-firmware
Date: Tue, 28 May 2019 11:59:03 -0500
Message-ID: <9d5ef75c-9b28-3998-865d-a958b7aaaa75@linux.intel.com>
References: <s5hblzmvdcq.wl-tiwai@suse.de>
 <9668d632-c5c9-5114-39cb-0e8a105a547c@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0D3D2F8065A
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2019 18:59:07 +0200 (CEST)
In-Reply-To: <9668d632-c5c9-5114-39cb-0e8a105a547c@perex.cz>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Connor McAdams <conmanx360@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



On 5/28/19 11:38 AM, Jaroslav Kysela wrote:
> Dne 28. 05. 19 v 16:54 Takashi Iwai napsal(a):
>> Hi,
>>
>> it seems that Connor's previous attempt to put a couple of ca0132
>> firmware files into linux-firmware tree didn't go through,
>> unfortunately.  And now I'm thinking of taking them into alsa-firmware
>> package as a stop-gap.  We already distribute other ca0132 firmware
>> files, so the addition shouldn't be a big problem.
>>
>> Jaroslav, what do you think?
> 
> No problem. The same situation is for the SoC SOF firmware files (drivers are
> in kernel, firmware files are missing). Perhaps, we can release those files
> quickly in alsa-firmware and then migrate them slowly to linux-firmware.

for SOF there are 4 cases

1. developers/integrators build from scratch themselves from the public 
tree.
2. integrators build from scratch with their own secret sauce added.
3. distros want a binary since they don't want to build from source 
and/or don't have access to all the DSP tools
4. distros needs a binary signed with the Intel production key (e.g. to 
run on devices initially designed for Windows).

So far we were mostly dealing with case 1. Case 2 is allowed by the SOF 
permissive license and there's no need to look into this. We are 
planning releases for the last two cases, with a cadence aligned with 
kernel updates. It's not fully clear to me if the linux-firmware tree is 
the 'right' solution since ideally we'd want to have firmware, topology 
and UCM files released at the same time.
