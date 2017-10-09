From: Jia-Ju Bai <baijiaju1990@163.com>
Subject: Re: [PATCH] opl3: Fix a possible sleep-in-atomic bug
 in snd_opl3_find_patch
Date: Mon, 9 Oct 2017 15:51:36 +0800
Message-ID: <45ffdd2f-ad74-c6fe-3788-da3f9e4df625@163.com>
References: <1507516527-4173-1-git-send-email-baijiaju1990@163.com>
 <5146a06e-0199-3d03-b4d6-9a4f71e4c4af@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
 by alsa0.perex.cz (Postfix) with ESMTP id D0938266BFD
 for <alsa-devel@alsa-project.org>; Mon,  9 Oct 2017 09:51:44 +0200 (CEST)
In-Reply-To: <5146a06e-0199-3d03-b4d6-9a4f71e4c4af@ladisch.de>
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
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, o-takashi@sakamocchi.jp, fabf@skynet.be, elfring@users.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thanks for your reply :)
Yes, you are right. Sorry for this false positive.


Thanks,
Jia-Ju Bai

On 2017/10/9 14:32, Clemens Ladisch wrote:
> Jia-Ju Bai wrote:
>> The driver may sleep under a spinlock, and the function call path is:
>> snd_opl3_note_on (acquire the spinlock)
>>    snd_opl3_find_patch
>>      kzalloc(GFP_KERNEL) --> may sleep
> This call path is not possible because create_patch is not set.
>
>
> Regards,
> Clemens
