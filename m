From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] haswell: a possible sleep-in-atomic bug in hsw_irq_thread
Date: Tue, 12 Dec 2017 22:19:42 +0800
Message-ID: <aa7a630d-f3ec-a11d-7ec0-1350c6dea095@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: yang.jie@linux.intel.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

According to sound/soc/intel/haswell/sst-haswell-ipc.c, the driver may 
sleep under a spinlock.
The function call path is:
hsw_irq_thread (acquire the spinlock)
   hsw_process_notification
     hsw_log_message
       mutex_lock --> may sleep

I do not find a good way to fix it, so I only report.
This possible bug is found by my static analysis tool (DSAC) and checked 
by my code review.


Thanks,
Jia-Ju Bai
