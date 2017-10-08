From: Jia-Ju Bai <baijiaju1990@163.com>
Subject: [BUG] haswell: A possible sleep-in-atomic bug in
	hsw_irq_thread
Date: Sun, 8 Oct 2017 23:06:38 +0800
Message-ID: <0ba5fa3a-1202-752f-e7f2-5d689b6a9e7c@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D228266C2E
 for <alsa-devel@alsa-project.org>; Sun,  8 Oct 2017 17:06:45 +0200 (CEST)
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
To: yang.jie@linux.intel.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

According to sst-haswell-ipc.c, the driver may sleep under a spinlock,
and the function call path is:
hsw_irq_thread (acquire the spinlock)
   hsw_process_notification
     hsw_log_message
       mutex_lock --> may sleep

This bug is found by my static analysis tool and my code review.


Thanks,
Jia-Ju Bai
