From: Jia-Ju Bai <baijiaju1990@163.com>
Subject: [BUG] sound/core/seq: A possible sleep-in-atomic bug
 in snd_virmidi_dev_receive_event
Date: Mon, 9 Oct 2017 10:42:15 +0800
Message-ID: <a3e0863a-c47e-de76-828d-2dcd4b2b18a0@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F1DA266CE2
 for <alsa-devel@alsa-project.org>; Mon,  9 Oct 2017 04:42:20 +0200 (CEST)
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
To: perex@perex.cz, tiwai@suse.com, o-takashi@sakamocchi.jp, mingo@kernel.org, danielmentz@google.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

According to seq_virmidi.c, the driver may sleep under a read spinlock.
The function call path is:
snd_virmidi_dev_receive_event (acquire the spinlock)
   snd_seq_dump_var_event
     copy_from_user --> may sleep

This bug is found by my static analysis tool and my code review.


Thanks,
Jia-Ju Bai
