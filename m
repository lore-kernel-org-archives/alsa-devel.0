From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] atmel_ssc_dai: a possible sleep-in-atomic bug in
 atmel_ssc_shutdown
Date: Tue, 12 Dec 2017 17:52:04 +0800
Message-ID: <59796efc-8acd-6655-cf59-67c162201bd7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: nicolas.ferre@microchip.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alexandre.belloni@free-electrons.com, sedji.gaouaou@atmel.com
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

According to sound/soc/atmel/atmel_ssc_dai.c, the driver may sleep under 
a spinlock.
The function call path is:
atmel_ssc_shutdown (acquire the spinlock)
   free_irq --> may sleep

I do not find a good way to fix it, so I only report.
This possible bug is found by my static analysis tool (DSAC) and checked 
by my code review.


Thanks,
Jia-Ju Bai
