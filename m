From: Viral Mehta <viral.mehta@einfochips.com>
Subject: Re: [PATCH][SOUND]volume control for CSWITCH and CROUTE
Date: Tue, 07 Apr 2009 10:10:59 +0530
Message-ID: <49DAD95B.5090707@einfochips.com>
References: <49D754C4.2030803@einfochips.com> <s5htz51i3ik.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ahmedabad.einfochips.com (india.einfochips.com [203.88.139.151])
	by alsa0.perex.cz (Postfix) with ESMTP id 67CDC244A8
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Apr 2009 11:24:34 +0200 (CEST)
In-Reply-To: <s5htz51i3ik.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



Takashi Iwai wrote:
> At Sat, 04 Apr 2009 18:08:28 +0530,
> Viral Mehta wrote:
>   
>> From: Deepika Makhija <deepika.makhija@einfochips.com>
>>
>> Added an else part to check 
>> SNDRV_MIXER_OSS_PRESENT_CVOLUME for MIC (slot 7)
>> in commit 36c7b833e5d2501142a371e4e75281d3a29fbd6b
>>
>> Similarly, checks and volume control is required for 
>> SNDRV_MIXER_OSS_PRESENT_CSWITCH and SNDRV_MIXER_OSS_PRESENT_CROUTE
>> as well.
>>
>> Signed-off-by: Deepika Makhija <deepika.makhija@einfochips.com>
>> Signed-off-by: Viral Mehta <viral.mehta@einfochips.com>
>>     
>
> Thanks, applied now to sound git tree.
>
> The original patch wasn't applicable (the file name was wrong) so I
> had to apply the patch manually.  It'd be helpful to test the patch
> before submission at the next time :)
>
>
> Takashi
>   
Thanks for taking care. I am sorry about that mistake.
Yeah, lately I have learned using checkpatch.pl and things which are 
helpful before patch submission.

Thanks again,
Viral
