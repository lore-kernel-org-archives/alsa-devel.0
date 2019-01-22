From: Sameer Pujar <spujar@nvidia.com>
Subject: Re: [PATCH 6/7] ALSA: hda/tegra: fix kernel panic
Date: Tue, 22 Jan 2019 09:11:16 +0530
Message-ID: <3f222d50-67eb-c96f-7c0c-b47468cd1b00@nvidia.com>
References: <1548092497-5459-1-git-send-email-spujar@nvidia.com>
 <1548092497-5459-7-git-send-email-spujar@nvidia.com>
 <s5hpnspya2t.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com [216.228.121.64])
 by alsa0.perex.cz (Postfix) with ESMTP id E03752667E7
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 04:41:23 +0100 (CET)
In-Reply-To: <s5hpnspya2t.wl-tiwai@suse.de>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org


On 1/22/2019 2:58 AM, Takashi Iwai wrote:
> On Mon, 21 Jan 2019 18:41:36 +0100,
> Sameer Pujar wrote:
>> Kernel panic is seen during device boot. It appears that before the
>> probe completes, runtime callbacks happen and the device setup is not
>> done yet. This could be initiated from framework through exposed
>> callbacks. This issue can be fixed by having a flag to indicate
>> completion of device probe. Hence 'probed' flag is introduced to notify
>> completion of probe and runtime callbacks can check this flag before
>> doing any device access.
> Such a fix should be rather folded into the previous, especially if
> you know it's already broken :)
Ok, I will meld this with previous commit.
>
> And, IMO, it's better to put such a check into runtime_idle callback
> instead of doing in each (runtime_)suspend/resume callback.
Check in runtime_idle would take care of suspend path. But how the check in
runtime_resume can be avoided? Kernel panic happened during 
runtime_resume().
>
>
> thanks,
>
> Takashi

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
