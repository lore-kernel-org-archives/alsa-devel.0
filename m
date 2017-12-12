From: Jia-Ju Bai <baijiaju1990@163.com>
Subject: [BUG] sound/soc/samsung: a possible sleep-in-atomic
 bugs in s3c_pcm_hw_params
Date: Tue, 12 Dec 2017 09:24:34 +0800
Message-ID: <bb1c8c1d-4f99-7d47-818c-13e98cd024d5@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m12-16.163.com (m12-16.163.com [220.181.12.16])
 by alsa0.perex.cz (Postfix) with ESMTP id C9A3326705F
 for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2017 02:24:44 +0100 (CET)
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
To: krzk@kernel.org, sbkim73@samsung.com, s.nawrocki@samsung.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

According to sound/soc/samsung/pcm.c, the kernel module may sleep under 
a spinlock.
The function call path is:
s3c_pcm_hw_params (acquire the spinlock)
   clk_get_rate
     clk_core_get_rate
       clk_prepare_lock
         mutex_lock --> may sleep

I do not find a good way to fix it, so I only report.
This possible bug is found by my static analysis tool (DSAC) and my code 
review.


Thanks,
Jia-Ju Bai
