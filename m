From: Jia-Ju Bai <baijiaju1990@163.com>
Subject: Re: [PATCH] sound/pci/riptide or
 drivers/base/firmware: Fix a possible sleep-in-atomic bug
Date: Mon, 9 Oct 2017 15:55:53 +0800
Message-ID: <517bc0db-4cc9-ab45-c53a-dcfe753fb896@163.com>
References: <1507515196-3241-1-git-send-email-baijiaju1990@163.com>
 <s5h4lr8om6p.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 89924266BFD
 for <alsa-devel@alsa-project.org>; Mon,  9 Oct 2017 09:55:59 +0200 (CEST)
In-Reply-To: <s5h4lr8om6p.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: fabf@skynet.be, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, tiwai@suse.com, dhowells@redhat.com, mcgrof@kernel.org, bhumirks@gmail.com
List-Id: alsa-devel@alsa-project.org

Thanks for your reply :)
Yes, you are right. Sorry for this false positive.


Thanks,
Jia-Ju Bai

On 2017/10/9 14:43, Takashi Iwai wrote:
> On Mon, 09 Oct 2017 04:13:16 +0200,
> Jia-Ju Bai wrote:
>> The riptide driver may sleep under a spinlock, and the function call path is:
>> snd_riptide_prepare (acquire the spinlock)
>>    setsampleformat
>>      sendcmd
>>        riptide_reset
>>          try_to_load_firmware
>>            request_firmware
>>              _request_firmware (drivers/base/firmware_class.c)
>>                _request_firmware_prepare
>>                  kzalloc(GFP_KERNEL) --> may sleep
>>
>> To fix it, GFP_KERNEL is replaced with GFP_ATOMIC in _request_firmware_prepare.
>> This bug is found by my static analysis tool and my code review.
>>
>> Signed-off-by: Jia-Ju Bai<baijiaju1990@163.com>
> This doesn't happen.  try_to_load_firmware() aborts before the
> request_firmware() call when chip == NULL, which is the case from
> sendcmd().
